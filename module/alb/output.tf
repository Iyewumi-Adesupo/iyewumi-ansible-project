output "stage-target-arn" {
  value = aws_lb_target_group.target-group.arn
}

output "stage-alb-dns" {
  value = aws_lb.stage-alb.dns_name
}

output "stage_lb_arn" {
  value = aws_lb.stage-alb.arn
}

output "stage-alb-zone-id" {
  value = aws_lb.stage-alb.zone_id
}

output "prod-target-arn" {
  value = aws_lb_target_group.target-group2.arn
}

output "prod-lb-dns" {
  value = aws_lb.alb-prod.dns_name
}

output "prod_lb_arn" {
  value = aws_lb.alb-prod.arn
}

output "prod-lb-zone-id" {
  value = aws_lb.alb-prod.zone_id
}