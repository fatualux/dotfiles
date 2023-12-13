#!/bin/bash

# add user-installed apps to my PATH
export PATH="$PATH:$HOME/.scripts"
export PATH="$PATH:$HOME/Apps"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.cargo/bin"

# Hystory settings

# adds the history of the buffer to the end of the history file
shopt -s histappend

# prevent duplicate entries from being saved in the $HISTFILE
export HISTCONTROL=ignoreboth:erasedups

# updates the history cache
export PROMPT_COMMAND="history -n; history -w; history -c; history -r"
# history -n reads all lines from $HISTFILE that may have occurred
# in a different terminal since the last carriage return
# history -w writes the updated buffer to $HISTFILE
# history -c wipes the buffer so no duplication occurs
# history -r re-reads the $HISTFILE, appending to the now blank buffer

# stores the first occurrence of each line it encounters.
# tac reverses it, and then reverses it back so that it can be saved with
# the most recent commands still most recent in the History
tac "$HISTFILE" | awk '!x[$0]++' > /tmp/tmpfile  && tac /tmp/tmpfile > "$HISTFILE"
rm /tmp/tmpfile

export HISTFILESIZE=5000
export HISTSIZE=1000

# Function to remove last history lines
# It takes the offset argument:
# Example: histdel 10 (to remove first ten lines)
# Example: histdeln 20 (to remove last twenty lines)

histdel(){
  for h in $(seq $1 $2); do
    history -d $1
  done
  history -d $(history 1 | awk '{print $1}')
  }

histdeln(){
  # Get the current history number
  n=$(history 1 | awk '{print $1}')
  # Call histdel with the appropriate range
  histdel $(( $n - $1 )) $(( $n - 1 ))
  }

# shopt options
shopt -s cdspell         # This will correct minor spelling errors in a cd command.
shopt -s checkwinsize    # Check window after each command and updates the values of LINES and COLUMNS
shopt -s histappend      # Append History instead of overwriting file
shopt -s cmdhist         # try to save all lines of a multiple-line command in the same entry

# INITIAL SCREEN

echo -ne "\\e[1m\\e[93mSYSTEM INFORMATION:";
echo -e "\\e[1m\\e[96m";uname; uname -rm;

echo ""

echo -ne "\\e[1m\\e[93mUPTIME:";
echo -e "\\e[1m\\e[96m";

uptime=$(</proc/uptime)
uptime=${uptime%%.*}

seconds=$(( uptime%60 ))
minutes=$(( uptime/60%60 ))
hours=$(( uptime/60/60%24 ))
days=$(( uptime/60/60/24 ))

echo "$days days, $hours hours, $minutes minutes, $seconds seconds";

echo " "

### Default color:
export PS1='\[\e[36m\][\u@\h \W]\$ \[\e(B\e[m\]'

# Disown application from terminal when launched by shell command
PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'disown -a -h'

# Default apps

export BROWSER='firefox'
export VISUAL=vim
export EDITOR=vim
#replace Chrome with Chromium
export CHROME_EXECUTABLE="/bin/chromium"

# Aliases
alias grep='grep --color=auto'
alias fluxion="cd $HOME/Downloads && sudo fluxion "
alias tor-browser="sh Downloads/tor-browser/Browser/start-tor-browser"
alias pip="python -m pip"
alias pip3="python3 -m pip"
alias wifite="cd $HOME/Downloads && sudo wifite "
alias tor="sh -c '"$HOME/Downloads/tor-browser/Browser/start-tor-browser" --detach || ([ ! -x "$HOME/Downloads/tor-browser/Browser/start-tor-browser" ] && "$(dirname "$*")"/Browser/start-tor-browser --detach)' dummy %k $$ exit"
alias powertop="sudo powertop --auto-tune && sudo powertop"
alias sway="sway --unsupported-gpu"
alias scrcpy="scrcpy -w --disable-screensaver --kill-adb-on-close & --disown "
alias wget="aria2c"
alias ghlicense="source $HOME/.virtualenv/GH-license/bin/activate"

# Option for bash-completion
if ! shopt -oq posix; then
if [ -f /usr/share/bash-completion/bash_completion ]; then
. /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
. /etc/bash_completion
fi
fi

export QT_QPA_PLATFORMTHEME=qt5ct
export QT_QPA_PLATFORM=wayland
export GDK_BACKEND=wayland
export MOZ_ENABLE_WAYLAND=1 
