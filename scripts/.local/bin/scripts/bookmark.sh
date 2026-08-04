file="$HOME/.config/bm/bookmarks"
bm_write(){
    LINK=$(wl-paste)
    TITLE=$(echo | dmenu) 

    echo "$TITLE | $LINK" >> $file
}


bm_read(){

    selected=$(sort $file| sed -e '/^\s*#/d' | column -ts "|" -o "$(printf "%50s")|" | dmenu -l 8 -g 4)

    # Exit if nothing selected
    [ -z "$selected" ] && exit 1

    # Parse fields
    link=$(echo "$selected" | awk -F "|" '{print $2}' | xargs)
    command=$(echo "$selected" | awk -F "|" '{print $NF}' | xargs)
    cmd_exec=$(echo "$command" | awk '{print $1}')

    # Check if command exists
    if command -v "$cmd_exec" > /dev/null 2>&1; then
        echo "Running: $command $link"
        eval "$command \"$link\""
    else
        echo "Fallback: opening in librewolf"
        librewolf -P default "$link"
    fi
}


COMMAND=$(printf "01 - Read \n02 - Write" | dmenu -l 2 -g 4 | awk '{printf $1}' | xargs)
case "$COMMAND" in
    01) bm_read
    ;;
    02) bm_write
    ;;
    *) echo "james"
    ;;
esac

