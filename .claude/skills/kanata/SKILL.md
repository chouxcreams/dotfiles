---
name: kanata-config
description: kanata設定のヘルプ。キーリマップ、レイヤー設定、tap-hold設定の質問に使用。
allowed-tools: Read, Grep, Glob
---

# kanata設定スキル

このdotfilesリポジトリのkanata設定をサポートします。

## 概要

kanataはRust製のクロスプラットフォームキーボードリマッパーです。Linux、macOS、Windowsで動作し、S式ベースの設定ファイルでキーリマップやレイヤー切り替えを定義します。

## 設定構成

- **設定ディレクトリ**: `config/kanata/`
- **設定ファイル拡張子**: `.kbd`
- **構文**: S式（Lispライクな括弧記法）

## 設定ファイルの主要セクション

### defcfg - グローバル設定

```kbd
(defcfg
  process-unmapped-keys yes
  danger-enable-cmd yes  ;; コマンド実行を許可（必要な場合のみ）
)
```

### defsrc - 物理キー配列の定義

```kbd
(defsrc
  grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
  tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
  caps a    s    d    f    g    h    j    k    l    ;    '    ret
  lsft z    x    c    v    b    n    m    ,    .    /    rsft
  lctl lmet lalt           spc            ralt rmet rctl
)
```

### deflayer - レイヤー定義

```kbd
(deflayer base
  grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
  tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
  @cap a    s    d    f    g    h    j    k    l    ;    '    ret
  lsft z    x    c    v    b    n    m    ,    .    /    rsft
  lctl lmet lalt           spc            ralt rmet rctl
)
```

### defalias - エイリアス定義

```kbd
(defalias
  cap (tap-hold 200 200 esc lctl)  ;; Caps→短押しEsc/長押しCtrl
  nav (layer-toggle navigation)     ;; レイヤー切り替え
)
```

## よく使う機能パターン

### tap-hold（短押し/長押しの使い分け）

```kbd
;; (tap-hold タップタイムアウト ホールドタイムアウト タップ時 ホールド時)
(defalias
  a_ct (tap-hold 200 200 a lctl)    ;; a/Ctrl
  s_al (tap-hold 200 200 s lalt)    ;; s/Alt
  d_mt (tap-hold 200 200 d lmet)    ;; d/Super
  f_sf (tap-hold 200 200 f lsft)    ;; f/Shift
)
```

### レイヤー切り替え

```kbd
(defalias
  nav (layer-toggle nav)    ;; 押している間だけ有効
  num (layer-switch num)    ;; 切り替え後そのまま維持
)
```

### マクロ

```kbd
(defalias
  arr (macro - > spc)       ;; "-> " を入力
  fat (macro = > spc)       ;; "=> " を入力
)
```

## 参考リンク

- GitHub: https://github.com/jtroo/kanata
- 設定ガイド: https://github.com/jtroo/kanata/blob/main/docs/config.adoc
