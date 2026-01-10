# 1. 選擇基底：使用 Node.js 20 的 Alpine 版本 (輕量、穩定、有 apk)
FROM node:20-alpine

# 2. 系統層安裝：這一步是官方 Image 做不到的，我們自己來
# 安裝 FFmpeg (處理影片), Curl, Python3, AWS CLI
RUN apk add --no-cache \
    ffmpeg \
    curl \
    python3 \
    py3-pip \
    aws-cli \
    bash \
    && rm -rf /var/cache/apk/*

# 3. 應用層安裝：全域安裝 n8n
# 這樣我們就擁有了一個完整的 n8n Runner
RUN npm install -g n8n

# 4. 準備工作目錄
RUN mkdir -p /tmp/render && chmod 777 /tmp/render

# 5. 安全性：切換回 node 使用者
USER node

# 6. 啟動指令：明確告訴它「我是 Runner」
# 避開 Python 錯誤，專注於 JavaScript 和 FFmpeg
CMD ["node", "/usr/local/lib/node_modules/n8n/dist/task-runner-javascript/index.js"]
