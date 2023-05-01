provider "aws" {
  profile = "default"
  region  = var.region_master
  alias   = "master"
}

provider "aws" {
  profile = "default"
  region  = var.region_worker
  alias   = "worker"
}
