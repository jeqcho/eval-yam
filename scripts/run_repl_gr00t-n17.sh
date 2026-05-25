#!/usr/bin/env bash
# Interactive REPL against the GR00T-N1.7 YAM server (ZeroMQ+msgpack-numpy).
# Server: run_server_gr00t-n17.sh on :5556.
#
# NOTE: requires pyzmq + msgpack-numpy in the i2rt venv (one-time):
#   VIRTUAL_ENV=/home/andon/yam-tests/i2rt/.venv uv pip install pyzmq msgpack-numpy
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
    --policy gr00t-n17 \
    --server-host "${YAM_SERVER_HOST:-127.0.0.1}" \
    --server-port "${YAM_SERVER_PORT:-5556}" \
    "$@"
