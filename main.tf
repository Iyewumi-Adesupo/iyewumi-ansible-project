#create sonarqube server
resource "aws_instance" "sonarqube_server" {
  ami                         = var.ubuntu_ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_ids]
  associate_public_ip_address = true
  user_data                   = local.sonarqube_user_data
  tags = {
    Name = var.tag-sonarqube-server
  }
}