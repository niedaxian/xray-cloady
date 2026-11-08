# Multi-stage: official xray image has no shell, copy the binary into Alpine
FROM ghcr.io/xtls/xray-core:latest AS xray
FROM alpine:latest
RUN apk add --no-cache ca-certificates
COPY --from=xray /usr/local/bin/xray /usr/local/bin/xray
COPY config.json /etc/xray/config.json
EXPOSE 3000
ENTRYPOINT ["/usr/local/bin/xray", "run", "-c", "/etc/xray/config.json"]
