variable "accesskey" {
}

variable "seckey" {
}

variable "key_name" {
  default = "keyfile"
}

variable "region" {
  default = "us-east-1"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-00068cd7555f543d5"
    us-west-2 = "ami-06b94666"
    eu-west-1 = "ami-844e0bf7"
  }
}
variable "ubuntuami" {
  default = "ami-04b9e92b5572fa0d1"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "keyfile.pub"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "keyfile"
}

variable "INSTANCE_USERNAME" {
  default = "ec2-user"
}
variable "ubuntu_username" {
  default = "ubuntu"
}

variable "iam_policy_arn" {
  description = "IAM Policy to be attached to role"
  type = "list"
}

variable "vpc-id" {}
variable "s3bucket_name" {}