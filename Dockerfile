FROM n8nio/runners:latest

USER root

# 安裝 FFmpeg
RUN apk update && \
    apk add --no-cache ffmpeg && \
    rm -rf /var/cache/apk/*

USER runner

# 明確設置環境變數（清空所有禁用清單）
ENV NODE_FUNCTION_ALLOW_BUILTIN=*
ENV NODE_FUNCTION_ALLOW_EXTERNAL=*
ENV N8N_RUNNERS_DISABLED_MODULES=
