#!/usr/bin/env bash
# 生成网站目录 _site/。课程页本身不写 <!doctype>/<head>（这样才能直接发布成 Claude artifact），
# 这里给它们补上完整的文档骨架。
# Builds _site/. Lesson pages are skeleton-free (so they publish as Claude artifacts as-is);
# this wraps each one in a full HTML document.
set -euo pipefail
cd "$(dirname "$0")/.."
rm -rf _site && mkdir -p _site
cp index.html lessons.json _site/
cp -r lessons _site/lessons
for f in _site/lessons/*.html; do
  if ! head -c 200 "$f" | grep -qi '<!doctype'; then
    {
      printf '<!doctype html>\n<html lang="zh-CN">\n<head>\n<meta charset="utf-8">\n'
      printf '<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n'
      printf '<style>[hidden]{display:none!important}body{margin:0}img{max-width:100%%}</style>\n</head>\n<body>\n'
      cat "$f"
      printf '\n</body>\n</html>\n'
    } > "$f.tmp"
    mv "$f.tmp" "$f"
  fi
done
echo "built _site/ with $(ls _site/lessons/*.html | wc -l) lesson page(s)"
