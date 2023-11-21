variable "aws_region" {
  default = "us-west-2"
}
variable "profile" {
  default = "aws-credentials-name"
}

variable "public_keypair_path" {
  default = "pub-keypair"
}
variable "ubuntu_ami" {
  default = ""
}
variable "instance_type" {
  default = "t3.medium"
}
variable "domain_name" {
  default = ""
}
variable "email" {
  default = ""
}
variable "api_key" {
  default = ""
}
variable "account_id" {
  default = ""
}
