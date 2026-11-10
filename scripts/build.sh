#!/bin/sh

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

cover() {
    awk '{printf "\033[2K\r%s", $0} END{printf "\n"}'
}

debug=0
ver_set=0

while [ $# -gt 0 ]; do
    case "$1" in
        -d)
            debug=1
            shift
            ;;
        --)
            shift
            while [ $# -gt 0 ]; do
                if [ $ver_set -eq 0 ]; then
                    ver="$1"; ver_set=1
                else
                    error 1 "Unexpected argument: '$1'"
                fi
                shift
            done
            ;;
        -*)
            error 1 "Unknown option: '$1'"
            ;;
        *)
            if [ $ver_set -eq 0 ]; then
                ver="$1"; ver_set=1
            else
                error 1 "Unexpected argument: '$1'"
            fi
            shift
            ;;
    esac
done

if [ $ver_set -eq 0 ]; then
    error 1 "Version must be set."
fi

for cmd in wget md5sum zip unzip editpe; do
    if ! command -v "$cmd" >/dev/null; then
        error 127 "Required command '$cmd' not found."
    fi
done

log() {
    [ $debug -eq 1 ] && printf "\033[34mLog:\t%s\033[0m\n" "$1" >&2
}

SCRIPT_DIR=$(CDPATH="" cd -- "$(dirname -- "$0")" && pwd)
change_dir "$SCRIPT_DIR"/..
[ -f ./main.lua ] || error 1 "Project root not found."

log "Clear old build files."
[ -d ./build ] && rm -rf ./build
mkdir -p ./build/tmp

love_file_name="pixmino-v$ver.love"
zip -r ./build/"$love_file_name" assets conf.lua lib	main.lua user_script.lua custom_cp.lua LICENSE src | cover

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
rm "$love_win_root"/game.ico
cp ../../assets/icon/icon.ico "$love_win_root"/game.ico
cat "$love_win_root"/love.exe ../"$love_file_name" > "$love_win_root"/pixmino.exe
rm "$love_win_root"/love.exe
if ! editpe --set-icon "$love_win_root"/game.ico "$love_win_root"/pixmino.exe; then
    error 2 "Failed to set exe icon."
fi
mv ./love-win64/love-11.5-win64 ./love-win64/pixmino

log "Compress into windows package."
change_dir ./love-win64/pixmino
zip -r ../../../"pixmino-windows-v$ver.zip" ./* | cover
change_dir ../..

change_dir ..
rm -rf ./tmp
