# 1. 使用官方 Task Runner (Alpine 版) - 這是解鎖 FFmpeg 的關鍵
FROM n8nio/runners:latest

# 2. 切換 root 安裝工具
USER root

# 3. 安裝 FFmpeg, CURL, Python3, AWS CLI (一次裝好，不再缺件)
# 注意：這裡的 aws-cli 是為了讓你未來有擴充性，如果不裝也沒關係，但 FFmpeg 必裝
RUN apk add --no-cache \
    ffmpeg \
    curl \
    python3 \
    py3-pip \
    aws-cli \
    && rm -rf /var/cache/apk/*

# 4. 建立暫存目錄並給予權限
RUN mkdir -p /tmp/render && chmod 777 /tmp/render

# 5. 切換回 node 使用者 (安全規範)
USER node

# 6. (補回) 強制指定啟動指令，確保 Zeabur 不會跑錯
CMD ["node", "/usr/local/lib/node_modules/n8n/dist/task-runner-javascript/index.js"]
