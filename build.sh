#!/bin/bash

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  echo "Usage: $0 <target_folder> (example: $0 dso)"
  exit 0
fi

script_dir=$(dirname "$0")
target_folder=$1

target_path=$(find "$script_dir" -type d -name "$target_folder" -print -quit 2>/dev/null)
if [[ -n "$target_path" ]]; then
  relative_path=$(realpath --relative-to="$script_dir" "$target_path")
else
  echo "Target folder $target_folder not found."
  exit 1
fi

docker build --force-rm -f $relative_path/Dockerfile -t hyeonjaegil/$1 .