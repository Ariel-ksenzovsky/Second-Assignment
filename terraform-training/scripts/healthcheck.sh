#!/usr/bin/env bash
set -euo pipefail

URL="${1:-http://localhost:8080/health}"

echo "Checking: $URL"

# Try up to 30 times (about 30 seconds)
for i in $(seq 1 30); do
  if command -v curl >/dev/null 2>&1; then
    if curl -fsS "$URL" >/dev/null; then
      echo "OK: $URL"
      exit 0
    fi
  else
    echo "curl not installed on host. Please install curl."
    exit 2
  fi

  echo "Waiting... ($i/30)"
  sleep 1
done

echo "FAILED: $URL did not become healthy"
exit 1
