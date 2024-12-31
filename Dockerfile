FROM alpine:3.18
RUN apk add --no-cache bash curl
COPY metrics.sh /metrics.sh
RUN chmod +x /metrics.sh
ENV OUTPUT_DIR="/data/metrics"
CMD ["bash", "-c", "/metrics.sh"]