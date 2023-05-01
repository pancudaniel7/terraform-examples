terraform {
  required_version = ">=0.12.0"
  required_providers {
    aws = ">=3.0.0"
  }
}

module "network_worker" {
  source = "./modules/network/worker"
  providers = {
    aws = aws.worker
  }

  env = var.env
}

module "network_master" {
  source = "./modules/network/master"
  providers = {
    aws = aws.worker
  }

  env           = var.env
  vpc_worker_id = module.network_worker.vpc_id
  master_region = var.region_master

  depends_on = [
    module.network_worker
  ]
}
