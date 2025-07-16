
FROM ubuntu:latest

RUN apt-get update && apt-get install -y --no-install-recommends \
    tree-sitter-cli \
    ast-grep \
    git \
    python3 \
    python3-pip

WORKDIR /app

COPY . .

# Install project dependencies (example, adjust as needed)
# RUN pip install -r requirements.txt  # If you have a requirements.txt file
# Example:
# RUN pip install flask

CMD ["bash"] # Or your application's entrypoint
