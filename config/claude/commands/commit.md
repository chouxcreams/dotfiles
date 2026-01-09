---
allowed_tools: Bash(git:*)
description: "現在の修正内容をコミットします"
model: "claude-sonnet-4-5" 
---

# Commit

## 内容

現在の修正内容を git にコミットしてください。
コミットメッセージは日本語で記載してください。
conventional commit の形式に従ってください。

### 手順

1. git status, git diff で現在の変更内容を確認する
2. git add でステージングする
3. 確認した変更内容をもとにコミットメッセージを作成し、コミットする

### conventional commit の形式

conventional commit の形式は以下の通りです。

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

#### type の例

- feat: 新機能の追加
- fix: バグ修正
- docs: ドキュメントのみの変更
- style: フォーマットの修正（コードの動作に影響しない変更）
- refactor: リファクタリング（機能追加やバグ修正を含まない変更）
- perf: パフォーマンス向上
- test: テスト追加・修正
- chore: ビルドプロセスや補助ツールの変更

#### scope について

`scope` は変更の影響範囲を示します（例: api, model, service など）。省略可能です。

#### description について

変更内容を簡潔に日本語で記載してください。

#### 例

```
feat(api): 記事検索APIにフィルタ機能を追加

記事検索APIでカテゴリによるフィルタリングが可能になりました。
```

---

以上の形式に従い、コミットメッセージを作成してください。
