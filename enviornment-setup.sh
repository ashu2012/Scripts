#!/bin/bash
# Ubuntu Developer Script For MIS ETS Setup
# Created by hl_joker [SourabhSingh]
#
#
# Downloads and configures the following
#
#   Maven
#   Activemq
#	Memcache
#	Postgres
#   Tomcat

HOME_PATH=$(cd ~/ && pwd)
INSTALL_PATH=/opt
MAVEN_PATH=/opt/maven 
ACTIVEMQ_PATH=/opt/activemq

# x86_64 or i686
LINUX_ARCH="$(lscpu | grep 'Architecture' | awk -F\: '{ print $2 }' | tr -d ' ')"

# Latest Maven as of 15 March 2015
MAVEN="http://apache.bytenet.in/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.tar.gz"
ACTIVEMQ="http://archive.apache.org/dist/activemq/apache-activemq/5.9.0/apache-activemq-5.9.0-bin.tar.gz"

apt-get update

cd ~/Desktop

wget "$MAVEN" -O "maven.tgz"
wget "$ACTIVEMQ" -O "activemq.tgz"

tar zxf "maven.tgz" -C "$INSTALL_PATH"
tar zxf "activemq.tgz" -C "$INSTALL_PATH"

cd "$INSTALL_PATH" && mv "apache-maven-3.2.5" "maven"
cd "$INSTALL_PATH" && mv "apache-activemq-5.9.0" "activemq"

cd "$INSTALL_PATH" && chown root:root "maven" -R
cd "$INSTALL_PATH" && chown root:root "activemq" -R

cd ~/

#Add Path in bash profile
echo "export PATH=\$PATH:$MAVEN_PATH/bin" >> ".profile"
echo "export PATH=\$PATH:$ACTIVEMQ_PATH/bin" >> ".profile"

#Add Path in zshrc file for zsh shell
echo "export PATH=\$PATH:$MAVEN_PATH/bin" >> ".zshrc"
echo "export PATH=\$PATH:$ACTIVEMQ_PATH/bin" >> ".zshrc"

# Add Android and NPM paths to the temporary user path to complete installation
export PATH=$PATH:$MAVEN_PATH/bin
export PATH=$PATH:$ACTIVEMQ_PATH/bin


sudo apt-get install memcached -y

#postgres
sudo apt-get update
sudo apt-get install postgresql postgresql-contrib -y

#tomcat
sudo apt-get install tomcat7 #http://localhost:8080 should work in case of success
sudo apt-get install tomcat7-docs tomcat7-admin tomcat7-examples #additional packages
 
echo "alias psqlre='sudo /etc/init.d/postgresql start'" >> ".zshrc"
echo "alias memcre='sudo /etc/init.d/memcached restart'" >> ".zshrc"
echo "alias activere='sudo /etc/init.d/activemq start'" >> ".zshrc"
echo "alias pcb='mvn eclipse:clean eclipse:eclipse -Dwtpversion=2.0 -DdownloadSources=true -DdownloadsJavaDocs=true'" >> ".zshrc"
