include "root" {
  path   = "../terragrunt.hcl"
  expose = true
}

terraform {
  source = "."
}

inputs = {
  cidr_block = "10.0.0.0/16"
  az_count   = 2
}

