---
name: openhandsへのyml修正依頼
about: ruleの****.ymlの修正する。
title: "****.ymlの修正する。"
labels: fix-me
assignees: ''

---

## 変数
- **{{rule_path}}** :  verible_rules /always_ff_non_blocking.yml
- **{{test_path}}** :  verible_tests /always_ff_non_blocking.yml
- **{{Purpose}}**  : blocking assigment ( = ) が always_ff内で使用されているのを検出する。 


## 目的 概要

{{rule_path}} を、ast-grepでのテスト（.openhands/pre-commit.sh)に合格するように修正する。

{{Purpose}}

## 構成と用語

- **{rule_path}}**: ast-grepでのルールファイル。
- **{{test_path}}**: ast-grepでのルールをテストするためのテストファイル
- **sgconfig.yml**: ast-grepがルールファイルの場所や、customlanguagesの場所を検出するための設定ファイル
- **tree-sitter-systemverilog**: ast-grepが利用する、パーサーの種類。systemverilogをパースできる。 


## 修正手順

### valid と invalidのテストケースをパースする。
{{test_path}} は、ルールファイルのテストケースを含む。
- **valid**: テストで検出されないsystemverilog記述
- **invalid**: テストで検出されるsystemverilog記述

If ast-grep reports error for invalid code, it is a correct reported match.
If ast-grep reports error for valid code, it is called noisy match.
If ast-grep reports nothing for invalid code, we have a missing match.
If ast-grep reports nothing for valid code, it is called validated match.

テストファイルには複数のテストケースを含むこともある。 
それぞれのテストケースを、ast-grepを利用してcstにパースして比較する。

#### パースの実施例
validの場合、bashなどを利用して、

``` bash
ast-grep run -p '
    localparam logic [3:0] bar = 4'd4;
    assign foo = 8'd2;
' --lang systemverilog --debug-query=cst

```

のようにcstに変換できる。

- **-p**:  ast-grepに渡す、ソースファイル
- **-lang** 解析する言語を指定
- **--debug-query=cst**: パースする形式をcstに指定。

### ルールを修正する。
validとinvalidのcstを比較し、テストに合格できる{{rule_path}} に修正する。

#### field について
ast-grepとtree-sitterではfieldの使い方が異なるため、field.mdを参照して注意する。 
field の中には、必ず kind, pattern, regex などの positive matcher を含める必要がある。

#### terminal node について
一番子供のノードはstrigs literal の場合があり、注意する。

ルールの記述方法については、.openhands/microagents/repo.mdやリンクを先を参考。
https://ast-grep.github.io/advanced/pattern-parse.html
https://ast-grep.github.io/cheatsheet/rule.html
