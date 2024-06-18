#!/usr/bin/env sh

cd "$(dirname -- "$(which -- "$0" 2>/dev/null || realpath -- "$0")")" || exit 1

agenda_dir="$HOME/agenda"
rating_dir="$HOME/rating"

if [ ! -d "$agenda_dir" ]; then
  echo "Directory of the Agenda repository is not found."
  exit 1
fi

if [ ! -d "$rating_dir" ]; then
  echo "Directory of the Rating repository is not found."
  exit 1
fi



if ! cp "$agenda_dir/books.org" \
  "$agenda_dir/cooking.org" \
  "$agenda_dir/games.org" \
  "$agenda_dir/movies.org" \
  "$agenda_dir/music.org" \
  "$rating_dir" 1>/dev/null; then
  echo "Failed to copy files."
  exit 1
fi

git add books.org cooking.org games.org movies.org music.org
git commit -m "$(date -u +"%Y-%m-%d %H:%M:%SZ")"
git push
