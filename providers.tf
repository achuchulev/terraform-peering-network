provider "aws" {
  region = var.region_a

  # Region A credentials
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  token      = var.aws_token
}

provider "aws" {
  alias  = "west"
  region = var.region_b

  # Region B credentials
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  token      = var.aws_token
}
