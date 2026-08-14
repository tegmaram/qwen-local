#!/usr/bin/env bash
set -euo pipefail
# Reproducibly fetch the complete, Transformers.js-compatible Qwen3.5-2B ONNX repo.
# Requires: git-lfs (or hf CLI). The model is ~3GB; it is intentionally not stored in Git.
ROOT="$(cd "$(dirname "$0")" && pwd)"
mkdir -p "$ROOT/models/Qwen3.5-2B-ONNX"
if command -v hf >/dev/null 2>&1; then
  hf download onnx-community/Qwen3.5-2B-ONNX --local-dir "$ROOT/models/Qwen3.5-2B-ONNX"
elif command -v git-lfs >/dev/null 2>&1; then
  git clone --depth 1 https://huggingface.co/onnx-community/Qwen3.5-2B-ONNX "$ROOT/models/Qwen3.5-2B-ONNX"
else
  echo 'Install git-lfs or huggingface_hub first: pip install -U huggingface_hub' >&2
  exit 1
fi
printf 'Downloaded model to %s\n' "$ROOT/models/Qwen3.5-2B-ONNX"
