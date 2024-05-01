# create an s3 bucket 
resource "aws_s3_bucket" "website_file" {
  bucket =  "${var.project_name}-${var.web_file_bucket_name}"
}

# upload the environment file from local computer into the s3 bucket
resource "aws_s3_object" "web_file_upload" {
  bucket = aws_s3_bucket.website_file.id 
  key    = var.website_file
  source = "./${var.website_file}"

}

# S3 bucket CORS configuration resource
resource "aws_s3_bucket_cors_configuration" "s3_cors" {
  bucket = aws_s3_bucket.website_file.id 

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST", "DELETE", "HEAD"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 0
  }

}

output "s3_website_endpoint" {
  value = aws_s3_bucket.website_file.website_endpoint
}


