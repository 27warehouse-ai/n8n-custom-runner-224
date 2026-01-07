# 🔐 鎖定版本：v2.2.4 + Alpine 系統
# 這樣既不會被自動升級，又有 apk 可以用
FROM n8nio/runners:2.2.4-alpine

# 2. 切換 root 權限安裝軍火
USER root

# 3. 安裝 FFmpeg, AWS CLI, Python
RUN apk add --no-cache \
    ffmpeg \
    aws-cli \
    bash \
    curl \
    jq \
    python3 \
    py3-pip

# 4. 切換回 node (安全規範)
USER node
