#__________________________________Add_alias_subdomain_to_dns_name
resource "aws_route53_record" "dns_alb" {
  zone_id = var.public_zone_id
  name    = "${var.subdomain}.${var.public_zone_name}"
  type    = "A"
  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}


