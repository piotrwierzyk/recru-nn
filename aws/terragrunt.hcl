locals {
  aws_region      = "eu-central-1"
  name_prefix     = "pw"
  state_bucket    = "pw-terraform-state-netnut"
}

generate "provider_aws" {
  path      = "provider_aws.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "aws" {
  region = "${local.aws_region}"

  default_tags {
    tags = {
      Project   = "pw-netnut"
      ManagedBy = "terraform"
    }
  }
}
EOF
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "s3" {
    bucket = "${local.state_bucket}"
    key    = "aws/${path_relative_to_include()}/terraform.tfstate"
    region = "${local.aws_region}"
  }
}
EOF
}

inputs = {
  aws_region  = local.aws_region
  name_prefix = local.name_prefix
}

