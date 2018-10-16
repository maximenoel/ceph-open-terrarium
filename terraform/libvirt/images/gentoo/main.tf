terraform {
  required_version = "~> 0.11.7"
}

resource "libvirt_volume" "gentoo_20180921_volume" {
  name   = "gentoo_20180921"
  source = "gentoo.osuosl.org/experimental/amd64/openstack/gentoo-openstack-amd64-systemd-20180921.qcow2"
  count  = "1"
  pool   = "${var.pool}"
}

