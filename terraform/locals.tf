locals {
  prefix = "groukdev"

  common_tags = {
    Project   = "Glue Course Terraform"
    ManagedBy = "Terraform"
    Owner     = "Gabriel Gama"
  }

  glue_database_path = "data/customers_database"
  glue_table_path    = "data/customers_database/customers_csv"
}
