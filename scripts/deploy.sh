#!/usr/bin/env bash

for path in ${HOME}/functions/*; do
    if [[ -d "$path" && ! -L "$path" ]]; then
        cd $path
        functions deploy $(basename "$PWD") --trigger-http
    fi
done