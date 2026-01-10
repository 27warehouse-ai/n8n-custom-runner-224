# 使用官方 Task Runner (最新版，經確認為 Debian 基底)
FROM n8nio/runners:latest

# 切換 root 安裝工具
USER root

# 改用 apt-get (Debian 專用) 來安裝 FFmpeg 和其他工具
# 注意：這裡的語法跟 Alpine 不一樣
RUN apt-get update && \
    apt-get install -y \
    ffmpeg \
    curl \
    python3 \
    python3-pip \
    awscli \
    && rm -rf /var/lib/apt/lists/*

# 建立暫存目錄並給予權限
RUN mkdir -p /tmp/render && chmod 777 /tmp/render

# 切換回 node 使用者
USER node

# 強制指定啟動指令 (Task Runner 模式)
CMD ["node", "/usr/local/lib/node_modules/n8n/dist/task-runner-javascript/index.js"]
