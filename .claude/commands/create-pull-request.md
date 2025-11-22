---
allowed_tools: mcp__github__create_pull_request, Bash(git:*)
description: "create pull request"
---

# Pull Request 作成

## 内容

現在のブランチの内容を GitHub 上にプルリクエストとして作成してください。
対象のリポジトリは `chouxcreams/dotfiles` です。

## 作業手順

- プルリクエストは `mcp__github__create_pull_request` で作成する
  - プルリクエストの body は @.github/PULL_REQUEST_TEMPLATE.md をベースに可能な範囲の項目を入力する
- 変更内容は、`git_diff` で最新の main ブランチとの差分を取得し、その内容の要約をプルリクエストの body に記載する
- プルリクエストは必ず draft で作成する
