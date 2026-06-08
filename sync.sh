#!/usr/bin/env bash
# sync.sh — 從 Obsidian source-of-truth 同步架構圖到 share repo
#
# 行為：
#   1. 複製 architecture-diagram.html → index.html
#   2. 自動把 Obsidian-style 連結（00-MOC.md / glossary.md）改成 .html
#   3. 顯示 diff 給你看
#   4. 確認後 commit + push（會自動切 gh JiaWen-Shen 帳號）
#
# 注意：moc.md / glossary.md 不自動同步（含人工清理過的個人視角）
#       要改就在這個 repo 內直接編輯
#
# 用法：
#   bash ~/Jottacloud/vibe/qoome-edge-share/sync.sh

set -e

VAULT="$HOME/Vaults/JW/JW_cloud/02_Projects/Qoome-Edge-Console"
SHARE="$HOME/Jottacloud/vibe/qoome-edge-share"

if [ ! -d "$VAULT" ]; then
  echo "❌ Obsidian source 不存在: $VAULT" >&2; exit 1
fi
if [ ! -d "$SHARE" ]; then
  echo "❌ Share repo 不存在: $SHARE" >&2; exit 1
fi

cd "$SHARE"

# 1. 確保 gh active = JiaWen-Shen（chpwd hook 應該已切，這裡再保險）
current=$(gh auth status 2>&1 | awk '/Active account: true/{f=1;next} f && /Logged in/{print $7;exit}')
if [ "$current" != "JiaWen-Shen" ]; then
  echo "→ 切 gh 帳號 ($current → JiaWen-Shen)"
  gh auth switch -u JiaWen-Shen >/dev/null
fi

# 2. 同步 HTML
echo "→ 複製 architecture-diagram.html → index.html"
cp "$VAULT/architecture-diagram.html" index.html

# 3. 改 Obsidian-style 連結成 GitHub Pages 路徑
echo "→ 替換連結：*.md → *.html"
sed -i.bak \
  -e 's|href="00-MOC\.md"|href="moc.html"|g' \
  -e 's|href="moc\.md"|href="moc.html"|g' \
  -e 's|href="glossary\.md"|href="glossary.html"|g' \
  -e 's|href="Qoome glossary\.md"|href="glossary.html"|g' \
  index.html
rm index.html.bak

# 4. 預覽 diff
if [ -z "$(git status --porcelain)" ]; then
  echo ""
  echo "✅ 沒變動，無需 commit"
  exit 0
fi

echo ""
echo "=== Changes ==="
git diff --stat
echo ""

# 5. 確認後 commit + push
read -p "確認 commit + push? (y/N) " yn
if [ "$yn" != "y" ] && [ "$yn" != "Y" ]; then
  echo "❌ 取消（變動已留在 working tree）"
  exit 0
fi

git add -A
git commit -m "sync: update architecture diagram from Obsidian ($(date +%Y-%m-%d))"
git push

echo ""
echo "✅ 完成"
echo "🔗 https://jiawen-shen.github.io/qoome-edge-share/"
echo "   (Pages rebuild 約 30-60s)"
