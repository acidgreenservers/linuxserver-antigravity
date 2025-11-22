#!/command/with-contenv bash
exec /app/antigravity --no-sandbox --user-data-dir=/config/antigravity-data "$1"
