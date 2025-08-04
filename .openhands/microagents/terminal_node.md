---
triggers:
- terminal
- literal
---

---



## ✅ `always_ff` は **リテラル文字列（literal string）**

`tree-sitter-systemverilog/grammar.js` の定義：

```js
always_keyword: $ => choice('always', 'always_comb', 'always_latch', 'always_ff'),
```

このように `choice` の中で `'always_ff'` を直接指定している場合、`tree-sitter` はそれを **literal terminal node** として扱います。ただし、構文木上ではこのリテラルは **`always_keyword` という名前のノード**にラップされます。

---

## 🔍 構文木の構造（イメージ）

たとえば、以下の SystemVerilog コード：

```systemverilog
always_ff @(posedge clk) q <= d;
```

は、`tree-sitter` によって次のような構文木になる可能性があります：

```
(always_construct
  (always_keyword) ["always_ff"]
  (statement ...))
```

ここで：

- `always_construct` は構文ルール（named node）
- `always_keyword` はその中のサブノード（named node）
- `"always_ff"` は `always_keyword` ノードの中の **テキスト値（literal string）**

---

## 🧠 まとめ

| 要素 | tree-sitter上の分類 | 備考 |
|------|----------------------|------|
| `always_construct` | named node | 構文ルール |
| `always_keyword` | named node | キーワードをまとめる抽象ノード |
| `"always_ff"` | literal string | 実際のキーワード文字列 |

---

## 🛠️ `ast-grep` での扱い

`ast-grep` では、`always_ff` を直接 `kind` で指定することはできません。代わりに、以下のように `kind` と `regex` を使って `"always_ff"` を検出できます：

```yaml
- kind: always_construct
- regex: "always_ff"
```
