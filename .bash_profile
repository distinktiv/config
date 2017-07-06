code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;} 
#if which jenv > /dev/null; then eval "$(jenv init -)"; fi

#Autocomplete ssh commands
WL="$(perl -ne 'print "$1\n" if /^Host (.+)$/' ~/.ssh/config | grep -v "*" | tr "\n" " ")"
complete -o plusdirs -f -W "$WL" ssh scp


#Git branch displayed and colored
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}


#Sources Exports
if [ -f ~/.bash_exports ]; then
    source ~/.bash_exports
fi

#Source Aliases
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

#Load tmux if exist
if command -v tmux>/dev/null; then
  [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
fi

