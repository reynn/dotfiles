CP="$DFP/zsh/.colors.zsh"

# -----------------------------------------------------------------------------
#### File Aliases -------------------------------------------------------------
alias CE="vim $CP" # alias edit
alias CR="source $CP" # alias reload

# -----------------------------------------------------------------------------
# Colors ----------------------------------------------------------------------

# -----------------------------------------------------------------------------
## Colors:Foreground ----------------------------------------------------------
export COLOR_FG_DEFAULT="39"
export COLOR_FG_BLACK="30"
export COLOR_FG_RED="31"
export COLOR_FG_GREEN="32"
export COLOR_FG_YELLOW="33"
export COLOR_FG_BLUE="34"
export COLOR_FG_MAGENTA="35"
export COLOR_FG_CYAN="36"
export COLOR_FG_LIGHT_GRAY="37"
export COLOR_FG_DARK_GRAY="90"
export COLOR_FG_LIGHT_RED="91"
export COLOR_FG_LIGHT_GREEN="92"
export COLOR_FG_LIGHT_YELLOW="93"
export COLOR_FG_LIGHT_BLUE="94"
export COLOR_FG_LIGHT_MAGENTA="95"
export COLOR_FG_LIGHT_CYAN="96"
export COLOR_FG_WHITE="97"

# -----------------------------------------------------------------------------
## Colors:Background ----------------------------------------------------------
export COLOR_BG_DEFAULT="49"
export COLOR_BG_BLACK="40"
export COLOR_BG_RED="41"
export COLOR_BG_GREEN="42"
export COLOR_BG_YELLOW="43"
export COLOR_BG_BLUE="44"
export COLOR_BG_MAGENTA="45"
export COLOR_BG_CYAN="46"
export COLOR_BG_LIGHT_GRAY="47"
export COLOR_BG_DARK_GRAY="100"
export COLOR_BG_LIGHT_RED="101"
export COLOR_BG_LIGHT_GREEN="102"
export COLOR_BG_LIGHT_YELLOW="103"
export COLOR_BG_LIGHT_BLUE="104"
export COLOR_BG_LIGHT_MAGENTA="105"
export COLOR_BG_LIGHT_CYAN="106"
export COLOR_BG_WHITE="107"

# -----------------------------------------------------------------------------
## Colors:Logging -------------------------------------------------------------

export COLOR_ERROR="196"
export COLOR_DEBUG="243"
export COLOR_INFO="2"
export COLOR_WARNING="226"
export COLOR_USAGE="57"

# -----------------------------------------------------------------------------
# Text ------------------------------------------------------------------------

# -----------------------------------------------------------------------------
## Text:Formats ---------------------------------------------------------------
export FMT_FG_DEFAULT="\e[38;5;${COLOR_FG_DEFAULT}m"
export FMT_FG_BLACK="\e[38;5;${COLOR_FG_BLACK}m"
export FMT_FG_RED="\e[38;5;${COLOR_FG_RED}m"
export FMT_FG_GREEN="\e[38;5;${COLOR_FG_GREEN}m"
export FMT_FG_YELLOW="\e[38;5;${COLOR_FG_YELLOW}m"
export FMT_FG_BLUE="\e[38;5;${COLOR_FG_BLUE}m"
export FMT_FG_MAGENTA="\e[38;5;${COLOR_FG_MAGENTA}m"
export FMT_FG_CYAN="\e[38;5;${COLOR_FG_CYAN}m"
export FMT_FG_LIGHT_GRAY="\e[38;5;${COLOR_FG_LIGHT_GRAY}m"
export FMT_FG_DARK_GRAY="\e[38;5;${COLOR_FG_DARK_GRAY}m"
export FMT_FG_LIGHT_RED="\e[38;5;${COLOR_FG_LIGHT_RED}m"
export FMT_FG_LIGHT_GREEN="\e[38;5;${COLOR_FG_LIGHT_GREEN}m"
export FMT_FG_LIGHT_YELLOW="\e[38;5;${COLOR_FG_LIGHT_YELLOW}m"
export FMT_FG_LIGHT_BLUE="\e[38;5;${COLOR_FG_LIGHT_BLUE}m"
export FMT_FG_LIGHT_MAGENTA="\e[38;5;${COLOR_FG_LIGHT_MAGENTA}m"
export FMT_FG_LIGHT_CYAN="\e[38;5;${COLOR_FG_LIGHT_CYAN}m"
export FMT_FG_WHITE="\e[38;5;${COLOR_FG_WHITE}m"

