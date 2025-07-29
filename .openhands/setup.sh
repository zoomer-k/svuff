#!/bin/bash
sudo npm install --global tree-sitter-cli @ast-grep/cli
tree-sitter init-config
git clone --depth=1 https://github.com/gmlarumbe/tree-sitter-systemverilog /tmp/tree-sitter-systemverilog
pushd /tmp/tree-sitter-systemverilog
tree-sitter generate -b --abi 14 --libdir .
pushd
sg test --skip-snapshot-tests


