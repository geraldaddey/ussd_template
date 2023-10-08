#!/bin/bash
mkdir -p tmp
find . -type f -exec sed -i 's/\r//g' {} +
rubocop -A
touch tmp/restart.txt
  