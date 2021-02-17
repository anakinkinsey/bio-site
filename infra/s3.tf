resource "aws_s3_bucket" "site-bucket" {
  bucket = var.website_name
  acl    = "private"

  website {
    index_document = "index.html"
    error_document = "404.html"
  }

}

resource "aws_s3_bucket_policy" "bucket-policy" {
  bucket = aws_s3_bucket.site-bucket.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "PublicReadGetObject",
        "Effect" : "Allow",
        "Principal" : "*"
        "Action" : "s3:GetObject",
        "Resource" : "arn:aws:s3:::${var.website_name}/*"
      }
    ]
  })

}