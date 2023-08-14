output "bucket_name" {
  value = aws_s3_bucket.main.bucket
}

output "bucket_arn" {
  value       = aws_s3_bucket.main.arn
  description = ""
}

output "bucket_domain_name" {
  value = aws_s3_bucket.main.bucket_domain_name
}

output "bucket_full_path" {
  value = "https://${aws_s3_bucket.main.bucket}.s3.amazonaws.com/${local.glue_database_path}/"
}