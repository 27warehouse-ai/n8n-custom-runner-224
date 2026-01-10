FROM node:20-alpine

# 1. 安裝 FFmpeg
RUN apk add --no-cache ffmpeg curl python3 py3-pip aws-cli bash && rm -rf /var/cache/apk/*

# 2. 安裝 n8n
RUN npm install -g n8n

# 3. 建立目錄
RUN mkdir -p /tmp/render && chmod 777 /tmp/render

# 4. 切換用戶
USER node

# 5. 啟動指令 (變成 Worker)
CMD ["n8n", "worker"]
