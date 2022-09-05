init_prompt () {
    paint_prompt
    set_shortcuts
}

paint_prompt() {
    PROD=$'MY_K8S_PROD_CONTEXT' # Change to your production context.
    newline=$'\n'

    PROMPT='%{$fg[green]%}%n@%m %{$fg[cyan]%}%~' # Username and current folder.
    PROMPT+='$([[ $(k8s_context) =~ ${PROD} ]] && echo %{$fg_bold[red]%} || echo %{$fg[yellow]%})$(k8s_context) ' # Kubernetes context. red if prod, else yellow.
    PROMPT+='%{$fg_bold[blue]%}$(git_prompt_info)%{$reset_color%}' # Current Git branch.
    PROMPT+='${newline} -> '

    ZSH_THEME_GIT_PROMPT_PREFIX="("
    ZSH_THEME_GIT_PROMPT_SUFFIX=") "
    ZSH_THEME_GIT_PROMPT_DIRTY=" ✗"
    ZSH_THEME_GIT_PROMPT_CLEAN=" ✔"
}

# Echo current Kubernetes context.
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

   alias rr='cd $(git rev-parse --show-toplevel)' # cd to repo's root.
}
