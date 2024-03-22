#!/bin/bash
hx=$(head -c 4 /dev/urandom | od -An -x | tr -d ' ' )
echo -n "┌─> $hx."
read ext
printf "├─ Reading from STDIN ─┐"
printf "\n"
file="/tmp/$hx.$ext"
cat > "$file"

printf "├──────────────────────┘\n"
echo "└─> $file"
