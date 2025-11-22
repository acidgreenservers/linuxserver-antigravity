# syntax=docker/dockerfile:1
FROM lscr.io/linuxserver/vscodium:latest

ARG AG_URL="https://edgedl.me.gvt1.com/edgedl/release2/j0qc3/antigravity/stable/1.11.3-6583016683339776/linux-x64/Antigravity.tar.gz"
ARG AG_SHA256=""

RUN wget -q -O /tmp/antigravity.tar.gz "${AG_URL}" \
 && [ -n "${AG_SHA256}" ] && echo "${AG_SHA256}  /tmp/antigravity.tar.gz" | sha256sum -c - || echo "SHA256 verification skipped during build" \
 && tar -xzf /tmp/antigravity.tar.gz -C /opt/ \
 && mv /opt/Antigravity /opt/antigravity \
 && chmod +x /opt/antigravity/antigravity \
 && ln -s /opt/antigravity/antigravity /app/antigravity \
 && rm /tmp/antigravity.tar.gz

COPY root/ /

RUN chmod +x /app/antigravity /defaults/open-in-ag.sh /etc/s6-overlay/s6-rc.d/svc-antigravity/run
