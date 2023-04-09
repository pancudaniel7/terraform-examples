terraform {
  required_version = ">=0.12.0"
  required_providers {
    aws = ">=3.0.0"
  }
}

module "network_master" {
  source = "./modules/network/master"
  providers = {
    aws = aws.master
  }
}

module "network_worker" {
  source = "./modules/network/worker"
  providers = {
    aws = aws.worker
  }
}
