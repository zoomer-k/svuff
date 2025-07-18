FROM rust:latest

# 必要なパッケージのインストール
RUN apt-get update && \
    apt-get install -y curl git build-essential libtool autoconf automake pkg-config rustup nodejs npm 

RUN rustup update stable


# Tree-sitter CLI のインストール（エラー回避のためオプション追加）
RUN cargo install tree-sitter-cli --legacy-peer-deps

# ast-grep CLI のインストール
RUN npm install --global @ast-grep/cli

# 作業ディレクトリの設定
WORKDIR /workspace

# ホスト側のファイルをすべてコピー
COPY . .

# tree-sitter-systemverilog をクローンしてビルド
RUN git clone --depth=1 https://github.com/gmlarumbe/tree-sitter-systemverilog && \
    cd tree-sitter-systemverilog && \
    tree-sitter generate -b --abi 14 --libdir .
