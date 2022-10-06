init_prompt () {
    paint_prompt
    set_shortcuts
}

paint_prompt() {
    PROD=$'MY_K8S_PROD_CONTEXT' # change to your production context
    newline=$'\n'

    PROMPT='$fg[magenta]% ($(date +"%H:%M:%S")) ' # current time
    PROMPT+='%{$fg[green]%}%n@%m %{$fg[cyan]%}%~' # username and current folder
    PROMPT+='$([[ $(k8s_context) =~ ${PROD} ]] && echo %{$fg_bold[red]%} || echo %{$fg[yellow]%})$(k8s_context) ' # kubernetes context. red if prod, else yellow
    PROMPT+='%{$fg_bold[blue]%}$(git_prompt_info)${newline}' # current Git branch
    PROMPT+='%(?.%{$fg_bold[cyan]%}.%{$fg_bold[red]%}) -» %{$reset_color%}' # cyan or red based on if the previous command exited properly

    ZSH_THEME_GIT_PROMPT_PREFIX="("
    ZSH_THEME_GIT_PROMPT_SUFFIX=") "
    ZSH_THEME_GIT_PROMPT_DIRTY=" ✗"
    ZSH_THEME_GIT_PROMPT_CLEAN=" ✔"
}

# echo current Kubernetes context
k8s_context() {
    CONTEXT=$(cat ~/.kube/config | grep "current-context:" | sed "s/current-context: //")

    if [ -n "$CONTEXT" ]; then
        echo " ${CONTEXT}"
    fi
}

set_shortcuts() {
   alias ..='cd ..'
   alias ...='cd ../..'
   alias ....='cd ../../..'
   alias .....='cd ../../../..'
   alias ......='cd ../../../../..'
   alias .......='cd ../../../../../..'
   alias ........='cd ../../../../../../..'
   alias .........='cd ../../../../../../../..'
   alias ..........='cd ../../../../../../../../..'
   alias ...........='cd ../../../../../../../../../..'
   alias ............='cd ../../../../../../../../../../..'

   alias rr='cd $(git rev-parse --show-toplevel)' # cd to repo's root
   alias k='kubectl'
   alias ftree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'" # file tree of current directory
   alias fusage="find . -maxdepth 1 -type d -mindepth 1 -exec du -hs {} \;" # space usage of dirs inside current directory
   alias hg='history | grep '
}

# 'cd ..' X amount of times, for example 'up 4' == cd ../../../..
up()
{
    dir=""
    if [[ $1 =~ ^[0-9]+$ ]]; then
        x=0
        while [ $x -lt ${1:-1} ]; do
            dir=${dir}../
            x=$(($x+1))
        done
    else
         dir=..
    fi
    cd "$dir";
}
