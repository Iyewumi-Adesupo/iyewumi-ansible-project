locals {
  name = ""
}

module "vpc" {
  source                 = "./module/vpc"
  keypair                = ""
  public_keypair_path    = ""
  AZ1                    = "us-west-2a"
  AZ2                    = "us-west-2b"
  tag-vpc                = "${local.name}-vpc"
  tag-keypair            = "${local.name}-keypair"
  tag-subnet-1           = "${local.name}-public-subnet-1"
  tag-subnet-2           = "${local.name}-public-subnet-2"
  tag-private-subnet-1   = "${local.name}-private-subnet-1"
  tag-private-subnet-2   = "${local.name}-private-subnet-2"
  tag-igw                = "${local.name}-igw"
  tag-ngw                = "${local.name}-ngw"
  tag-public_rt          = "${local.name}-public_rt"
  tag-private_rt         = "${local.name}-private_rt"
  tag-docker-sg          = "${local.name}-docker-sg"
  tag-jenkins-sg         = "${local.name}-jenkins-sg"
  tag-bastion_ansible-sg = "${local.name}-bastion_ansible-sg"
  tag-nexus-sg           = "${local.name}-nexus-sg"
  tag-sonarqube-sg       = "${local.name}-sonarqube-sg"
  tag-mysql              = "${local.name}-mysql"
}

module "bastion-host" {
  source               = "./module/bastion-host"
  ami                  = ""
  security_groups      = module.vpc.baston-sg
  instance_type        = "t2.micro"
  subnet_id            = module.vpc.public-subnet1
  key_name             = module.vpc.key-name
  tag-bastion-host     = "${local.name}-bastion-host"
  private_keypair_path = file("")
}

module "jenkins" {
  source          = "./module/jenkins"
  ami             = ""
  instance_type   = "t2.medium"
  subnet_id       = module.vpc.private-subnet1
  key_name        = module.vpc.key-name
  security_groups = module.vpc.jenkins-sg
  nexus-ip        = module.nexus.nexus-server-ip
  subnet-id       = [module.vpc.public-subnet1]
  jenkins-elb     = "${local.name}-jenkins-elb"
  tag-jenkins     = "${local.name}-jenkins"
}

module "ansible" {
  source             = "./module/ansible"
  ami                = ""
  instance_type      = "t2.micro"
  security_group_ids = module.vpc.ansible-sg
  subnet_id          = module.vpc.public-subnet1
  key_name           = module.vpc.key-name
  tag-ansible-server = "${local.name}-ansible-server"
  stage-playbook     = "${path.root}/module/ansible/stage-playbook.yml"
  prod-playbook      = "${path.root}/module/ansible/prod-playbook.yml"
  stage-bashscript  = "${path.root}/module/ansible/stage-bashscript.sh"
  prod-bashscript   = "${path.root}/module/ansible/prod-bashscript.sh"
  private-key        = file("")
  nexus-server-ip    = module.nexus.nexus-server-ip
}

module "asg" {
  source                 = "./module/asg"
  stage-lt               = "${local.name}-stage-lt"
  prod-lt                = "${local.name}-prod-lt"
  image_id               = ""
  instance_type          = "t2.medium"
  vpc_security_group_ids = module.vpc.docker-sg
  key_name               = module.vpc.key-name
  nexus-server-ip        = module.nexus.nexus-server-ip
  api_key                = ""
  account_id             = ""
  stage-asg-name         = "${local.name}-stage-asg"
  prod-asg-name          = "${local.name}-prod-asg"
  vpc-zone-identifier    = [module.vpc.private-subnet1, module.vpc.private-subnet2]
  tg_arn_stage           = [module.alb.stage-target-arn]
  tg_arn_prod            = [module.alb.prod-target-arn]
  stage-asg-policy       = "${local.name}-asg-policy"
  prod-asg-policy        = "${local.name}-asg-policy"
}

module "alb" {
  source             = "./module/alb"
  vpc_id             = module.vpc.vpc-id
  security_group_ids = [module.vpc.docker-sg]
  subnets            = [module.vpc.public-subnet1, module.vpc.public-subnet2]
  tag-stage-alb      = "${local.name}-stage-alb"
  tag-prod-alb       = "${local.name}-prod-alb"
  certificate_arn    = module.route53.certificate_arn
}

module "nexus" {
  source          = "./module/nexus"
  ami             = ""
  instance_type   = "t2.medium"
  subnet_id       = module.vpc.public-subnet2
  key_name        = module.vpc.key-name
  security_groups = module.vpc.nexus-sg
  tag-nexus       = "${local.name}-nexus"
}

module "sonarqube" {
  source               = "./module/sonarqube"
  ubuntu_ami           = ""
  instance_type        = "t2.medium"
  security_group_ids   = module.vpc.sonarqube-sg
  subnet_id            = module.vpc.public-subnet1
  key_name             = module.vpc.key-name
  tag-sonarqube-server = "${local.name}-sonarqube-server"
}

module "route53" {
  source            = "./module/route53"
  domain-name       = "domain-name.com"
  domain-name1      = "stage.domain-name.come"
  domain-name2      = "prod.domain-name.com"
  domain-name3      = "*.domain-name.com"
  stage_lb_dns_name = module.alb.stage-alb-dns
  stage_lb_zoneid   = module.alb.stage-alb-zone-id
  prod_lb_dns_name  = module.alb.prod-lb-dns
  prod_lb_zoneid    = module.alb.prod-lb-zone-id
}

module "rds" {
  source                   = "./module/rds"
  db_identifier            = "localname-db"
  security_groups          = module.vpc.rds-sg
  db-name                  = "localname_db"
  db-username              = data.vault_generic_secret.db_secret.data["username"]
  db-password              = data.vault_generic_secret.db_secret.data["password"]
  subnet_ids               = [module.vpc.private-subnet1, module.vpc.private-subnet2]
  tag-db_subnet_group_name = "${local.name}-db-subnet-group"
}
