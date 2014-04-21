# !/bin/sh

# Program:
#	This file used to config workflow for Mac OS develope.
# History:
# 04/21/2014. William Sterling. 
# 

MACOS_VERSION=`/usr/bin/sw_vers -productVersion`
SCRIPT_DIRECTORY=$HOME/Documents/Utils/Script


function prompt_wait_for_user()
{
	while [ "$yn" != "$2" ]
		do 
			read -p "$1 :" yn
		done
}

function install_util_with_brew()
{
	echo `which $1`
	if [ ! `which $1` ]; then
		brew install $1
	fi
}

function git_configuration()
{
	read -p "Input git email:" email
	read -p "Input git user name:" username
	git config --global --add user.email "$email"
	git config --global --add user.name "$username"
	git config --global alias.co checkout  
	git config --global alias.ci commit  
	git config --global alias.br branch  
	git config --global alias.st status  
	git config --global alias.last 'log -1 HEAD'  
	git config --global color.diff auto  
	git config --global color.status auto  
	git config --global color.branch auto  
}

# Download Xcode if need.
if [ ! `which cc` ]; then
	open "https://developer.apple.com/xcode/downloads/"
	prompt_wait_for_user "Xcode has not installed, now install the latest version. Input 'ok' when install finished" "ok"
fi

# Install homebrew.
if [ ! `which brew` ]; then
	echo "Install homebrew \n"
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"	
fi


# Check if the brew-cask installed. it was diffrent to the others. :)
if [ ! -d "/usr/local/Library/Taps/phinze-cask" ]; then
	brew tap phinze/cask
fi
if [ ! `which brew cask` ]; then
	install_util_with_brew brew-cask
fi
if [ ! `which read line` ]; then
	install_util_with_brew readline
fi
## Install brew utils.
install_util_with_brew wget
install_util_with_brew cowsay
install_util_with_brew sl


# Clone other workflow files form github.
mkdir -p $SCRIPT_DIRECTORY/workflow && cd $SCRIPT_DIRECTORY/workflow && rm -i *
curl -L https://github.com/gslqy/workflow/tarball/master | tar zx -m --strip 1
## Terminal dictionary :)
rm /usr/bin/dict
ln -s $(pwd)/dict /usr/bin/dict
