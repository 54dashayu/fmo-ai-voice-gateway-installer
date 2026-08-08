#!/bin/sh
set -eu

REPOSITORY="54dashayu/fmo-ai-voice-gateway-installer"
WORK_DIR=$(mktemp -d "${TMPDIR:-/tmp}/fmo-ai-install.XXXXXX")
trap 'rm -rf "$WORK_DIR"' EXIT HUP INT TERM

printf '\nFMO AI 语音网关免登录安装程序\n'
printf '%s\n' '--------------------------------'

if [ "$(uname -s)" != "Linux" ]; then
  printf '%s\n' '错误：只能在Linux系统安装。' >&2
  exit 1
fi
if ! command -v curl >/dev/null 2>&1; then
  printf '%s\n' '错误：系统缺少curl，请先通过系统软件包管理器安装curl。' >&2
  exit 1
fi

printf '%s\n' '正在查询GitHub最新公开版本……'
RELEASE_JSON=$(curl -fsSL "https://api.github.com/repos/$REPOSITORY/releases/latest") || {
  printf '%s\n' '错误：无法读取GitHub Release，请检查网络。' >&2
  exit 1
}
TAG=$(printf '%s' "$RELEASE_JSON" | sed -n 's/.*"tag_name"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -n 1)
[ -n "$TAG" ] || { printf '%s\n' '错误：无法识别最新版本。' >&2; exit 1; }
VERSION=${TAG#v}
ARCHIVE="fmo-ai-voice-gateway-$VERSION.tar.gz"
BASE_URL="https://github.com/$REPOSITORY/releases/download/$TAG"

printf '正在下载 %s……\n' "$TAG"
curl -fL --retry 3 -o "$WORK_DIR/$ARCHIVE" "$BASE_URL/$ARCHIVE"
curl -fL --retry 3 -o "$WORK_DIR/$ARCHIVE.sha256" "$BASE_URL/$ARCHIVE.sha256"

cd "$WORK_DIR"
if command -v sha256sum >/dev/null 2>&1; then
  sha256sum -c "$ARCHIVE.sha256"
elif command -v shasum >/dev/null 2>&1; then
  shasum -a 256 -c "$ARCHIVE.sha256"
else
  printf '%s\n' '错误：缺少SHA-256校验工具，已停止安装。' >&2
  exit 1
fi

tar -xzf "$ARCHIVE"
cd "fmo-ai-voice-gateway-$VERSION"
printf '%s\n' '安装包校验通过，进入中文配置向导……'
sh install.sh "$@"
