#!/usr/bin/env sh

cd "$(dirname -- "$(which -- "$0" 2>/dev/null || realpath -- "$0")")" || exit 1

agenda_dir="$HOME/agenda"

if [ ! -d "$agenda_dir" ]; then
  echo "Directory of the Agenda repository is not found."
  exit 1
fi

cp "$agenda_dir/books.org" \
  "$agenda_dir/cooking.org" \
  "$agenda_dir/games.org" \
  "$agenda_dir/movies.org" \
  "$agenda_dir/music.org" \
  .

if [ "$?" -ne 0 ]; then
  echo "Failed to copy files."
  exit 1
fi

git add books.org cooking.org games.org movies.org music.org
git commit -m "$(date -u +"%Y-%m-%d %H:%M:%SZ")"
git push
