# .bashrc
fastfetch
export LANG="en_US.UTF-8"
export LC_ALL="C.UTF-8"
export PATH=/var/lib/flatpak/exports/bin:$PATH
export PATH=~/.local/share/flatpak/exports/bin:$PATH
source /usr/share/bash-completion/completions/flatpak
alias ls='ls --color'
alias ll='ls --color -lshr' 
alias yt-dlp='yt-dlp --cookies-from-browser firefox -o "%(title).200s.%(ext)s"'
alias yt-music='yt-dlp --live-from-start -o "%(title).200s.%(ext)s" --ignore-errors --continue --no-overwrites -x -f bestaudio --add-metadata --embed-thumbnail'

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
        for rc in ~/.bashrc.d/*; do
                if [ -f "$rc" ]; then
                        . "$rc"
                fi
        done
fi

git_current_head () {
  git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD
}

git_dirty_mark () {
  if [[ $(pwd | grep -v "\.git" | wc -l) -gt 0 ]]
  then
    [[ -n $(git status -s | head -c 1) ]] && echo \*
  fi
}

show_git_prompt () {
  git branch 2>/dev/null 1>&2 && echo -e "\e[34;1m$(git_current_head)$(git_dirty_mark)\e[31;1m"
}

if [[ -n $(type -t git) ]] ; then
  PS1="\$(show_git_prompt)"
else
  PS1=
fi
#\e[39;1m\]\j\[\e[31;1m\]
PS1="
\[\e[31;1m\]┌─── \[\e[39;1m\]\u\[\e[31;1m@\$(hostname -f) - \[\e[39;1m\]\w\[\e[31;1m\] - $PS1
\[\e[31;1m\]└── \[\e[0m\]"

# Display running command in GNU Screen window status
#
# In .screenrc, set: shelltitle "( |~"
#
# See: http://aperiodic.net/screen/title_examples#setting_the_title_to_the_name_of_the_running_program
case $TERM in screen*)
  PS1=${PS1}'\[\033k\033\\\]'
esac
unset rc
