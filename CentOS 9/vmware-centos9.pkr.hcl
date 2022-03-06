packer {
  required_plugins {
    vmware = {
      version = ">= 1.0.5"
      source  = "github.com/hashicorp/vmware"
    }
  }
}

source "vmware-iso" "centos-9" {
  iso_url           = "http://mirror.stream.centos.org/9-stream/BaseOS/x86_64/iso/CentOS-Stream-9-latest-x86_64-dvd1.iso"
  iso_checksum      = "md5:fe4e43757b286b1c5659597df4ec19b2"
  ssh_username      = "vagrant"
  ssh_password      = "vagrant"
  ssh_timeout       = "30m"
  shutdown_command  = "sudo shutdown -h now"
  guest_os_type     = "centos8-64"
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
    #"ethernet0.virtualDev" = "vmxnet3"
  }
  memory           = 2048
  cpus             = 2
  disk_size        = 20000
  vm_name          = "Centos 9 Stream"
  output_directory = "output"
}

build {
  sources = ["sources.vmware-iso.centos-9"]

  provisioner "shell" {
    scripts = [
      "add-key.sh",
      "vmware-cleanup.sh"
    ]
  }
}