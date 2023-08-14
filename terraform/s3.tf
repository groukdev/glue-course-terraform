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


# List of folders to be created
variable "s3_folders" {
  type        = list(string)
  description = "The list of S3 folders to create"
  default = [
    "temp-dir",
    "scripts",
    "athena_results"
  ]
}

# Create the folders inside the main bucket
resource "aws_s3_object" "directory_structure" {
  for_each = toset(var.s3_folders)

  bucket       = aws_s3_bucket.main.bucket
  key          = "${each.value}/"
  content_type = "application/x-directory"
}

resource "aws_s3_object" "object" {
  bucket       = aws_s3_bucket.main.bucket
  key          = "${local.glue_table_path}/20211230/customer.csv"
  source       = "../data/customer.csv"
  etag         = filemd5("../data/customer.csv")
  content_type = "application/csv"
}