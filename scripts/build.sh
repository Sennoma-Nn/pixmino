#!/bin/sh

log() {
    printf "\033[34mLog:\t%s\033[0m\n" "$1" >&2
}

error() {
    printf "\033[31mError:\t%s\033[0m\n" "$2" >&2
    exit "$1"
}

change_dir() {
    if ! cd "$1" > /dev/null 2> /dev/null; then
        error 1 "$1 Cannot be entered."
    else
        log "Entered $(pwd)."
    fi
}

for cmd in wget md5sum zip unzip; do
    if ! command -v "$cmd" >/dev/null; then
        error 127 "Required command '$cmd' not found." >&2
    fi
done

SCRIPT_DIR=$(CDPATH="" cd -- "$(dirname -- "$0")" && pwd)
change_dir "$SCRIPT_DIR"/..

log "Clear old build files."
[ -d ./build ] && rm -rf ./build
mkdir -p ./build/tmp

change_dir ./build/tmp

url='https://github.com/love2d/love/releases/download/11.5/love-11.5-win64.zip'
if ! wget -q --show-progress -O love_win.zip "$url"; then
    error 2 "Failed to get love2d windows zip."
fi

md5='217d7d2ba138cc8255f693fc3413ab1c'
if ! echo "$md5  love_win.zip" | md5sum -c -; then
    error 2 "Failed to MD5 check."
fi

if ! unzip -q -o love_win.zip -d love-win64; then
    error 2 "Failed to extract love_win.zip."
fi
