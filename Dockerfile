# 1. 改用 Node.js 22 (Debian Bookworm) 作為地基
# 這是最穩定的 Linux 版本，保證有 apt-get
FROM node:22-bookworm-slim

# 2. 安裝系統級工具 (FFmpeg, AWS CLI, Curl 等)
# 這裡絕對不會報錯，因為我們用的是標準 Debian
RUN apt-get update && apt-get install -y \
    ffmpeg \
    awscli \
    curl \
    jq \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# 3. 透過 npm 安裝 n8n v2.2.4
# 這步等同於把 n8n 裝進這個強大的系統裡
RUN npm install -g n8n@2.2.4

# 4. 建立使用者與工作目錄 (符合 n8n 安全規範)
USER node
WORKDIR /home/node

# 5. 設定啟動點 (Zeabur 會呼叫這個指令)
ENTRYPOINT ["n8n"]
