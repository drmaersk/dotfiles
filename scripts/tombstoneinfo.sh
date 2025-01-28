#! /usr/bin/env bash
for file in *; do     if [ -f "$file" ]; then         echo "==> $file <==";         sed -n '7p' "$file";     fi; done
