tar xvzf /home/sourabh/Downloads/apache-maven*.tar.gz -C /tmp/
sudo su
chown -R root:root /tmp/apache-maven*
mv /tmp/apache-maven* /opt/

sudo apt-get install memcached