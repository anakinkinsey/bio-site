resource "aws_cloudfront_distribution" "s3_distribution" {
  aliases = [var.website_name]
  origin {
    domain_name = "${aws_s3_bucket.site-bucket.bucket}.s3.amazonaws.com"
    origin_id   = "S3-${var.website_name}"
  }
  enabled             = true
  is_ipv6_enabled     = true
  comment             = var.website_name
  default_root_object = "index.html"

  default_cache_behavior {
    target_origin_id       = "S3-${var.website_name}"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    cache_policy_id        = data.aws_cloudfront_cache_policy.default-policy.id
    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.acm_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2019"
  }
}

data "aws_cloudfront_cache_policy" "default-policy" {
  name = "Managed-CachingOptimized"
}