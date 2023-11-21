locals {
 bastion-host_user_data = <<-EOF
#!/bin/bash
echo "${var.private_keypair_path}" >> /home/ec2-user/privatekeypairname1
chmod 400 /home/ec2-user/privatekeypairname
chown ec2-user:ec2-user /home/ec2-user/privatekeypairname
sudo hostnamectl set-hostname Bastion
EOF
}
