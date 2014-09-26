# !/bin/sh

# Program:
# 	Generate ssh public key and post.
# History:
# 09/25/2014. William Sterling.
#

LOCAL_PUB=$HOME/.ssh/id_rsa.pub

##<---------------
# Configure ssh key.

while read -p "输入要使用的git用户名:" NAME
do 
read -p "是否确定使用?<y/N>:"
if [ "$REPLY" == "y" ]; then
	break
fi
done

echo "\033[1m接下来，无论提示神马，只须按回车 \033[0m"
ssh-keygen -t rsa -C "$NAME@jinher" -f $HOME/.ssh/$NAME
##--------------->


##<---------------
# Setup git ..

function git_configuration()
{
    git config --global --add user.email "$NAME"
    git config --global --add user.name "$NAME@jinher"
    git config --global alias.co checkout  
    git config --global alias.ci commit  
    git config --global alias.br branch  
    git config --global alias.st status  
    git config --global alias.last 'log -1 HEAD'  
    git config --global color.diff auto  
    git config --global color.status auto  
    git config --global color.branch auto  
}

git_configuration
##--------------->


##--------------->
# Send public key 
curl -T $HOME/.ssh/$NAME.pub -u public:public ftp://ho-ur.com
echo "\033[1m配置完成，请等待GIT管理员通知 \033[0m"
##--------------->
