#!/bin/sh

#######DRY RUN FOR TEST#######
# dry_run=0

# while getopts 'n' opt; do
#     case "$opt" in
#         n) dry_run=1 ;;
#         *) echo 'error in command line parsing' >&2
#             exit 1
#     esac
# done

# if [ "$dry_run" -eq 1 ]; then
#     set -v
#     set -n
# fi

#######INSTALL BEGIN#######

#Install some utilities
tools_dir="$HOME/tools"
echo "Install some utilities ..."
[[ -d $tools_dir ]] && {
    rm -rf $tools_dir
}
tar -cvf - tools | tar -xvf - -C $HOME

#configure bashrc for bash
echo "Add custom changes to .bashrc file ..."
cp ~/.bashrc bashrc
echo "#===========begin:user custom definition=========" >> bashrc
echo "alias grep='grep -nr --color=auto' --exclude-dir=.ccls-cache" >> bashrc
echo "alias rm='rm -i'" >> bashrc
echo "source $tools_dir/aliasfile" >> bashrc
echo "PATH=$PATH:$tools_dir" >> bashrc

cat >> bashrc <<'EOF'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
EOF
echo "#===========end:user custom definition=========" >> bashrc

if [[ -n ${DEBUG} ]]; then
    echo "******************************************************"
    diff -Nur ~/.bashrc bashrc
    echo "******************************************************"
    read -p "please confirm changes for .bashrc" tmp
    cp bashrc ~/.bashrc
fi

#configure git setttings
echo "Configure git setttings..."
read -p "user name for git" username
read -p "user email for git" useremail
git config --global user.name $username
git config --global user.email $useremail
git config --global core.editor vim
git config --global merge.tool vimdiff
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.rb rebase
git config --global push.default simple

#configure vim
echo "Configure VIM ..."
vimrc_file="$HOME/.vimrc"
vim_dir="$HOME/.vim"

[[ -f $vimrc_file ]] && {
    rm -rf $vimrc_file
}
ln -s $vim_dir/init.vim $HOME/.vimrc

[[ -f $vim_dir ]] && {
    rm -rf $vim_dir
}
tar -cvf - vim | tar -xvf - -C $HOME && mv $HOME/vim $HOME/.vim
