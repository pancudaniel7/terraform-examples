terraform {
  required_version = ">=0.12.0"
  required_providers {
    aws = ">=3.0.0"
  }
}

provider "aws" {
  profile = "default"
  region  = var.region_master
  alias   = "region_master"
}

provider "aws" {
  profile = "default"
  region  = var.region_worker
  alias   = "region_worker"
}
