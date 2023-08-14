resource "aws_s3_bucket" "example" {
  bucket = "${local.prefix}-glue-full-course"

  tags = merge(
    local.common_tags,
    {
      Name = "Glue Full Course Bucket"
      Env  = "Dev"
    }
  )
}