export FMT_BG_DEFAULT="\e[38;5;${COLOR_BG_DEFAULT}m"
export FMT_BG_BLACK="\e[38;5;${COLOR_BG_BLACK}m"
export FMT_BG_RED="\e[38;5;${COLOR_BG_RED}m"
export FMT_BG_GREEN="\e[38;5;${COLOR_BG_GREEN}m"
export FMT_BG_YELLOW="\e[38;5;${COLOR_BG_YELLOW}m"
export FMT_BG_BLUE="\e[38;5;${COLOR_BG_BLUE}m"
export FMT_BG_MAGENTA="\e[38;5;${COLOR_BG_MAGENTA}m"
export FMT_BG_CYAN="\e[38;5;${COLOR_BG_CYAN}m"
export FMT_BG_LIGHT_GRAY="\e[38;5;${COLOR_BG_LIGHT_GRAY}m"
export FMT_BG_DARK_GRAY="\e[38;5;${COLOR_BG_DARK_GRAY}m"
export FMT_BG_LIGHT_RED="\e[38;5;${COLOR_BG_LIGHT_RED}m"
export FMT_BG_LIGHT_GREEN="\e[38;5;${COLOR_BG_LIGHT_GREEN}m"
export FMT_BG_LIGHT_YELLOW="\e[38;5;${COLOR_BG_LIGHT_YELLOW}m"
export FMT_BG_LIGHT_BLUE="\e[38;5;${COLOR_BG_LIGHT_BLUE}m"
export FMT_BG_LIGHT_MAGENTA="\e[38;5;${COLOR_BG_LIGHT_MAGENTA}m"
export FMT_BG_LIGHT_CYAN="\e[38;5;${COLOR_BG_LIGHT_CYAN}m"
export FMT_BG_WHITE="\e[38;5;${COLOR_BG_WHITE}m"


# -----------------------------------------------------------------------------
## Text:Formats ---------------------------------------------------------------
export FMT_ERROR="\e[38;5;${COLOR_ERROR}m"
export FMT_DEBUG="\e[38;5;${COLOR_DEBUG}m"
export FMT_INFO="\e[38;5;${COLOR_INFO}m"
export FMT_WARNING="\e[38;5;${COLOR_WARNING}m"
export FMT_USAGE="\e[38;5;${COLOR_USAGE}m"

# -----------------------------------------------------------------------------
## Text:Formats ---------------------------------------------------------------
export FMT_SET_BOLD="\e[1m"
export FMT_SET_DIM="\e[2m"
export FMT_SET_UNDERLINED="\e[4m"
export FMT_SET_BLINK="\e[5m"
export FMT_SET_INVERTED="\e[7m"
export FMT_SET_HIDDEN="\e[8m"

export FMT_CLEAR_ALL="\e[0m"
export FMT_CLEAR_BOLD="\e[21m"
export FMT_CLEAR_DIM="\e[22m"
export FMT_CLEAR_UNDERLINED="\e[24m"
export FMT_CLEAR_BLINK="\e[25m"
export FMT_CLEAR_REVERSE="\e[27m"
export FMT_CLEAR_HIDDEN="\e[28m"

# -----------------------------------------------------------------------------
## Text:Characters ------------------------------------------------------------
function text_divider() {
  local fmt="${1:-"$FMT_DEBUG"}"
  local divider="${2:-">>"}"
  printf "$FMT_CLEAR_ALL$fmt$FMT_SET_BOLD$divider"
}

function TXT_DIVIDER() { text_divider }
function INFO_TXT_DIVIDER() { text_divider $FMT_INFO }
function ERROR_TXT_DIVIDER() { text_divider $FMT_ERROR }
function DEBUG_TXT_DIVIDER() { text_divider $FMT_DEBUG }
function USAGE_TXT_DIVIDER() { text_divider $FMT_USAGE }
function WARNING_TXT_DIVIDER() { text_divider $FMT_WARNING }
