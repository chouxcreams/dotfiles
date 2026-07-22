---
name: create-workspace
description: Create a git branch and worktree with gwq, open a new pane next to the current Claude Code session (tmux or Herdr — auto-detected), and optionally launch Claude in that pane with an initial instruction. Use this whenever the user wants to start working on a new branch or feature in a separate worktree, delegate a task to another Claude session in a new worktree, or mentions gwq, worktree, ワークツリー, 「ブランチを切って作業したい」「worktreeを作って」「ペインで開いて」「別のClaudeに任せて」 — even if they don't say "tmux" or "herdr" explicitly.
---

# gwqでworktreeを作成し、ペインでClaudeに作業を任せる

新しいブランチとworktreeをgwqで作成し、**現在のClaude Codeセッションのすぐ隣**に新しいペインを開きます。さらに `-p` オプションでそのペイン内でclaudeを起動し、最初の指示まで渡せます。

スクリプトはマルチプレクサを自動判定します：
- `HERDR_ENV=1` なら **Herdr**（`herdr pane split --current` で、Claude Codeが動いているペインを分割）
- `TMUX` が設定されていれば **tmux**（`$TMUX_PANE` でClaude Codeのウインドウを特定して分割）

どちらの場合も、ユーザーが別のウインドウ/タブを見ていても正しい場所にペインが作られます。あなたが判定を行う必要はなく、スクリプトを実行するだけで適切な方が使われます。

## 手順

バンドルされたスクリプトを実行するだけで完了します：

```bash
# worktree + ペイン作成のみ
~/.config/claude/skills/create-workspace/scripts/create-worktree-pane.sh <ブランチ名>

# worktree + ペイン作成 + 新ペインでclaudeを起動して指示を渡す
# 指示はworktree直下の .claude-task.md に書き出され、claudeはそのファイルを読んで作業を始める
~/.config/claude/skills/create-workspace/scripts/create-worktree-pane.sh <ブランチ名> -p '<claudeへの指示>'
```

- 上下分割にしたい場合は `-v` を付けてください（デフォルトは左右分割）。
- スクリプトは冪等です。worktreeが既に存在する場合は再作成せず、そのディレクトリでペインを開くだけです。ブランチが既に存在する場合は新規作成せずそのブランチのworktreeを作ります。
- 作成後、使われたマルチプレクサ（`mux:`）、worktreeのパス、ペインIDが出力されます。ユーザーにworktreeのパスを伝えてください。

## Claudeに指示を出すかどうかの判断

- ユーザーが「〜をやらせて」「claudeに指示して」など、新しいworktreeでの**作業内容まで**伝えてきた場合は `-p` を使ってください。
- worktreeを用意してほしいだけ（作業はユーザー自身がやる）の場合は `-p` なしで実行してください。迷ったら `-p` なしです。

### 指示プロンプトの書き方

- 新ペインのclaudeは**この会話のコンテキストを一切持ちません**。ブランチの目的・やるべきこと・前提条件をプロンプトに自己完結で含めてください。
- 指示は `.claude-task.md` というファイルとして渡されるので、Markdownで構造化された長文を書いても問題ありません。複雑なタスクほど、背景・要件・完了条件をしっかり書いてください。
- 例: `-p 'このworktree (feature/fzf-config) でfzfの設定をconfig/に追加してください。既存の設定構成とCLAUDE.mdの規約に従ってください。'`

### 起動確認

`-p` を使った場合、必要に応じて数秒待ってからペインの状態を確認できます。スクリプト出力の `mux:` 行に応じてコマンドを選んでください：

```bash
# mux: herdr の場合
sleep 5 && herdr pane read <ペインID> --source recent-unwrapped --lines 20

# mux: tmux の場合
sleep 5 && tmux capture-pane -t <ペインID> -p | tail -20
```

claudeが起動して指示に応答し始めていればOKです。確認結果をユーザーに報告してください。

Herdrの場合は起動したclaudeがagentとして自動認識されるため、その後の連携（完了待ち・追加指示）には agent サーフェスも使えます：

```bash
herdr agent wait <ペインID> --timeout 600000   # idle/done/blockedになるまで待つ
herdr agent read <ペインID> --source recent-unwrapped --lines 120
herdr agent prompt <ペインID> '<追加の指示>' --wait
```

## ブランチ名の決め方

- ユーザーがブランチ名を指定した場合はそれをそのまま使ってください。
- 作業内容だけ伝えられた場合は、リポジトリの既存ブランチの命名規則（`git branch -a` で確認できます）に合わせて短い英語のブランチ名を提案してください。規則が読み取れない場合は `feature/<短いスラッグ>` 形式にしてください。

## 知っておくべき挙動

- 新規ブランチは**現在のHEADから**作成されます。最新のリモートmainから切りたい場合は、先に `git fetch origin` した上で `git branch <ブランチ名> origin/main` でブランチを作ってからスクリプトを実行してください（既存ブランチとして扱われ、そこからworktreeが作られます）。
- worktreeの作成先パスはgwqの設定（`~/.config/gwq/config.toml` の naming template）で決まります。リポジトリごとの `setup_commands` や `copyfiles` も gwq が自動で実行するので、スクリプト側での対応は不要です。
- `-p` の指示はclaudeコマンドの引数に直接渡されるのではなく、worktree直下の `.claude-task.md` に書き出されます。新ペインでは「`.claude-task.md` を読んで指示に従って」という固定プロンプト付きでclaudeが起動します（tmuxは `send-keys`、Herdrは `pane run`。どちらもtty入力としてキューされるため、シェルの起動完了を待つ必要はありません）。
- `.claude-task.md` はglobal gitignore（`config/git/ignore`）に登録済みなので、誤ってコミットされる心配はありません。worktreeを `gwq remove` すればファイルも一緒に消えます。
- Herdrでは `--no-focus` でペインを作るため、ユーザーのフォーカスは現在のペインに残ります。新ペインはサイドバー/タブ内に現れます。
- tmux/Herdrいずれのセッション内でもない場合、またはgitリポジトリ外で実行するとエラーで止まります。マルチプレクサ外の場合はペインは作れないので、worktreeのパスを案内して `cd` してもらってください。

## 後片付け

作業が終わったworktreeは `gwq remove <ブランチ名>` で削除できます。ユーザーに聞かれたら案内してください。Herdrで開いたペインは `herdr pane close <ペインID>` で閉じられます（自分が作ったペインだけを閉じること）。
