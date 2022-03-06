packer {
  required_plugins {
    vmware = {
      version = ">= 1.0.5"
      source  = "github.com/hashicorp/vmware"
    }
  }
}

source "vmware-iso" "centos-7" {
  iso_url = "http://ftp.pasteur.fr/mirrors/CentOS/7.9.2009/isos/x86_64/CentOS-7-x86_64-DVD-2009.iso"
  iso_checksum = "sha256:e33d7b1ea7a9e2f38c8f693215dd85254c3a4fe446f93f563279715b68d07987"
  ssh_username      = "vagrant"
  ssh_password      = "vagrant"
  ssh_timeout       = "30m"
  shutdown_command  = "sudo shutdown -h now"
  guest_os_type     = "centos7-64"
  disk_adapter_type = "nvme"
  version           = 19
  http_directory    = "http"
  boot_command = [
    "<tab>",
    "linux /images/pxeboot/vmlinuz inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/kickstart.cfg",
    "<enter>",
    "initrd /images/pxeboot/initrd.img",
    "<enter>",
    "boot",
    "<enter><wait>"
  ]
  usb = true
  vmx_data = {
    "usb_xhci.present"     = "true",
  }
  memory           = 2048
  cpus             = 2
  disk_size        = 20000
  vm_name          = "Centos 7"
  output_directory = "output"
}

build {
  sources = ["sources.vmware-iso.centos-7"]

  provisioner "shell" {
    scripts = [
      "add-key.sh",
      "vmware-cleanup.sh"
    ]
  }
}