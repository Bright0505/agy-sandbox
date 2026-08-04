#!/bin/bash
set -e

# Container starts as root so the firewall can be configured, then drops
# to the unprivileged $USERNAME for everything else (matches Dockerfile.agy).
if [ "$(id -u)" = "0" ]; then
    if [ -f "/workspace/scripts/init-firewall.sh" ]; then
        /workspace/scripts/init-firewall.sh
    else
        /usr/local/bin/init-firewall.sh
    fi
    exec gosu agy "$@"
fi

exec "$@"
