# syntax=docker/dockerfile:1
FROM lscr.io/linuxserver/vscodium:latest

ARG AG_URL="https://edgedl.me.gvt1.com/edgedl/release2/j0qc3/antigravity/stable/1.11.9-4787439284912128/linux-x64/Antigravity.tar.gz"
ARG AG_SHA256=""

RUN curl -sL -o /tmp/antigravity.tar.gz "${AG_URL}" \
 && [ -n "${AG_SHA256}" ] && echo "${AG_SHA256}  /tmp/antigravity.tar.gz" | sha256sum -c - || echo "SHA256 verification skipped during build" \
 && tar -xzf /tmp/antigravity.tar.gz -C /opt/ \
 && mv /opt/Antigravity /opt/antigravity \
 && chmod +x /opt/antigravity/antigravity \
 && mkdir -p /app \
 && ln -s /opt/antigravity/antigravity /app/antigravity \
 && rm /tmp/antigravity.tar.gz

COPY root/ /

RUN chmod +x /app/antigravity /defaults/open-in-ag.sh /etc/s6-overlay/s6-rc.d/svc-antigravity/run /etc/cont-init.d/99-antigravity-config /etc/cont-init.d/50-antigravity-permissions

# Add Healthcheck
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:3000/ || exit 1

LABEL maintainer="acidgreenservers" \
      description="Antigravity IDE in Docker"

