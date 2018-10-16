terraform {
  required_version = "~> 0.11.7"
}

resource "libvirt_volume" "gentoo_volume" {
  name   = "gentoo"
  source = "gentoo.osuosl.org/experimental/amd64/openstack/gentoo-openstack-amd64-default-latest.qcow2"
  count  = "1"
  pool   = "${var.pool}"
}
