provider "libvirt" {
  uri = "qemu:///system"
}

module "cloudinit" {
  source = "./terraform/libvirt/images/cloudinit"
}

module "gentoo" {
  source = "./terraform/libvirt/images/gentoo/"
}

// we create 4 hosts 

resource "libvirt_volume" "gento_disk" {
  name           = "gento20180921-${count.index}"
  base_volume_id = "${module.gentoo.gentoo_20180921_id}"
  pool           = "default"
  count          = 1
}

resource "libvirt_domain" "gentoo20180921" {
  name      = "gentoo20180921-${count.index}"
  memory    = "1024"
  vcpu      = 1
  count     = 1
  cloudinit = "${module.cloudinit.cloudinit_id}"

  network_interface {
    network_name = "default"
  }

  disk {
    volume_id = "${element(libvirt_volume.gentoo_disk.*.id, count.index)}"
  }

  # IMPORTANT
  # Ubuntu can hang if an isa-serial is not present at boot time.
  # If you find your CPU 100% and never is available this is why
  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}
