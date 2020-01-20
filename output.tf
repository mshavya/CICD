output "kubepublicip" {
  value = aws_instance.kube.public_ip
}
output "defaulf" {
  value = aws_instance.kube.id
}

/*

output "publicipofdocker" {
  value = aws_instance.docker.public_ip
}

output "previateip" {
  value = aws_instance.docker.private_ip
}

output "publicipoftomcat" {
  value = aws_instance.tomcat.public_ip
}

output "publicipofjenkins" {
  value = aws_instance.example.public_ip
}

output "publicipofansiable" {
  value = aws_instance.ansible.public_ip
}

output "vpc_id" {
  value = "${data.aws_vpcs.test.ids}"
}

*/
