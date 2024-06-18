#!/usr/bin/env sh

cd "$(dirname -- "$(which -- "$0" 2>/dev/null || realpath -- "$0")")" || exit 1

rating_dir="$HOME/rating"

if [ ! -d "$rating_dir" ]; then
  echo "Directory of the Rating repository is not found."
  exit 1
fi

for file in "$rating_dir"/*.org; do
  echo "Processing $file"
  emacs \
    --batch \
    --eval "(require 'org)" \
    "$file" \
    --funcall org-html-export-to-html
done

mv "$rating_dir/"*.html "$rating_dir/docs/"
mv "$rating_dir/docs/README.html" "$rating_dir/docs/index.html"
cp "$rating_dir/docs/index.html" "$rating_dir/docs/404.html"
