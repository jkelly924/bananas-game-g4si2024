#!/bin/sh
echo -ne '\033c\033]0;Bananas Game G4SI2024\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/HostileArchitecture.x86_64" "$@"
