#!/usr/bin/env bash
set -euo pipefail

# gwqでブランチ+worktreeを作成し、このスクリプトを実行しているペインが属する
# ウインドウ/タブ（= Claude Codeセッションの場所）にペインを開く。
# マルチプレクサは自動判定: HERDR_ENV=1 ならherdr、TMUXが設定されていればtmux。
# usage: create-worktree-pane.sh <branch> [-v] [-p <prompt>]
#   -v          上下分割（デフォルトは左右分割）
#   -p <prompt> 指示をworktree内の .claude-task.md に書き出し、ペイン作成後に
#               claudeを起動してそのファイルに従うよう指示する

usage() {
  echo "usage: $(basename "$0") <branch> [-v] [-p <prompt>]" >&2
  exit 1
}

[ $# -ge 1 ] || usage
branch="$1"
shift

vertical=0
prompt=""
while getopts "vp:" opt; do
  case "$opt" in
    v) vertical=1 ;;
    p) prompt="$OPTARG" ;;
    *) usage ;;
  esac
done

if [ "${HERDR_ENV:-}" = "1" ]; then
  mux="herdr"
elif [ -n "${TMUX:-}" ]; then
  mux="tmux"
else
  echo "error: tmuxまたはHerdrのセッション内で実行してください" >&2
  exit 1
fi
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "error: gitリポジトリ内で実行してください" >&2
  exit 1
fi

resolve_path() {
  gwq list --json | jq -r --arg b "$branch" '.[] | select(.branch == $b) | .path' | head -n1
}

# 既にworktreeが存在する場合はそれを再利用する（冪等にするため）
path="$(resolve_path)"

if [ -z "$path" ]; then
  if git show-ref --verify --quiet "refs/heads/$branch"; then
    gwq add "$branch"
  else
    gwq add -b "$branch"
  fi
  path="$(resolve_path)"
fi

if [ -z "$path" ] || [ ! -d "$path" ]; then
  echo "error: worktreeのパスを取得できませんでした: $branch" >&2
  exit 1
fi

# 指示はclaudeコマンドの引数に直接渡さず、worktree内の .claude-task.md に書き出す。
# 長文・複数行の指示もクオートを気にせず渡せて、後から指示内容をファイルで確認できる。
# ペイン作成前に書き出すことで、claude起動時には必ずファイルが存在する。
if [ -n "$prompt" ]; then
  printf '%s\n' "$prompt" > "$path/.claude-task.md"
fi

claude_cmd="claude '.claude-task.md を読んで、そこに書かれた指示に従って作業してください。'"

if [ "$mux" = "herdr" ]; then
  # --current で「このスクリプトを実行しているペイン（= Claude Codeセッション）」を分割する。
  # ターゲット省略だとUIフォーカス中のペインが分割され、ユーザーが別タブを見ていた場合に
  # 意図しない場所にペインができる。--no-focus でユーザーのフォーカスは動かさない。
  if [ "$vertical" = 1 ]; then direction="down"; else direction="right"; fi
  pane_id="$(herdr pane split --current --direction "$direction" --cwd "$path" --no-focus | jq -r '.result.pane.pane_id')"
  if [ -z "$pane_id" ] || [ "$pane_id" = "null" ]; then
    echo "error: herdrのペイン作成に失敗しました" >&2
    exit 1
  fi
  if [ -n "$prompt" ]; then
    # pane runはコマンド文字列+Enterをtty入力として送る。シェルの起動完了を待たず
    # キューされるため、シェルが立ち上がり次第claudeが実行される。
    # 起動したclaudeはherdrがagentとして自動認識するので、以降は
    # `herdr agent read <pane_id>` 等で状態を確認できる。
    herdr pane run "$pane_id" "$claude_cmd" >/dev/null
  fi
else
  if [ "$vertical" = 1 ]; then split_flag="-v"; else split_flag="-h"; fi
  # -t $TMUX_PANE で「このスクリプトを実行しているペイン（= Claude Codeセッション）が属するウインドウ」を
  # 分割する。-t なしだとユーザーが現在表示中のウインドウが分割されてしまい、
  # ユーザーが別ウインドウに切り替えていた場合に意図しない場所にペインができる。
  if [ -n "${TMUX_PANE:-}" ]; then
    pane_id="$(tmux split-window "$split_flag" -t "$TMUX_PANE" -c "$path" -P -F '#{pane_id}')"
  else
    pane_id="$(tmux split-window "$split_flag" -c "$path" -P -F '#{pane_id}')"
  fi
  # send-keysはシェルの起動完了を待たずtty入力としてキューされるため、
  # 新ペインのシェルが立ち上がり次第claudeが実行される。
  if [ -n "$prompt" ]; then
    tmux send-keys -t "$pane_id" -l "$claude_cmd"
    tmux send-keys -t "$pane_id" Enter
  fi
fi

echo "mux: $mux"
echo "worktree: $path"
echo "pane: $pane_id"
if [ -n "$prompt" ]; then
  echo "task file: $path/.claude-task.md"
  echo "claude: launched"
fi
