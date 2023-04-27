provider "aws" {
  profile = var.profile
  region  = var.region_master
  alias   = "master"
}

provider "aws" {
  profile = var.profile
  region  = var.region_worker
  alias   = "worker"
}
