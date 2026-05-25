#!/usr/bin/env bash
# Interactive REPL against the Pi-0.5 yam_pi05 server (WebSocket+msgpack).
# Server: run_server_pi05.sh on :8000.
#
# NOTE: requires `openpi-client` installed in the i2rt venv (one-time):
#   VIRTUAL_ENV=/home/andon/yam-tests/i2rt/.venv uv pip install \
#     'openpi-client @ git+https://github.com/Physical-Intelligence/openpi.git#subdirectory=packages/openpi-client'
set -euo pipefail

EVAL_YAM_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
I2RT_DIR="$EVAL_YAM_DIR/../i2rt"
PYTHON="$I2RT_DIR/.venv/bin/python"

if [[ ! -x "$PYTHON" ]]; then
    echo "i2rt venv python not found at $PYTHON" >&2
    exit 1
fi

INVOCATION_ARGS=$(printf ' %q' "$@")
export YAM_INVOCATION="${BASH_SOURCE[0]}${INVOCATION_ARGS}"

exec "$PYTHON" "$EVAL_YAM_DIR/scripts/repl_yam.py" \
    --policy pi05 \
    --server-host "${YAM_SERVER_HOST:-127.0.0.1}" \
    --server-port "${YAM_SERVER_PORT:-8000}" \
    "$@"
