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
	echo "Reopen script when brew installed"
	#exit 0
fi

##<!-----------------
# INSTALL UTILS WITH HOMEBREW

## Check if the brew-cask installed. it was diffrent to the others. :)
if [ ! -d "/usr/local/Library/Taps/phinze-cask" ]; then
	brew tap phinze/cask
fi
## Intall brewcask.
if [ ! `which brew cask` ]; then
	install_util_with_brew brew-cask
fi
## Install brew utils.
install_util_with_brew wget
install_util_with_brew cowsay
install_util_with_brew sl
if [ ! -e "/Applications/Google Chrome.app" ]; then
	brew cask install google-chrome
fi
if [ ! -e "/Applications/QQ.app" ]; then
	brew cask install qq
fi
##------------------>


# Clone other workflow files form github.
rm -rf $SCRIPT_DIRECTORY/workflow
mkdir -p $SCRIPT_DIRECTORY/workflow && cd $SCRIPT_DIRECTORY/workflow && sudo rm -rf *
curl -L https://github.com/gslqy/workflow/tarball/master | tar zx -m --strip 1


##<!-----------------
# SETUP SHELL

# Config shell, copy /workflow/.bash_profile to user directory.
sudo cp .bash_profile $HOME
source $HOME/.bash_profile
# Vim configuration..
sudo cp .vimrc $HOME
## Install terminal dictionary :)
sudo rm /usr/bin/dict*
sudo cp $(pwd)/dict* /usr/bin/
##------------------>


##<!-----------------
# SETUP XCODE

# Config CodeSnippets & FontAndColorThemes & KeyBindings
cp -r $SCRIPT_DIRECTORY/workflow/XcodePreference/* $HOME/Library/Developer/Xcode/UserData

# Make brace on a single line..
SYSTEM_SNIPPET_FILE=`find /Applications/Xcode.app -name "SystemCodeSnippets.codesnippets"`
if [ ! -f "$SYSTEM_SNIPPET_FILE.tmp" ]; then
	cp $SYSTEM_SNIPPET_FILE $SYSTEM_SNIPPET_FILE.tmp
	cp SystemCodeSnippets.codesnippets $SYSTEM_SNIPPET_FILE
fi

# Install XVim
XVIM_PLUGIN_FILE="$HOME/Library/Application Support/Developer/Shared/Xcode/Plug-ins/XVim.xcplugin"
if [ ! -f "$XVIM_PLUGIN_FILE" ]; then
	#xcodebuild -project XVim.xcodeproj -configuration release ARCHS=x86_64
	sudo cp -r plugins/XVim.xcplugin $XVIM_PLUGIN_FILE
fi
##------------------>


##<!-----------------
# CONFIG WITH OPTION
if [ "$1" == "-g" ]; then
	git_configuration	
fi
##------------------>
