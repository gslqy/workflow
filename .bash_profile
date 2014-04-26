export CLICOLOR=1
export script=$HOME/Documents/Utils/Script
export desk=$HOME/Desktop
export doc=$HOME/Documents

alias go="source $script/workflow/lunch"

#make the shell git prefix
function parse_git_branch_and_add_brackets 
{
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ \[\1\]/'
}
PS1="\[\e[35;1m\]William's mbp:\[\e[031;1m\]\W\[\e[33;1m\]\$(parse_git_branch_and_add_brackets) \[\033[0m\]\$ "
