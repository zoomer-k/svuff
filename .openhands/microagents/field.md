---
triggers:
- field
---

---


## 🧩 Tree-sitter における `field`

- **意味**: 構文木（AST）のノードにおける「構造的な役割」や「位置」を示すラベル。
- **用途**: ノードの子要素に名前を付けてアクセスしやすくする。
- **例**: `function_declaration` ノードの中に `name` や `parameters` などの `field` がある。
- **特徴**:
  - `field` は構文木の定義（grammar）に基づいて決まる。
  - 単体で意味を持ち、構文解析時に自動的に付与される。

---

## 🔍 ast-grep における `field`

- **意味**: 検索対象のノードの中で、特定の子ノードに対して条件を指定するための「構造的な位置指定」。
- **用途**: 検索ルールの中で、特定の構造にマッチさせるために使う。
- **特徴**:
  - `field` は **構造的な位置指定**であり、**中身の条件がなければ意味を持たない**。
  - `field` の中には、必ず `kind`, `pattern`, `regex` などの **positive matcher** を含める必要がある。
  - `field` のみでは matcher として不完全 → `Rule must have one positive matcher` エラーになる。

- **例**（正しい使い方）:
  ```yaml
  kind: integral_number
    not:
      any:
        - has: # Checks for explicit size, e.g., '4' in 4'd4
            all:
              - kind: decimal_number
              - has:
                  field: size
                  kind: unsigned_number
                  stopBy: end
            stopBy: end
        - has: # Checks for explicit base, e.g., 'd' in 4'd4
            all:
              - kind: decimal_number
              - has:
                  field: base
                  any:
                    - kind: decimal_base
                    - kind: hex_base
                    - kind: binary_base
                    - kind: octal_base
                  stopBy: end
            stopBy: end
        - inside:
            kind: packed_dimension
            stopBy: end

  ```


---

## ✅ まとめ

| 項目 | Tree-sitter | ast-grep |
|------|-------------|----------|
| `field` の意味 | 構文木の子ノードのラベル | 構造的な位置指定 |
| 単体で意味を持つか | 持つ | 持たない（中身の条件が必要） |
| 使用時の注意点 | grammar に従って自動付与 | `kind` などの positive matcher が必須 |
| エラー例 | なし | `Rule must have one positive matcher` |

---


