provider "aws" {
  access_key = var.accesskey
  secret_key = var.seckey
  region = var.region
}

resource "aws_key_pair" "mykey" {
  key_name   = "keyfile"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

data "aws_security_group" "defaultgroup" {
  filter {
    name   = "group-name"
    values = ["*default*"]
  }
}

resource "aws_security_group_rule" "apache" {
  from_port = 8080
  protocol = "TCP"
  security_group_id = data.aws_security_group.defaultgroup.id
  to_port = 8080
  type = "ingress"
  cidr_blocks     = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ssh" {
  from_port = 22
  protocol = "TCP"
  security_group_id = data.aws_security_group.defaultgroup.id
  to_port = 22
  type = "ingress"
  cidr_blocks     = ["0.0.0.0/0"]
}

/*
resource "aws_instance" "example" {
  ami           = var.AMIS[var.region]
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykey.key_name

  provisioner "file" {
    source      = "./scripts/jenkins.sh"
    destination = "/tmp/install_jenkins.sh"

  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install_jenkins.sh",
      "sudo /tmp/install_jenkins.sh",
    ]
  }
  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }
  tags = {
    Name = "Jenkins-server"
  }

}

resource "aws_instance" "tomcat" {
  ami           = var.AMIS[var.region]
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykey.key_name

  provisioner "file" {
    source      = "./scripts/tomcat.sh"
    destination = "/tmp/install_tomcat.sh"

  }
  provisioner "file" {
    source = "./scripts/tomcat"
    destination = "/tmp/"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install_tomcat.sh",
      "sudo /tmp/install_tomcat.sh",
    ]
  }
  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }

  tags = {
    Name = "tomcat-server"
  }
}

resource "aws_instance" "docker" {
  ami           = var.AMIS[var.region]
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykey.key_name

  provisioner "file" {
    source      = "./scripts/docker.sh"
    destination = "/tmp/install_docker.sh"

  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install_docker.sh",
      "sudo /tmp/install_docker.sh",
    ]
  }
  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }

  tags = {
    Name = "Docker-server"
  }
}



resource "aws_instance" "ansible" {
  ami           = var.AMIS[var.region]
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykey.key_name


  provisioner "file" {
    source      = "./scripts/ansible.sh"
    destination = "/tmp/install_ansible.sh"
  }

  provisioner "file" {
    source = "./scripts/ansiblepaly"
    destination = "/tmp/"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install_ansible.sh",
      "sudo /tmp/install_ansible.sh",
    ]
  }
  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }

  tags = {
    Name = "Ansible-server"
  }
}*/


data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "instance" {
  name               = "instance_role"
  path               = "/system/"
  assume_role_policy = data.aws_iam_policy_document.instance-assume-role-policy.json
}

resource "aws_iam_role_policy_attachment" "attachingpolicy" {
  role       = aws_iam_role.instance.name
  count      = length(var.iam_policy_arn)
  policy_arn = var.iam_policy_arn[count.index]
}

resource "aws_iam_instance_profile" "test_profile" {
  name  = "test_profile"
  role = aws_iam_role.instance.name
}

resource "aws_instance" "kube" {
  ami           = var.ubuntuami
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykey.key_name
  iam_instance_profile = aws_iam_instance_profile.test_profile.name

  provisioner "file" {
    source      = "./scripts/kubesetup.sh"
    destination = "/tmp/install_kubesetup.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install_kubesetup.sh",
      "sudo /tmp/install_kubesetup.sh",
    ]
  }

  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.ubuntu_username
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }

  tags = {
    Name = "kube-server"
  }
}

/*
resource "aws_route53_zone" "private" {
  name = "coviam.net"
  vpc {
    vpc_id = var.vpc-id
  }
}


resource "aws_s3_bucket" "s3bucket" {
  bucket = var.s3bucket_name

  tags = {
    Name        = var.s3bucket_name
    Environment = "Testing"
  }
}*/


