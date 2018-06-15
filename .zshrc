# (d) is default on

# ------------------------------
# General Settings
# ------------------------------
export PATH=$PATH:/c/0/Pandoc

export EDITOR=vim  # set default editor as vim
export LANG=ja_JP.UTF-8  # use utf-8
export KCODE=u  # set kcode as utf-8
autoload -Uz add-zsh-hook  # use add-zsh-hook package

# bindkey -e  # use emacs keybind such as, C-e for EOL
bindkey -v  # use vi keybind
bindkey -M viins '^R' history-incremental-search-backward

setopt no_beep
setopt auto_cd
setopt auto_pushd
setopt correct
setopt magic_equal_subst  # complete pathname parameter after = 
setopt notify  # notice status of jobs even if background
KEYTIMEOUT=1

### Completion ###
autoload -U compinit; compinit -u  # complete
setopt auto_list  # list up candidates when vague
setopt auto_menu  # suggest completion on TAB
setopt list_packed  # pack suggestion
setopt list_types  # show file type like ls -F
bindkey "^[[Z" reverse-menu-complete  # shift+TAB for reverse completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'  # ignore case for completion

### Glob ###
setopt extended_glob
unsetopt caseglob  # ignore case for glob

### History ###
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt bang_hist  #  expand history when using !
setopt extended_history  # save timestamp and duration time
setopt hist_ignore_dups  # do not save duplicate commands
setopt share_history
setopt hist_reduce_blanks  # trim extra spaces
setopt hist_ignore_space  # do not save when starts with space

## able to search Ctrl+p or Ctrl+n and move cursol EOL
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

function history-all { history -E 1 }  # command to show all histories


# ------------------------------
# Look And Feel Settings
# ------------------------------
### Ls Color ### 
# auto color when ls
export LSCOLORS=Exfxcxdxbxegedabagacad 
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
export CLICOLOR=true
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}  # color when completion

### GIT git ###
autoload -Uz vcs_info
setopt prompt_subst  # able to use variable on prompt. for git*+!
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{green}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{magenta}+"
zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f" 
zstyle ':vcs_info:*' actionformats '[%b|%a]' 
add-zsh-hook precmd vcs_info
git_info='${vcs_info_msg_0_}'

### Prompt ### 
autoload -U colors; colors  # color prompt

#color check
# for c in {000..255}; do echo -n "\e[38;5;${c}m $c" ; [ $(($c%16)) -eq 15 ] && echo;done;echo

#tmp_prompt="%{${fg[cyan]}%}%n %# %{${reset_color}%}"
#tmp_rprompt="%{${fg[magenta]}%}[%~]%{${reset_color}%}"
#tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"

# tmp_prompt=$'%{\e[38;5;199m%}%n %# %{\e[m%}'
# tmp_prompt2=$'%{\e[38;5;199m%}%_> %{\e[m%}'
tmp_rprompt=$'%{\e[38;5;199m%}[%~]%{\e[m%}'
tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"

## for root user
if [ ${UID} -eq 0 ]; then
  tmp_prompt="%B%U${tmp_prompt}%u%b"
  tmp_prompt2="%B%U${tmp_prompt2}%u%b"
  tmp_rprompt="%B%U${tmp_rprompt}%u%b"
  tmp_sprompt="%B%U${tmp_sprompt}%u%b"
fi

PROMPT=$tmp_prompt  # normal prompt
PROMPT2=$tmp_prompt2  # prompt for 2 lines
RPROMPT=$git_info$tmp_rprompt  # light side prompt
SPROMPT=$tmp_sprompt  # prompt for spell check

# prompt for ssh login
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
;
function zle-line-init zle-keymap-select {
  case $KEYMAP in
    vicmd)
      FC="005"
      ;;
    main|viins)
      FC="199"
      ;;
  esac
  tmp_prompt=$'%{\e[38;5;${FC}m%}%n %# %{\e[m%}'
  tmp_prompt2=$'%{\e[38;5;${FC}m%}%_> %{\e[m%}'
  PROMPT=$tmp_prompt  # normal prompt
  PROMPT2=$tmp_prompt2  # prompt for 2 lines
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

### Title (user@hostname) ###
case "${TERM}" in
(kterm*|xterm*|)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}\007"
  }
  ;;
esac


# ------------------------------
# Other Settings
# ------------------------------

### Aliases ###
alias vi="vim"
alias sz="source ~/.zshrc"
alias less="less -SM"
alias ls="ls --color=auto"
alias la="ls -a"
alias ll="ls -l"
alias lc="wc -l"
alias sc="screen"
alias scr="screen -r"
alias scls="screen -ls"
alias scw="screen -wipe"
alias tx="tmux"
alias txn="tmux new -s"
alias ta="tmux a -t"
alias gitlab="ssh -L 8080:192.168.1.116:80 sky"
alias g11="g++ -std=c++11"
alias pip="py -2 -m pip"
alias pip3="py -3 -m pip"
alias g="git"
alias gap="git add -p"
alias gs="git status"

bindkey "^[[3~" delete-char
## Home and End key mapping
# for cygwin
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
# for linux
bindkey "^[OH" beginning-of-line
bindkey "^[OF" end-of-line
# for screen
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
