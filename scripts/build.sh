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

zip -r ./build/pixmino.love assets conf.lua lib	main.lua user_script.lua custom_cp.lua LICENSE src

log "Compress into love file."
change_dir ./build/tmp

log "Download love2d windows zip."
url='https://github.com/love2d/love/releases/download/11.5/love-11.5-win64.zip'
if ! wget -q --show-progress -O love_win.zip "$url"; then
    error 2 "Failed to get love2d windows zip."
fi

log "MD5 check."
md5='217d7d2ba138cc8255f693fc3413ab1c'
if ! echo "$md5  love_win.zip" | md5sum -c -; then
    error 2 "Failed to MD5 check."
fi

log "Unzip love2d windows zip."
if ! unzip -q -o love_win.zip -d love-win64; then
    error 2 "Failed to extract love_win.zip."
fi

log "Concatenate love and exe file."
love_win_root='./love-win64/love-11.5-win64'
cat "$love_win_root"/love.exe ../pixmino.love > "$love_win_root"/pixmino.exe
rm "$love_win_root"/love.exe
mv ./love-win64/love-11.5-win64 ./love-win64/pixmino

log "Compress into windows package."
change_dir ./love-win64/pixmino
zip -r ../../../pixmino-windows.zip ./*
change_dir ../..