resource "aws_s3_bucket" "ecf_s3" {
    bucket = "ecfete2025valentinwagon"
    tags = {
      Name = "ecfete2025valentinwagon"
      Description = "Stockage du state"
    }
}

resource "aws_s3_bucket_versioning" "ecf_versioning" {
  bucket = aws_s3_bucket.ecf_s3.id
  versioning_configuration {
    status = "Enabled"
  }
}