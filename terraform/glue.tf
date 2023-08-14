resource "aws_glue_catalog_database" "database" {
  name         = "${local.prefix}_glue_database"
  location_uri = "https://${aws_s3_bucket.main.bucket}.s3.amazonaws.com/${local.glue_database_path}/"
  description  = "This is a database of customer information"

  tags = merge(
    local.common_tags,
    {
      Name = "Glue Full Course Catalog Database"
      Env  = "Dev"
    }
  )
}

resource "aws_glue_classifier" "classifier" {
  name = "${local.prefix}_csv_classifier"

  csv_classifier {
    allow_single_column    = false
    contains_header        = "PRESENT"
    delimiter              = ","
    disable_value_trimming = false
    header                 = ["CustomerID", "NameStyle", "Title", "FirstName", "MiddleName", "LastName", "Suffix", "CompanyName", "SalesPerson", "EmailAddress", "Phone", "PasswordHash", "PasswordSalt", "rowguid", "ModifiedDate"]
    quote_symbol           = "'"
  }
}

resource "aws_glue_crawler" "glue_crawler" {
  database_name = aws_glue_catalog_database.database.name
  name          = "${local.prefix}_crawler_customer"
  description   = ""
  role          = "glue-course-full-access-delete-late"
  classifiers   = [aws_glue_classifier.classifier.name]


  s3_target {
    path = "s3://${aws_s3_bucket.main.bucket}/${local.glue_table_path}"
  }

  tags = merge(
    local.common_tags,
    {
      Name = "Glue Full Course Crawler"
      Env  = "Dev"
    }
  )
}
