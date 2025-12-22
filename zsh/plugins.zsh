# Sheldon plugin manager

# Remove path separator from WORDCHARS
WORDCHARS=${WORDCHARS//[\/]}

# zsh-autosuggestions
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Initialize sheldon
eval "$(sheldon source)"
