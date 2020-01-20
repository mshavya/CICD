#!/bin/bash
echo "Hello world"
sudo echo "java installing"
sudo yum -y update
sudo yum -y install java-1.8*
sudo java -version

sudo echo "JAVA_HOME=/usr/lib/jvm/java-1.8.0" >> /root/.bash_profile
sudo echo "export JAVA_HOME" >> /root/.bash_profile
sudo echo "PATH=$PATH:$HOME/bin:$JAVA_HOME" >> /root/.bash_profile

sudo echo "jenkins installing"
sudo yum -y install wget
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum -y install jenkins
sudo service jenkins start
sudo chkconfig jenkins on
#curl http://localhost:8080
#sudo cat /var/lib/jenkins/secrets/initialAdminPassword
#sudo ln -s /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.222.b10-0.amzn2.0.1.x86_64/jre jdk8
#sudo echo "JAVA_HOME=/usr/lib/jvm/jdk8" >> /root/.bash_profile
#sudo echo "export JAVA_HOME" >> /root/.bash_profile
#sudo echo "PATH=$PATH:$HOME/bin:$JAVA_HOME" >> /root/.bash_profile

echo "git installing"
sudo yum -y install git

echo "Installing Maven"

sudo mkdir /opt/maven
cd /opt/maven
sudo wget http://mirrors.estointernet.in/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
sudo tar -xvzf apache-maven-3.6.3-bin.tar.gz
sudo echo "M2_HOME=/opt/maven/apache-maven-3.6.3" >> /root/.bash_profile
sudo echo "M2=$M2_HOME/bin" >> /root/.bash_profile
sudo echo "PATH=$PATH:$M2_HOME:$M2" >> /root/.bash_profile