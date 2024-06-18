#!/usr/bin/env sh

cd "$(dirname -- "$(which -- "$0" 2>/dev/null || realpath -- "$0")")" || exit 1

for file in *.org; do
  echo "Processing $file"
  emacs \
    --batch \
    --eval "(require 'org)" \
    "$file" \
    --funcall org-html-export-to-html
done
