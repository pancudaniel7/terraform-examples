module "network_worker" {
  source = "./modules/network/worker"
  providers = {
    aws.worker = aws.region_worker
  }
  env = var.env
}

module "network_master" {
  source = "./modules/network/master"
  providers = {
    aws.master = aws.region_master
    aws.worker = aws.region_worker
  }

  env           = var.env
  master_region = var.region_master
  worker_region = var.region_worker

  vpc_worker_id      = module.network_worker.vpc_id
  igw_worker_id      = module.network_worker.igw_id
  subnet_1_worker_id = module.network_worker.subnet_1_id

  depends_on = [
    module.network_worker
  ]
}
