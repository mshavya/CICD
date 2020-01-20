sudo yum install docker -y
docker --version
sudo service docker start
sudo service docker status
sudo useradd dockeradmin
echo -e "dockeradmin\ndockeradmin\n" | sudo passwd dockeradmin
sudo usermod -aG docker dockeradmin
#sudo docker run -d --name test-tomcat-server -p 8080:8080 tomcat:latest
sudo id dockeradmin
sudo sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sudo service sshd reload
echo "below commands as to run after jenkins build and configure push over ssh"
#cd /home/dockeradmin/
#echo "FROM tomcat:latest" >> /home/dockeradmin/Dockerfile
#echo "MAINTAINER Viswanatha" >> /home/dockeradmin/Dockerfile
#echo "COPY ./webapp.war /usr/local/tomcat/webapps/" >> /home/dockeradmin/Dockerfile
#cd /home/dockeradmin/
sudo useradd ansadmin
echo -e "ansadmin\nansadmin\n" | sudo passwd ansadmin
sudo usermod -aG docker ansadmin
sudo echo "ansadmin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

echo "this "
#docker build -t viswatest .