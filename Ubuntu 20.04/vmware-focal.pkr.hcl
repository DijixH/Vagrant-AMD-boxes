packer {
  required_plugins {
    vmware = {
      version = ">= 1.0.5"
      source  = "github.com/hashicorp/vmware"
    }
  }
}

source "vmware-iso" "ubuntu-focal" {
  #iso_url = "https://cdimage.ubuntu.com/releases/20.04/release/ubuntu-20.04.3-live-server-arm64.iso"
  iso_url           = "iso/ubuntu-20.04.4-live-server-amd64.iso"
  iso_checksum      = "sha256:28ccdb56450e643bad03bb7bcf7507ce3d8d90e8bf09e38f6bd9ac298a98eaad"
  ssh_username      = "vagrant"
  ssh_password      = "vagrant"
  ssh_timeout       = "30m"
  shutdown_command  = "sudo shutdown -h now"
  guest_os_type     = "ubuntu-64"
  disk_adapter_type = "nvme"
  version           = 19
  http_directory    = "http"
  boot_wait         = "5s"
  boot_command = [
    "<enter><enter><f6><esc><wait> ",
    "autoinstall ds=nocloud-net;seedfrom=http://{{ .HTTPIP }}:{{ .HTTPPort }}/",
    "<enter><wait>"
  ]
  usb              = true
  memory           = 2048
  cpus             = 2
  disk_size        = 20000
  vm_name          = "Ubuntu Server 20.04"
  output_directory = "output"
}

build {
  sources = ["sources.vmware-iso.ubuntu-focal"]

  provisioner "shell" {
    scripts = [
      "add-key.sh",
      "vmware-cleanup.sh"
    ]
  }
}