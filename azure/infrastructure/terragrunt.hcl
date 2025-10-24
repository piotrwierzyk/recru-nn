include "root" {
  path   = "../terragrunt.hcl"
  expose = true
}

terraform {
  source = "."
}

inputs = {
  address_space = "10.1.0.0/16"
}

