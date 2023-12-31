# creating LB Target group
resource "aws_lb_target_group" "target-group" {
  name     = "stage-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 5
  }
}

#creating stage application load balancer
resource "aws_lb" "stage-alb" {
  name               = "stage-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = var.subnets
  enable_deletion_protection = false
  tags = {
    Name = var.tag-stage-alb
  }
}

#Creating Load balancer listener for HTTP
resource "aws_lb_listener" "stage-http" {
  load_balancer_arn = aws_lb.stage-alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group.arn
  }
}

#Creating prod Load balancer listener for HTTPs
resource "aws_lb_listener" "https-stage" {
  load_balancer_arn = aws_lb.stage-alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group.arn
  }
}

# creating LB Target group
resource "aws_lb_target_group" "target-group2" {
  name     = "prod-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 5
  }
}

# creating prod application load balancer
resource "aws_lb" "alb-prod" {
  name               = "alb-prod"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = var.subnets
  enable_deletion_protection = false
  tags = {
    Name = var.tag-prod-alb
  }
}

#Creating Load balancer listener for HTTP
resource "aws_lb_listener" "prod-http" {
  load_balancer_arn = aws_lb.alb-prod.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group2.arn
  }
}

#Creating prod Load balancer listener for HTTPs
resource "aws_lb_listener" "https-prod" {
  load_balancer_arn = aws_lb.alb-prod.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group2.arn
  }
}

