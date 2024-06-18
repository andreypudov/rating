#!/usr/bin/env sh

cd "$(dirname -- "$(which -- "$0" 2>/dev/null || realpath -- "$0")")" || exit 1

rating_dir="../../rating"

if [ ! -d "$rating_dir" ]; then
  echo "Directory of the Rating repository is not found."
  exit 1
fi

for file in "$rating_dir"/*.org; do
  file_name="$(basename -- "$file")"
  temp_file="$file_name.temp.org"

  echo "Processing $file"

  { cat "$rating_dir/overrides/analytics.org";
    cat "$rating_dir/overrides/style.org";
    cat "$file"; } > "$temp_file"

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
    "$temp_file" \
    --funcall org-html-export-to-html 1>/dev/null; then
    echo "Failed to convert $file to HTML."

    rm "$temp_file"
    exit 1
  fi

  mv "${temp_file%.org}.html" "$rating_dir/${file_name%.org}.html"
  rm "$temp_file"
done

mv "$rating_dir/"*.html "$rating_dir/docs/"
mv "$rating_dir/docs/README.html" "$rating_dir/docs/index.html"
cp "$rating_dir/docs/index.html" "$rating_dir/docs/404.html"
