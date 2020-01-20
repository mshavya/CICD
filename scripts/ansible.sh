#paip=$1
sudo yum update -y
sudo yum install python python-pip -y
sudo pip install ansible
ansible --version
sudo useradd ansadmin
echo -e "ansadmin\nansadmin\n" | sudo passwd ansadmin
sudo echo "ansadmin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
sudo yum install docker -y
sudo service docker start
sudo service docker status
sudo usermod -aG docker ansadmin
sudo sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sudo service sshd reload
sudo  mkdir /etc/ansible/
#sudo echo $paip >> /etc/ansible/hosts
sudo echo "localhost" >> /etc/ansible/hosts
sudo mkdir /opt/docker /opt/kubernetes
sudo cp /tmp/ansiblepaly/* /opt/docker/
sudo cp /tmp/ansiblepaly/kube/* /opt/kubernetes/
echo "FROM tomcat:latest" >> /opt/docker/Dockerfile
echo "MAINTAINER Viswanatha" >> /opt/docker/Dockerfile
echo "COPY ./webapp.war /usr/local/tomcat/webapps/" >> /opt/docker/Dockerfile
sudo cp /opt/docker/Dockerfile /opt/kubernetes/
sudo -u ansadmin ssh-keygen -q -t rsa -f /home/ansadmin/.ssh/id_rsa -C "" -N ""
sudo apt-get update
sudo apt-get install python-pip -y
sudo pip install docker-py
sudo chown ansadmin:ansadmin -R /opt/docker /opt/kubernetes
