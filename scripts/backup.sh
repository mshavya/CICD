cd /opt/docker/; echo "FROM tomcat:latest" >> /opt/docker/Dockerfile; echo "MAINTAINER Viswanatha" >> /opt/docker/Dockerfile; echo "COPY ./webapp.war /usr/local/tomcat/webapps/" >> /opt/docker/Dockerfile; docker build -t viswatest .; docker run -d --name viswatest-container -p 8080:8080 viswatest;


  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install_ansible.sh",
      "sudo /tmp/install_ansible.sh ${join(" ", aws_instance.docker.*.private_ip)}",
    ]
  }

  Security configuration, script libraries, and job parameters (optional)