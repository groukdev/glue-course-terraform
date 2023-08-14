# Create main bucket with some tags
resource "aws_s3_bucket" "main" {
  bucket = "${local.prefix}-glue-full-course"

  tags = merge(
    local.common_tags,
    {
      Name = "Glue Full Course Bucket"
      Env  = "Dev"
    }
  )
}

# Create a folder path variable to be created
variable "s3_folders" {
  type        = list(string)
  description = "The list of S3 folders to create"
  default = [
    "data/customers_database/customers_csv/20211230",
    "temp-dir",
    "scripts"
  ]
}

# Create the folders inside the main bucket
resource "aws_s3_object" "directory_structure" {
  for_each = toset(var.s3_folders)

  bucket       = aws_s3_bucket.main.bucket
  key          = "${each.value}/"
  content_type = "application/x-directory"
}
