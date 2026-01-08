# 🏆 最終定案：基於 Debian 的全能自動化引擎
# 使用 Node.js 22 (Bookworm) - 穩定、相容性高
FROM node:22-bookworm-slim

# 1. 安裝系統工具 (FFmpeg, Python, AWS CLI)
# 使用 apt-get 安裝，確保所有依賴都齊全
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
RUN npm install -g n8n@2.2.4

# 3. 設定工作目錄
WORKDIR /home/node

# 4. 切換回安全使用者
USER node

# 5. ⚠️ 關鍵修正：直接定義完整的啟動指令
# 我們直接告訴它：「你就是一個 Worker，並且開啟內部 task runner」
# 這樣 Zeabur 的 Command 欄位就可以留空，不會出錯
CMD ["n8n", "worker"]
