resource "aws_s3_bucket" "ecf_s3" {
    bucket = "ecfete2025valentinwagon"
    tags = {
      Name        = "ecfete2025valentinwagon"
      Description = "Bucket frontend"
    }
}

resource "aws_s3_bucket_versioning" "ecf_versioning" {
  bucket = aws_s3_bucket.ecf_s3.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_public_access" {
  bucket = aws_s3_bucket.ecf_s3.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "bucket_ownership" {
  bucket     = aws_s3_bucket.ecf_s3.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "ecf_s3_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.bucket_ownership,
    aws_s3_bucket_public_access_block.bucket_public_access
  ]
  bucket = aws_s3_bucket.ecf_s3.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "public_read" {
  depends_on = [aws_s3_bucket_public_access_block.bucket_public_access]
  bucket     = aws_s3_bucket.ecf_s3.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.ecf_s3.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "ecf_s3_website" {
  bucket = aws_s3_bucket.ecf_s3.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}
