#!/usr/bin/env sh

cd "$(dirname -- "$(which -- "$0" 2>/dev/null || realpath -- "$0")")" || exit 1

rating_dir="$HOME/rating"

if [ ! -d "$rating_dir" ]; then
  echo "Directory of the Rating repository is not found."
  exit 1
fi

for file in "$rating_dir"/*.org; do
  echo "Processing $file"
  if ! emacs \
    --batch \
    --eval "(require 'org)" \
    --eval "(setq org-html-head \"\"
             org-html-head-extra \"\"
             org-html-head-include-default-style nil
             org-html-head-include-scripts nil
             org-html-preamble nil
             org-html-postamble nil
             org-html-use-infojs nil)" \
    "$file" \
    --funcall org-html-export-to-html 1>/dev/null; then
    echo "Failed to convert $file to HTML."
    exit 1
  fi
done

mv "$rating_dir/"*.html "$rating_dir/docs/"
mv "$rating_dir/docs/README.html" "$rating_dir/docs/index.html"
cp "$rating_dir/docs/index.html" "$rating_dir/docs/404.html"
