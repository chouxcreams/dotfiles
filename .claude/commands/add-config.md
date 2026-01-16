---
allowed_tools: Write, Read, Edit, Bash(mkdir:*), Bash(mv:*), Bash(ls:*), Bash(test:*)
description: "新しい設定ファイルをconfig/に追加します"
---

# 設定ファイル追加

## 内容

このdotfilesリポジトリに新しいアプリケーションの設定を追加します。

## 手順

1. アプリケーション名を確認する（引数または対話で取得）
2. `~/.config/<app-name>` に既存の設定があるか確認
3. 既存設定の処理:
   - **ある場合**: `config/<app-name>/` に移動（mv）
   - **ない場合**: 設定ファイル形式を確認し、テンプレートを作成
4. `.mise/tasks/symlink` にシンボリックリンクコマンドを追加
5. 完了メッセージを表示（`task symlink` の実行を促す）

## 既存設定の確認

```bash
# 確認コマンド
ls -la ~/.config/<app-name>
```

既存設定がある場合は以下を実行:
```bash
mv ~/.config/<app-name> /home/shutarou/src/github.com/chouxcreams/dotfiles/config/
```

## 設定ファイル形式（新規作成時）

### TOML (config.toml)
- 使用例: atuin, mise, sheldon, aerospace

### YAML (config.yml)
- 使用例: lazygit, navi, zeno

### JSON (settings.json)
- 使用例: claude, zed, micro

## symlinkスクリプトへの追加

`.mise/tasks/symlink` ファイルを編集し、適切な位置にシンボリックリンクコマンドを追加する。

### 追加位置の判断

- **共通設定（OS問わず）**: 53行目付近（`ln -sfv ... tmux` の後）
- **macOS専用**: `Darwin)` ブロック内（65-67行目付近）
- **Linux専用**: `Linux)` ブロック内（72-82行目付近）

### 追加するコマンド形式

ディレクトリの場合:
```bash
ln -sfv "$DOTFILES_CONFIG_DIR"/<app-name> "$XDG_CONFIG_HOME"
```

単独ファイルの場合:
```bash
ln -sfv "$DOTFILES_CONFIG_DIR"/<app-name>.toml "$XDG_CONFIG_HOME"/<app-name>.toml
```

## 完了後のメッセージ

設定ファイルの追加が完了したら、以下を伝える:
- `task symlink` を実行してシンボリックリンクを作成してください
