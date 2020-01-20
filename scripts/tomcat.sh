cd /opt
sudo wget http://mirrors.estointernet.in/apache/tomcat/tomcat-8/v8.5.50/bin/apache-tomcat-8.5.50.tar.gz
sudo tar -xvzf /opt/apache-tomcat-8.5.50.tar.gz
sudo chmod +x /opt/apache-tomcat-8.5.50/bin/startup.sh
sudo chmod +x /opt/apache-tomcat-8.5.50/bin/shutdown.sh
sudo ln -s /opt/apache-tomcat-8.5.50/bin/startup.sh /usr/local/bin/tomcatup
sudo ln -s /opt/apache-tomcat-8.5.50/bin/shutdown.sh /usr/local/bin/tomcatdown
cd /opt/apache-tomcat-8.5.50/conf

sudo cp /opt/apache-tomcat-8.5.50/webapps/host-manager/META-INF/context.xml /opt/apache-tomcat-8.5.50//webapps/host-manager/META-INF/context.xml.bkp
sudo cp /opt/apache-tomcat-8.5.50/webapps/manager/META-INF/context.xml /opt/apache-tomcat-8.5.50/webapps/manager/META-INF/context.xml.bkp
sudo cp /opt/apache-tomcat-8.5.50/conf/tomcat-users.xml /opt/apache-tomcat-8.5.50/conf/tomcat-users.xml.bkp

echo "java installing"
sudo yum -y install java-1.8*
sudo java -version
sudo echo "JAVA_HOME=/usr/lib/jvm/java-1.8.0" >> /root/.bash_profile
sudo echo "export JAVA_HOME" >> /root/.bash_profile
sudo echo "PATH=$PATH:$HOME/bin:$JAVA_HOME" >> /root/.bash_profile
sudo source /root/.bash_profile
cd /tmp/
sudo unzip tomcat.zip
ll /tmp/tomcat/
cd /tmp/tomcat/
sudo cp /tmp/tomcat/host-context.xml /opt/apache-tomcat-8.5.50/webapps/host-manager/META-INF/context.xml
sudo cp /tmp/tomcat/manager-context.xml /opt/apache-tomcat-8.5.50/webapps/manager/META-INF/context.xml
sudo cp /tmp/tomcat/tomcat-users.xml /opt/apache-tomcat-8.5.50/conf/tomcat-users.xml
sudo /opt/apache-tomcat-8.5.50/bin/shutdown.sh
sudo /opt/apache-tomcat-8.5.50/bin/startup.sh
sleep 5s
sudo curl http://localhost:8080
