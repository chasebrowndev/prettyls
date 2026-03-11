#!/bin/bash
# prettyls 1.0.0 - a pretty alternative for ls

RECURSIVE=0
SHOW_DOTFILES=0
ARGS=()

while [[ $# -gt 0 ]]; do
    case "$1" in
        -R|--recursive) RECURSIVE=1 ;;
        -a|--all)       SHOW_DOTFILES=1 ;;
        -h|--help)
            cat <<EOF
Usage: prettyls [OPTIONS] [FILE/DIR...]

A pretty, human-friendly alternative for ls.

Options:
  -a, --all          Show hidden files (dotfiles)
  -R, --recursive    List directories recursively
  -h, --help         Show this help message
  -v, --version      Show version

Columns: permissions | owner | size | date | name

Icons (requires a Nerd Font):
   = directory
   = executable
   = archive (.zip, .tar, .gz ...)
   = image (.jpg, .png ...)
   = regular file
EOF
            exit 0 ;;
        -v|--version)
            echo "prettyls 1.0.0"
            exit 0 ;;
        *) ARGS+=("$1") ;;
    esac
    shift
done

human_size() {
    local size=$1
    if   [ "$size" -ge 1073741824 ]; then awk "BEGIN{printf \"%.2f GB\", $size/1073741824}"
    elif [ "$size" -ge 1048576 ];    then awk "BEGIN{printf \"%.2f MB\", $size/1048576}"
    elif [ "$size" -ge 1024 ];       then awk "BEGIN{printf \"%.2f KB\", $size/1024}"
    else echo "${size} B"
    fi
}

print_header() {
    echo -e "\033[1;90m| permissions | owner            | size         | date       | name\033[0m"
    echo -e "\033[1;90m|-------------|------------------|--------------|------------|--------------------\033[0m"
}

print_file() {
    local f="$1"
    [ -e "$f" ] || return

    perms=$(stat -c "%A" "$f")
    owner=$(stat -c "%U" "$f")
    size_bytes=$(stat -c "%s" "$f")
    size=$(human_size "$size_bytes")
    mtime=$(stat -c "%Y" "$f")
    date_str=$(date -d @"$mtime" "+%m/%d/%Y" 2>/dev/null || echo "N/A")

    if [ -d "$f" ]; then
        color="\033[1;34m"
        icon=$'\uf07b'        # nf-fa-folder  
    elif [[ "$f" =~ \.(zip|tar|tar\.gz|tar\.xz|tar\.zst|tar\.bz2|gz|bz2|xz|zst|rar|7z)$ ]]; then
        color="\033[1;33m"
        icon=$'\uf1c6'        # nf-fa-file_archive  
    elif [[ "$f" =~ \.(jpg|jpeg|png|gif|svg|webp|bmp|ico|tiff)$ ]]; then
        color="\033[1;35m"
        icon=$'\uf1c5'        # nf-fa-file_image  
    elif [ -x "$f" ]; then
        color="\033[1;32m"
        icon=$'\uf489'        # nf-dev-terminal  
    else
        color="\033[0m"
        icon=$'\uf15b'        # nf-fa-file  
    fi

    local display
    if [ -d "$f" ]; then
        display=$(realpath --relative-to="." "$f")
    else
        display=$(basename "$f")
    fi
    printf "| %-11s | %-16s | %12s | %-10s | ${color}%s %s\033[0m\n" \
        "$perms" "$owner" "$size" "$date_str" "$icon" "$display"
}

list_dir() {
    local dir="$1"
    local abs_dir
    abs_dir=$(realpath "$dir")

    echo ""
    echo -e "\033[1;36m\uf07c $abs_dir\033[0m"   # nf-fa-folder_open
    print_header

    mapfile -d '' entries < <(find "$dir" -maxdepth 1 -mindepth 1 -print0 | sort -z)

    if [ "$SHOW_DOTFILES" -eq 0 ]; then
        filtered=()
        for f in "${entries[@]}"; do
            [ -z "$f" ] && continue
            [[ "$(basename "$f")" == .* ]] && continue
            filtered+=("$f")
        done
        entries=("${filtered[@]}")
    fi

    dirs=(); files=()
    for f in "${entries[@]}"; do
        [ -z "$f" ] && continue
        [ -d "$f" ] && dirs+=("$f") || files+=("$f")
    done

    if [ ${#dirs[@]} -eq 0 ] && [ ${#files[@]} -eq 0 ]; then
        echo -e "  \033[2m(empty directory)\033[0m"
    else
        for f in "${dirs[@]}" "${files[@]}"; do print_file "$f"; done
    fi

    echo -e "\033[1;90m  ${#dirs[@]} dir(s), ${#files[@]} file(s)\033[0m"

    if [ "$RECURSIVE" -eq 1 ]; then
        for d in "${dirs[@]}"; do list_dir "$d"; done
    fi
}

[ ${#ARGS[@]} -eq 0 ] && ARGS=(".")

for arg in "${ARGS[@]}"; do
    if [ -d "$arg" ]; then
        list_dir "$arg"
    else
        echo ""; print_header; print_file "$arg"
    fi
done
