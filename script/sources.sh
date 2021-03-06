#!/bin/bash

# 操作系统预处理函数
sources(){

    #修改默认的源，添加163源和debian官方源
    if [ -s /etc/apt/sources.list.bak ]; then
        rm /etc/apt/sources.list -f
        mv /etc/apt/sources.list.bak /etc/apt/sources.list
    fi

    #备份sources.list
    mv /etc/apt/sources.list /etc/apt/sources.list.bak

    #获取Debian的版本号 例如8.8
    debianVersion=$(more /etc/debian_version)

    # 截取版本号的第一个数字
    num=${debianVersion%.*}

    if [ "${num}" -eq "9" ]; 
        then
        #添加新的stretch源, 第二个EOF必须顶格写
        cat >> /etc/apt/sources.list <<EOF
            deb http://mirrors.163.com/debian/ stretch main non-free contrib
            deb http://mirrors.163.com/debian/ stretch-updates main non-free contrib
            deb http://mirrors.163.com/debian/ stretch-backports main non-free contrib
            deb-src http://mirrors.163.com/debian/ stretch main non-free contrib
            deb-src http://mirrors.163.com/debian/ stretch-updates main non-free contrib
            deb-src http://mirrors.163.com/debian/ stretch-backports main non-free contrib
            deb http://mirrors.163.com/debian-security/ stretch/updates main non-free contrib
            deb-src http://mirrors.163.com/debian-security/ stretch/updates main non-free contrib

            deb http://security.debian.org/  stretch/updates main
            deb-src http://security.debian.org/  stretch/updates main
            deb http://packages.dotdeb.org  stretch all
            deb-src http://packages.dotdeb.org  stretch all

            deb http://nginx.org/packages/debian/ stretch nginx
            deb-src http://nginx.org/packages/debian/ stretch nginx
EOF

    elif [ "${num}" -eq "8" ]; 
        then
        #添加新的jessie源, 第二个EOF必须顶格写
        cat >> /etc/apt/sources.list <<EOF
            deb http://mirrors.163.com/debian/ jessie main non-free contrib
            deb http://mirrors.163.com/debian/ jessie-updates main non-free contrib
            deb http://mirrors.163.com/debian/ jessie-backports main non-free contrib
            deb-src http://mirrors.163.com/debian/ jessie main non-free contrib
            deb-src http://mirrors.163.com/debian/ jessie-updates main non-free contrib
            deb-src http://mirrors.163.com/debian/ jessie-backports main non-free contrib
            deb http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib
            deb-src http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib

            deb http://security.debian.org/  jessie/updates main
            deb-src http://security.debian.org/  jessie/updates main
            deb http://packages.dotdeb.org  stable all
            deb-src http://packages.dotdeb.org  stable all

            deb http://nginx.org/packages/debian/  	jessie nginx
            deb-src http://nginx.org/packages/debian/  	jessie nginx
EOF
        # Install packages to allow apt to use a repository over HTTPS:
        apt-get install \
            apt-transport-https \
            ca-certificates \
            gnupg2 \
            software-properties-common

        # Add Docker’s official GPG key
        curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -

        # Verify that you now have the key with the fingerprint 9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88, by searching for the last 8 characters of the fingerprint.
        apt-key fingerprint 0EBFCD88

        # Use the following command to set up the stable repository
        add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
        $(lsb_release -cs) \
        stable"

    else
        #添加新的wheezy源, 第二个EOF必须顶格写
        cat >> /etc/apt/sources.list <<EOF
            deb http://mirrors.163.com/debian/  testing contrib main non-free
            deb-src http://mirrors.163.com/debian/  testing contrib main non-free
            deb http://mirrors.163.com/debian/  wheezy-updates main
            deb http://mirrors.163.com/debian  wheezy main non-free contrib
            deb http://mirrors.163.com/debian  wheezy-updates main non-free contrib
            deb-src http://mirrors.163.com/debian/  wheezy-updates main
            deb-src http://mirrors.163.com/debian  wheezy main non-free contrib
            deb-src http://mirrors.163.com/debian  wheezy-updates main non-free contrib

            deb http://security.debian.org/  wheezy/updates main
            deb-src http://security.debian.org/  wheezy/updates main
            deb http://packages.dotdeb.org  stable all
            deb-src http://packages.dotdeb.org  stable all

            deb http://nginx.org/packages/debian/  wheezy nginx
            deb-src http://nginx.org/packages/debian/  wheezy nginx

            deb-src [arch=amd64] https://download.docker.com/linux/debian wheezy stable
EOF

        # Install Node.js 6.x ,Using Debian, as root
        curl -sL https://deb.nodesource.com/setup_6.x | bash -
        #apt-get install -y nodejs

        # Install packages to allow apt to use a repository over HTTPS:
        apt-get install \
            apt-transport-https \
            ca-certificates \
            python-software-properties
    fi
    
    
    # Install Node.js 10.x , Using Debian, as root
    curl -sL https://deb.nodesource.com/setup_10.x | bash -
    #apt-get install -y nodejs

    echo "Debian Version is ${num}"

}