# chouxcreams/dotfiles

## リポジトリ概要

このリポジトリは、chouxcreamsさんの様々な開発ツールや環境設定用のdotfilesを管理するためのものです。主にmacOSをターゲットとし、zshをシェルとして使用する環境向けに最適化されています。

[![lint](https://github.com/chouxcreams/dotfiles/actions/workflows/lint.yml/badge.svg)](https://github.com/chouxcreams/dotfiles/actions/workflows/lint.yml)
[![macos](https://github.com/chouxcreams/dotfiles/actions/workflows/macos.yml/badge.svg)](https://github.com/chouxcreams/dotfiles/actions/workflows/macos.yml)
[![editorconfig](https://github.com/chouxcreams/dotfiles/actions/workflows/editorconfig.yml/badge.svg)](https://github.com/chouxcreams/dotfiles/actions/workflows/editorconfig.yml)
[![yamlfmt](https://github.com/chouxcreams/dotfiles/actions/workflows/yamlfmt.yml/badge.svg)](https://github.com/chouxcreams/dotfiles/actions/workflows/yamlfmt.yml)

## インストール方法

```shell
git clone git@github.com:chouxcreams/dotfiles.git ~ # ホームディレクトリにクローン
make init # 初期化スクリプトを実行
```

## リポジトリ構造

このリポジトリは主に以下のディレクトリから構成されています：

- `config/`: 各種アプリケーションやツールの設定ファイル
  - `homebrew/`: Homebrewの設定（Brewfile）
  - `git/`: Gitの設定とカスタムサブコマンド
  - `sheldon/`: zshプラグイン管理システムの設定
  - `zsh/`: zsh関連の設定
  - その他多数のツール設定（starship, atuin, bat, ripgrep, micro, など）
- `scripts/`: セットアップや補助用の各種スクリプト
  - `completion.zsh`: コマンド補完の設定
  - `dropbox.sh`: Dropboxのセットアップ
  - `macos.sh`: macOSの環境設定

## 主な機能

1. **統合管理システム**: `make init` → `task update`でセットアップが完結
2. **Homebrew統合**: 必要なパッケージを一括でインストール
3. **zshプラグイン管理**: sheldonを使用した高速なプラグイン管理
   - zsh-defer: プラグインの遅延読み込みで起動を高速化
   - zsh-completions: 充実した補完機能
   - fast-syntax-highlighting: コマンド入力時のシンタックスハイライト
   - その他多数のプラグインによる機能強化
4. **XDG Base Directory対応**: 可能な限り~/.configへの設定ファイル集約
5. **Git拡張**: 便利なGitサブコマンドと設定
6. **ターミナル環境強化**: micro, bat, eza, atuin, fzf, navi等のモダンなツール導入

## 重要なツール

- **task**: タスクランナー（makeの代替）で依存関係を管理
- **sheldon**: zshプラグイン管理システム
- **atuin**: シェルヒストリの保存と検索を強化
- **starship**: カスタマイズ可能なプロンプト
- **micro**: 直感的なターミナルエディタ
- **fzf**: 強力なファジーファインダー
- **eza**: ls代替の高機能ファイル一覧表示
- **navi**: インタラクティブチートシート

## 開発とアップデート

- コアとなる設定ファイルの更新: `task update`
- Brewによるツールの更新: `task upgrade`
- zshの起動時間計測: `task benchmark`

## アシスタントへの指示

このリポジトリに関する質問や変更を行う際は、以下の点に注意してください：

1. XDG Base Directory仕様を尊重する
2. できる限り既存の構造・命名規則に合わせる
3. zshプラグインを追加する場合はsheldonの設定を更新
4. パッケージの追加はHomebrewを使用
5. タスク関連の更新はTaskfile.dist.ymlに記述
6. 設定ファイルの変更は適切なシンボリックリンク処理が必要
