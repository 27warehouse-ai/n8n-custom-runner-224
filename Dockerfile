# 🏆 最終選擇：基於 Debian 的全能映像檔
# 使用 Node.js 22 (Bookworm) - 穩定、相容性高、有 apt-get
FROM node:22-bookworm-slim

# 1. 更新系統並安裝 "軍火庫" (FFmpeg, Python, AWS CLI)
# 使用 apt-get，這是最標準的 Linux 安裝方式，保證成功
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    awscli \
    bash \
    curl \
    jq \
    python3 \
    python3-pip \
    ca-certificates \
    git \
    procps \
    && rm -rf /var/lib/apt/lists/*

# 2. 安裝 n8n (鎖定版本 2.2.4)
# 這樣我們就不用依賴官方被閹割的 runner image
RUN npm install -g n8n@2.2.4

# 3. 建立工作目錄與權限
WORKDIR /home/node
USER node

# 4. 啟動指令 (預設)
ENTRYPOINT ["n8n"]
