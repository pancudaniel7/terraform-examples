terraform {
  required_version = ">=0.12.0"
  required_providers {
    aws = ">=3.0.0"
  }
}

provider "aws" {
  profile = "zeph"
  region  = var.region_master
  alias   = "master"
}

provider "aws" {
  profile = "zeph"
  region  = var.region_worker
  alias   = "worker"
}
