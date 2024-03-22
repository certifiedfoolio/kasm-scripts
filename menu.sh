# Reset
OFF='\033[0m'       # Text Reset

# Regular Colors
BLACK='\033[0;30m'        # BLACK
RED='\033[0;31m'          # RED
GREEN='\033[0;32m'        # GREEN
YELLOW='\033[0;33m'       # YELLOW
BLUE='\033[0;34m'         # BLUE
PURPLE='\033[0;35m'       # PURPLE
CYAN='\033[0;36m'         # CYAN
WHITE='\033[0;37m'        # WHITE

# Bold
BBLACK='\033[1;30m'       # BLACK
BRED='\033[1;31m'         # RED
BGREEN='\033[1;32m'       # GREEN
BYELLOW='\033[1;33m'      # YELLOW
BBLUE='\033[1;34m'        # BLUE
BPURPLE='\033[1;35m'      # PURPLE
BCYAN='\033[1;36m'        # CYAN
BWHITE='\033[1;37m'       # WHITE

# Underline
UBLACK='\033[4;30m'       # BLACK
URED='\033[4;31m'         # RED
UGREEN='\033[4;32m'       # GREEN
UYELLOW='\033[4;33m'      # YELLOW
UBLUE='\033[4;34m'        # BLUE
UPURPLE='\033[4;35m'      # PURPLE
UCYAN='\033[4;36m'        # CYAN
UWHITE='\033[4;37m'       # WHITE

# Background
On_BLACK='\033[40m'       # BLACK
On_RED='\033[41m'         # RED
On_GREEN='\033[42m'       # GREEN
On_YELLOW='\033[43m'      # YELLOW
On_BLUE='\033[44m'        # BLUE
On_PURPLE='\033[45m'      # PURPLE
On_CYAN='\033[46m'        # CYAN
On_WHITE='\033[47m'       # WHITE



# Menu
clear

VERSION=1.0
FILES=$(curl -s -H "Accept: application/vnd.github.v3+json" \
    "https://api.github.com/repos/Deblok-Workshop/kasm-scripts/contents/" 2>/dev/null \
    | jq -r '.[] | select(.type == "file") | .name')
LENGTH=$(echo "$FILES" | wc -l)
LENGTH=$((LENGTH - 2)) # excluding 2 files
SELECTED=0

printf "$YELLOW---$OFF$BGREEN kasm-scripts Menu $BLUE(v$VERSION)$OFF $YELLOW---\n"

printf "$OFF"



print_menu() {
    clear
    printf "$YELLOW---$OFF$BGREEN kasm-scripts Menu $BLUE(v$VERSION)$OFF $YELLOW---\n"
    local index=0
    while IFS= read -r filename; do
        if [[ "$filename" != "LICENSE" && "$filename" != "README.md" ]]; then
            if [ "$index" -eq "$SELECTED" ]; then
                printf "$BBLUE- $BLUE$filename$OFF\n"
            else
                printf "$PURPLE  $filename$OFF\n"
            fi
            ((index++))
        fi
    done <<< "$FILES"
}


print_menu
while true; do
    read -rsn3 key
    case "$key" in
        $'\x1b[A') ((SELECTED--)) ;; 
        $'\x1b[B') ((SELECTED++)) ;;
        "") break ;; 
    esac
    TMP=$LENGTH
    TMP=$((TMP + 1))
    if [ "$SELECTED" -lt 0 ]; then
        SELECTED=$LENGTH
        SELECTED=$((SELECTED - 1))
    elif [ "$SELECTED" -ge "$LENGTH" ]; then
        SELECTED=0
    fi
    print_menu
done
SEL1IDX=$((SELECTED + 1))
echo $(echo -e "$FILES" | sed -n "$SEL1IDX p")
clear
printf "$YELLOW---$OFF$BGREEN kasm-scripts Menu $BLUE(v$VERSION)$OFF $YELLOW---\n"
