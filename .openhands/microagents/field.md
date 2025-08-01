---
triggers:
- field
---

---

# Tree-sitterとast-grepにおける`field`の比較と活用

## 🧠 Tree-sitterにおける`field`

### 定義
- Tree-sitterでは、構文木のノードに**意味的なラベル**を付けるために`field`を使用。
- 文法定義ファイル（`grammar.js`）で、構文要素に名前を付ける。

### 例

```js
function_declaration: seq(
  'function',
  field('name', $.identifier),
  field('parameters', $.parameter_list),
  field('body', $.block)
)
```

この例では、関数名、引数、関数本体にそれぞれ`name`、`parameters`、`body`というフィールド名が付けられています。

---

## 🔍 ast-grepにおける`field`（**relational ruleの一部**）

### 定義
- `ast-grep`では、**親ノードとその子ノードの関係性**を定義するために`field`を使用。
- 特定のフィールドにマッチする子ノードを指定することで、構文木の**構造的な条件**を記述できる。

### 使い方（例）

```yaml
rule:
  kind: function_declaration
  field:
    name:
      regex: '^get.*'
```

この例では、`function_declaration`ノードの`name`フィールドにある識別子が `"get"` で始まる関数だけにマッチします。

### 主な用途
- **構造的な検索**：親ノードの中の特定のフィールドに対して条件を課す。
- **柔軟なルール定義**：フィールドごとに異なるマッチ条件を設定可能。
- **再利用性の高いルール**：複雑な構文構造にも対応できる。

---

## 🧩 両者の関係性と違い

| 項目 | Tree-sitter | ast-grep |
|------|-------------|----------|
| `field`の役割 | 構文木ノードに名前を付ける | 特定のフィールドに対するマッチ条件を定義 |
| 定義場所 | `grammar.js` | ルールファイル（YAML/JSON） |
| 主な目的 | 構文木の意味付け | 構文木の構造的な検索 |
| 依存関係 | 独立して定義 | Tree-sitterのフィールド定義に依存 |

---

## ✅ まとめ

- **Tree-sitter**の`field`は構文木の**意味的な構造**を定義するためのもの。
- **ast-grep**の`field`は、その構造を活用して**構文的に正確な検索条件**を記述するためのもの。
- 両者を組み合わせることで、**高精度なコード解析・リファクタリングルール**を構築可能。

---


