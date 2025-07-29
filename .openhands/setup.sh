#!/bin/bash
sudo npm install --global tree-sitter-cli @ast-grep/cli
sudo tree-sitter init-config
sudo git clone --depth=1 https://github.com/gmlarumbe/tree-sitter-systemverilog /tmp/tree-sitter-systemverilog
sudo cd /tmp/tree-sitter-systemverilog
sudo tree-sitter generate -b --abi 14 --libdir .

