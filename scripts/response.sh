#!/usr/bin/env bash
#
# Shell Response Text/Colors/Helpers
#
# This file contains text/color effects and
# text-response helper functions for Shell scripts.

# Color Switch
export SWITCH='\033['

# Clear whole line and hard-line-return
export ClearLine="${SWITCH}2K"
export ClearLineReturn="${ClearLine}\r"
export ClearNewLine="${ClearLineReturn}\n"

# Text Attributes
export Reset="${SWITCH}0m"
export Bold="${SWITCH}1m"
export Dim="${SWITCH}2m"
export Underline="${SWITCH}4m"
export Blink="${SWITCH}5m"
export Reverse="${SWITCH}7m"
export Hidden="${SWITCH}8m"

# Regular Colors
export Black="${SWITCH}0;30m"       # Black
export Red="${SWITCH}0;31m"         # Red
export Green="${SWITCH}0;32m"       # Green
export Yellow="${SWITCH}0;33m"      # Yellow
export Blue="${SWITCH}0;34m"        # Blue
export Magenta="${SWITCH}0;35m"     # Magenta
export Cyan="${SWITCH}0;36m"        # Cyan
export White="${SWITCH}0;37m"       # White
export Default="${SWITCH}0;39m"     # Default

# Bold
export BBlack="${SWITCH}1;30m"      # Black
export BRed="${SWITCH}1;31m"        # Red
export BGreen="${SWITCH}1;32m"      # Green
export BYellow="${SWITCH}1;33m"     # Yellow
export BBlue="${SWITCH}1;34m"       # Blue
export BMagenta="${SWITCH}1;35m"    # Magenta
export BCyan="${SWITCH}1;36m"       # Cyan
export BWhite="${SWITCH}1;37m"      # White
export BDefault="${SWITCH}1;39m"    # Default

# Underline
export UBlack="${SWITCH}4;30m"      # Black
export URed="${SWITCH}4;31m"        # Red
export UGreen="${SWITCH}4;32m"      # Green
export UYellow="${SWITCH}4;33m"     # Yellow
export UBlue="${SWITCH}4;34m"       # Blue
export UMagenta="${SWITCH}4;35m"    # Magenta
export UCyan="${SWITCH}4;36m"       # Cyan
export UWhite="${SWITCH}4;37m"      # White
export UDefault="${SWITCH}4;39m"    # Default

# Background
export BGBlack="${SWITCH}40m"       # Black
export BGRed="${SWITCH}41m"         # Red
export BGGreen="${SWITCH}42m"       # Green
export BGYellow="${SWITCH}43m"      # Yellow
export BGBlue="${SWITCH}44m"        # Blue
export BGMagenta="${SWITCH}45m"     # Magenta
export BGCyan="${SWITCH}46m"        # Cyan
export BGWhite="${SWITCH}47m"       # White
export BGDefault="${SWITCH}49m"     # Default

# High Intensity
export IBlack="${SWITCH}0;90m"      # Black
export IRed="${SWITCH}0;91m"        # Red
export IGreen="${SWITCH}0;92m"      # Green
export IYellow="${SWITCH}0;93m"     # Yellow
export IBlue="${SWITCH}0;94m"       # Blue
export IMagenta="${SWITCH}0;95m"    # Magenta
export ICyan="${SWITCH}0;96m"       # Cyan
export IWhite="${SWITCH}0;97m"      # White
export IDefault="${SWITCH}0;99m"    # Default

# Bold High Intensity
export BIBlack="${SWITCH}1;90m"     # Black
export BIRed="${SWITCH}1;91m"       # Red
export BIGreen="${SWITCH}1;92m"     # Green
export BIYellow="${SWITCH}1;93m"    # Yellow
export BIBlue="${SWITCH}1;94m"      # Blue
export BIMagenta="${SWITCH}1;95m"   # Magenta
export BICyan="${SWITCH}1;96m"      # Cyan
export BIWhite="${SWITCH}1;97m"     # White
export BIDefault="${SWITCH}1;99m"   # Default

# High Intensity backgrounds
export BGIBlack="${SWITCH}0;100m"   # Black
export BGIRed="${SWITCH}0;101m"     # Red
export BGIGreen="${SWITCH}0;102m"   # Green
export BGIYellow="${SWITCH}0;103m"  # Yellow
export BGIBlue="${SWITCH}0;104m"    # Blue
export BGIMagenta="${SWITCH}0;105m" # Magenta
export BGICyan="${SWITCH}0;106m"    # Cyan
export BGIWhite="${SWITCH}0;107m"   # White
export BGIDefault="${SWITCH}0;109m" # Default

# ------------------------------------------------------------------------------
# Shell Response Helpers
# ------------------------------------------------------------------------------

sh_alert () {
  printf "${ClearNewLine} [${Yellow} !! ${Reset}]  ${Yellow}$1${Reset} \n"
}
export sh_alert

sh_error () {
  printf "${ClearNewLine} [${Red} ER ${Reset}]  ${Red}$1${Reset} \n"
}
export sh_error

sh_fail () {
  printf "${ClearNewLine} [${Red}FAIL${Reset}]  ${Red}$1${Reset} \n"
  echo ''
  exit 3
}
export sh_fail

sh_heading () {
  printf "${ClearNewLine}\n         ${Bold}${Underline}$1${Reset} \n\n"
}
export sh_head

sh_info () {
  printf "${ClearNewLine} [${Blue} .. ${Reset}]  $1 \n"
}
export sh_info

sh_note () {
  printf "${ClearNewLine} [${Cyan} ** ${Reset}]  $1 \n"
}
export sh_note

sh_success () {
  printf "${ClearNewLine} [${Green} OK ${Reset}]  ${Green}$1${Reset} \n"
}
export sh_success

sh_text () {
  printf "${ClearNewLine}         $1 \n"
}
export sh_text

sh_user () {
  printf "${ClearNewLine} [${Yellow} ?? ${Reset}]  $1 \n"
}
export sh_user

sh_yesno () {
  sh_user "$1"
  sh_text "${Underline}y${Reset}es / ${Underline}n${Reset}o"
}
export sh_yesno

# ------------------------------------------------------------------------------

sh_msg () {
  printf "${ClearNewLine}\n❯❯❯ $1 \n"
}
export sh_msg

sh_start () {
  echo "$(date +%s)"
}
export sh_start

sh_end () {
  end=$(date +%s)
  msg=""
  if [ ! -z "$1" ]; then
    runlen=$(echo "$end - $1" | bc)
    if type "python" &> /dev/null; then
      runtime=$(python -c "print '%u:%02u' % ($runlen/60, $runlen%60)")
    else
      runtime="$runlen seconds"
    fi
    msg="runtime: $runtime"
  fi
  sh_msg "$msg\n\n"
}
export sh_end

