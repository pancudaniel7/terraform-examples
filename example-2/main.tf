resource "aws_key_pair" "instances_global_keys" {
  for_each   = toset(var.regions)
  key_name   = "example_2_terraform_keypair_${each.value}"
  public_key = file("${path.module}/example_2_terraform_keypair.pub")
}

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
  subnet_1_worker_id = module.network_worker.subnet_worker1_id

  depends_on = [
    module.network_worker
  ]
}

module "master_security_groups" {
  source = "./modules/security_groups"
  providers = {
    aws.master = aws.region_master
  }

  security_group_standard1_vpc_id = module.network_master.vpc_id

  depends_on = [
    module.network_master
  ]
}

module "worker_security_groups" {
  source = "./modules/security_groups"
  providers = {
    aws.worker = aws.region_worker
  }

  security_group_standard1_vpc_id = module.network_worker.vpc_id

  depends_on = [
    module.master_security_groups
  ]
}

module "master_instances" {
  source      = "./modules/ec2/standard"
  providers = {
    aws.master = aws.region_master
  }

  for_each = toset(var.master_instances_names)
  instance_name = each.value

  ami_id      = "ami-09042b2f6d07d164a"
  key_name    = aws_key_pair.instances_global_keys[var.region_master].key_name

  subnet_id = module.network_master.subnet_master1_id
  security_group_ids = [module.master_security_groups.standard1_id]

  depends_on = [
    module.master_security_groups
  ]
}

module "worker_instances" {
  source      = "./modules/ec2/standard"
  providers = {
    aws.worker = aws.region_worker
  }

  for_each = toset(var.worker_instances_names)
  instance_name = each.value

  ami_id      = "ami-09042b2f6d07d164a"
  key_name    = aws_key_pair.instances_global_keys[var.region_worker].key_name

  subnet_id = module.network_worker.subnet_worker1_id
  security_group_ids = [module.worker_security_groups.standard1_id]

  depends_on = [
    module.worker_security_groups
  ]
}

