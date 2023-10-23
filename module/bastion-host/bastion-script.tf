locals {
 bastion-host_user_data = <<-EOF
#!/bin/bash
echo "${var.private_keypair_path}" >> /home/ec2-user/adesupokey1
chmod 400 /home/ec2-user/adesupokey
chown ec2-user:ec2-user /home/ec2-user/adesupokey
sudo hostnamectl set-hostname Bastion
EOF
}
