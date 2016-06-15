#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# 检测是否是root账户权限
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root to install SVN"
    exit 1
fi

#安装SVN
apt-get install subversion

#启动SVN
svnserve -d

#安装成功的欢迎致辞！
echo "Svn install chenggong!";
