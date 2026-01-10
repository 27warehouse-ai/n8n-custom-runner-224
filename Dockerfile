FROM n8nio/n8n:latest

# 切換到 root 使用者
USER root

# 安裝 FFmpeg, AWS CLI, Python3（使用 apk，因為是 Alpine）
RUN apk add --no-cache \
    ffmpeg \
    aws-cli \
    python3 \
    py3-pip \
    curl

# 設定環境變數
ENV NODE_FUNCTION_ALLOW_BUILTIN=*
ENV NODE_FUNCTION_ALLOW_EXTERNAL=*
ENV N8N_DEFAULT_BINARY_DATA_MODE=default
ENV N8N_RUNNERS_DISABLED_MODULES=""

# 切換回 node 使用者
USER node

# 使用預設的 n8n 啟動指令
CMD ["n8n"]
