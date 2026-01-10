# 1. 使用官方專用的 Task Runner 映像 (基於 Alpine Linux)
# 注意：這是 runners 映像，不是 n8n 映像
FROM n8nio/runners:latest

# 2. 切換成 root 來安裝工具
USER root

# 3. 使用 apk 安裝 FFmpeg (因為是 Alpine，所以用 apk)
# 同時安裝 python3 確保相容性
RUN apk add --no-cache \
    ffmpeg \
    curl \
    python3 \
    py3-pip \
    && rm -rf /var/cache/apk/*

# 4. 建立工作目錄 (給 FFmpeg 暫存用)
RUN mkdir -p /tmp/render && chmod 777 /tmp/render

# 5. 切換回 node 使用者 (安全規範)
USER node

# 6. 啟動指令 (指向 Task Runner 的入口)
CMD ["node", "/usr/local/lib/node_modules/n8n/dist/task-runner-javascript/index.js"]
