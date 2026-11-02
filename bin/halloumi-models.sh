#!/usr/bin/env bash
# Download the Q4_K_M target + DFlash 2 draft GGUFs into ./models.
set -euo pipefail

# ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# cd "$ROOT"
ROOT="$(pwd)"

if [[ -f .env ]]; then
  set -a
  # shellcheck disable=SC1091
  source .env
  set +a
fi

MODELS_DIR="${MODELS_DIR:-$ROOT/models}"
TARGET_REPO="${TARGET_REPO:-unsloth/Qwen3.8-27B-GGUF}"
TARGET_FILE="${TARGET_FILE:-Qwen3.8-27B-UD-Q4_K_S.gguf}"
DRAFT_REPO="${DRAFT_REPO:-incoai/Qwen3.8-27B-DFlash2-GGUF}"
DRAFT_FILE="${DRAFT_FILE:-Qwen3.8-27B-DFlash2-Q4_K_S.gguf}"
MMPROJ_REPO="${MMPROJ_REPO:-unsloth/Qwen3.8-27B-GGUF}"
MMPROJ_FILE="${MMPROJ_FILE:-mmproj-F16.gguf}"

mkdir -p "$MODELS_DIR"

hf_url() {
  local repo="$1"
  local file="$2"
  printf 'https://huggingface.co/%s/resolve/main/%s?download=true' "$repo" "$file"
}

download() {
  local repo="$1"
  local file="$2"
  local dest="$MODELS_DIR/$file"
  local url
  url="$(hf_url "$repo" "$file")"

  if [[ -s "$dest" ]]; then
    echo "already present: $dest ($(du -h "$dest" | awk '{print $1}'))"
    return 0
  fi

  echo "downloading $repo/$file"
  echo "  -> $dest"

  curl -fL --retry 8 --retry-all-errors --retry-delay 2 \
    -C - \
    --progress-bar \
    -o "$dest.partial" \
    "$url"

  mv "$dest.partial" "$dest"
  echo "saved $dest ($(du -h "$dest" | awk '{print $1}'))"
}

download "$TARGET_REPO" "$TARGET_FILE"
download "$DRAFT_REPO" "$DRAFT_FILE"
download "$MMPROJ_REPO" "$MMPROJ_FILE"

echo
echo "models ready in $MODELS_DIR"
ls -lh "$MODELS_DIR"/*.gguf
