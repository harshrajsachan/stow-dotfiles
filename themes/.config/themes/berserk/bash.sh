# =========================
# Berserk Bash Theme
# =========================

# Prompt colors
THEME_FG='\e[38;5;255m'
THEME_RESET='\e[0m'

# Prompt
PS1='\[\e[38;5;255m\]  $( [[ "$PWD" == "$HOME" ]] && printf "  " || printf "%s" "${PWD#$HOME/}" )\[\e[0m\]\n ❯ '

# =========================
# LS Colors
# =========================

export LS_COLORS="
di=38;5;255:
fi=38;5;250:
ln=38;5;252:
pi=38;5;245:
so=38;5;248:
bd=38;5;255:
cd=38;5;255:
or=38;5;255:
ex=38;5;255:
tw=38;5;250:
ow=38;5;250:
st=38;5;255"
