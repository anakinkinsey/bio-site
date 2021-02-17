data "aws_route53_zone" "primary" {
  name = var.website_name
}

resource "aws_route53_record" "alias" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = var.website_name
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}