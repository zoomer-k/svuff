
#FROM node:latest
FROM nikolaik/python-nodejs:python3.12-nodejs22



# 必要なパッケージのインストール
# RUN apt-get update && \
#     apt-get install -y curl git build-essential libtool autoconf automake pkg-config nodejs npm 

# install ast-grep CLI & tree-sitter-cli
RUN npm install --global tree-sitter-cli @ast-grep/cli


# 作業ディレクトリの設定
WORKDIR /workspace

# ホスト側のファイルをすべてコピー
COPY . .

# create config file 
RUN tree-sitter init-config

# tree-sitter-systemverilog をクローンしてビルド
RUN git clone --depth=1 https://github.com/gmlarumbe/tree-sitter-systemverilog　$HOME && \
    cd $HOME/tree-sitter-systemverilog && \
    tree-sitter generate -b --abi 14 --libdir .
