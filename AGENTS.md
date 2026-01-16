# CLAUDE.md

このファイルは、Claude Code (claude.ai/code) がこのリポジトリで作業する際のガイダンスを提供します。

## 重要事項

- 日本語を使ってください

## 主要コマンド

- `make init` - dotfilesセットアップ全体の初期化
- `task update` - 全設定とシンボリックリンクの更新
- `task upgrade` - Homebrewとmiseパッケージのアップデート
- `task benchmark` - zsh起動時間のパフォーマンス測定
- `task symlink` - 設定ファイルへのシンボリックリンク作成/更新

## プロジェクト構成

これはzshを使用するmacOS/Linux環境を対象とした包括的なdotfilesリポジトリです。多層ビルドシステムを使用しています：

1. **Make → Task → サブタスク**: エントリーポイントはMakefileで、go-taskに処理を委譲し、サブディレクトリからのincludeを管理
2. **XDG Base Directory準拠**: 全設定は`config/`下に整理され、`~/.config/`にシンボリックリンク
3. **クロスプラットフォーム対応**: macOS（Aerospace、Borders）とLinux（Hyprland、Rofi）の条件分岐ロジック

### 主要コンポーネント

- **mise**: ツールバージョン管理（config/mise/config.toml）- プログラミング言語とCLIツールを管理
- **sheldon**: パフォーマンス向上のための遅延読み込み機能付きzshプラグイン管理
- **Homebrew**: Brewfileによるパッケージ管理
- **カスタムGitコマンド**: config/git/subcommand/に配置

### 設定管理

全アプリケーション設定は`config/`ディレクトリに配置され、`.mise/tasks/symlink`スクリプトでシンボリックリンクされます。シンボリックリンクプロセス：
1. XDGディレクトリの作成
2. OS検出に基づく設定のリンク
3. 特殊ケースの処理（1Passwordソケット、zshenv）

### Zshプラグインシステム

sheldonで管理され、プラグインは以下のように整理されています：
- `sync/`: 即座に読み込まれるプラグイン  
- `defer/`: 高速起動のために非同期読み込みされるプラグイン

主要プラグインにはzsh-completions、fast-syntax-highlighting、各種ユーティリティツールが含まれます。

## 開発ガイドライン

- XDG Base Directory仕様を尊重する
- 既存の命名規則と構造を使用する
- 新しいパッケージはHomebrew Brewfileで追加する
- 新しいタスクはTaskfile.dist.ymlに登録する
- 新しい設定については.mise/tasks/symlinkでシンボリックリンクの更新を確実に行う
