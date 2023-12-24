resource "aws_key_pair" "instances_global_keys" {
  for_each   = toset(var.regions)
  key_name   = "example_2_terraform_keypair_${each.value}"
  public_key = file("${path.module}/example_2_terraform_keypair.pub")
}

module "network_worker" {
  source = "./modules/network/vpc/worker"
  providers = {
    aws = aws.worker
  }

  security_group_standard1_name = "standard1"
  security_group_standard1_vpc_id = module.network_worker.vpc_id
  env = var.env
}

module "network_master" {
  source = "./modules/network/vpc/master"
  providers = {
    aws = aws.master
  }

  env           = var.env
  worker_region = var.region_worker

  vpc_worker_id      = module.network_worker.vpc_id
  igw_worker_id      = module.network_worker.igw_id
  subnet_1_worker_id = module.network_worker.subnet_worker1_id
  security_group_standard1_name = "standard1"
  security_group_standard1_vpc_id = module.network_master.vpc_id

  depends_on = [
    module.network_worker
  ]
}

#module "master_instances" {
#  source      = "./modules/ec2/standard"
#  providers = {
#    aws.master = aws.master
#  }
#
#  for_each = toset(var.master_instances_names)
#  instance_name = each.value
#
#  ami_id      = "ami-09042b2f6d07d164a"
#  key_name    = aws_key_pair.instances_global_keys[var.region_master].key_name
#
#  subnet_id = module.network_master.subnet_master1_id
#  security_group_ids = [module.network_master.security_group_id]
#
#  depends_on = [
#    module.network_master
#  ]
#}

#module "worker_instances" {
#  source      = "./modules/ec2/standard"
#  providers = {
#    aws.worker = aws.worker
#  }
#
#  for_each = toset(var.worker_instances_names)
#  instance_name = each.value
#
#  ami_id      = "ami-09042b2f6d07d164a"
#  key_name    = aws_key_pair.instances_global_keys[var.region_worker].key_name
#
#  subnet_id = module.network_worker.subnet_worker1_id
#  security_group_ids = [module.network_worker.security_group_id]
#
#  depends_on = [
#    module.network_worker
#  ]
#}

