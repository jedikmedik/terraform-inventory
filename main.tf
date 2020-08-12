# Configure pg backend
# terraform {
#   backend "pg" {
#     conn_str = "postgres://terraform_state:Tumble7Loss-Hawaii@<bastion_host_floatingip_address>/terraform_state?sslmode=disable"
#   }
# }

# Configure the OpenStack Provider
provider "openstack" {
  domain_name = var.domain_name
  tenant_name = var.project_name
  user_name   = var.user_name
  password    = var.user_password
  auth_url    = "https://api.selvpc.ru/identity/v3"
  region      = var.region
  use_octavia = true
}

# Flavor
data "openstack_compute_flavor_v2" "flavor_1" {
  name = "slurm-1cpu-1g-0hdd"
}

data "openstack_compute_flavor_v2" "flavor_2" {
  name = "slurm-4cpu-1g-0hdd"
}

data "openstack_compute_flavor_v2" "flavor_3" {
  name = "slurm-4cpu-4g-0hdd"
}

# SSH-key
resource "openstack_compute_keypair_v2" "terraform_key" {
  name       = "terraform_key-${var.user_name}"
  region     = var.region
  public_key = var.public_key
}

# Get image ID
data "openstack_images_image_v2" "centos_8" {
  name = "CentOS 8 64-bit"
  most_recent = true
  visibility = "public"
}
