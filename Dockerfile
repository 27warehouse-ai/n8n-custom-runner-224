# 使用 n8n 最新版本
FROM n8nio/n8n:latest

USER root

# ==========================================
# 步驟 1: 重新安裝 APK（因為官方 v2.x 移除了它）
# ==========================================
RUN ARCH=$(uname -m) && \
    wget -qO- "http://dl-cdn.alpinelinux.org/alpine/latest-stable/main/${ARCH}/" | \
    grep -o 'href="apk-tools-static-[^"]*\.apk"' | head -1 | cut -d'"' -f2 | \
    xargs -I {} wget -q "http://dl-cdn.alpinelinux.org/alpine/latest-stable/main/${ARCH}/{}" && \
    tar -xzf apk-tools-static-*.apk && \
    ./sbin/apk.static -X http://dl-cdn.alpinelinux.org/alpine/latest-stable/main \
        -U --allow-untrusted add apk-tools && \
    rm -rf sbin apk-tools-static-*.apk

# ==========================================
# 步驟 2: 現在可以正常使用 apk 安裝 FFmpeg
# ==========================================
RUN apk update && \
    apk add --no-cache ffmpeg ffmpeg-dev && \
    rm -rf /var/cache/apk/*

# ==========================================
# 步驟 3: 設定環境變數（針對高負載場景優化）
# ==========================================
ENV N8N_DEFAULT_BINARY_DATA_MODE=default
ENV NODE_FUNCTION_ALLOW_BUILTIN=*
ENV NODE_FUNCTION_ALLOW_EXTERNAL=*
ENV NODE_OPTIONS="--max-old-space-size=4096"
ENV EXECUTIONS_DATA_PRUNE=true
ENV EXECUTIONS_DATA_MAX_AGE=168

USER node
