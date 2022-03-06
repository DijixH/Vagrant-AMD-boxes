packer {
  required_plugins {
    vmware = {
      version = ">= 1.0.5"
      source  = "github.com/hashicorp/vmware"
    }
  }
}

source "vmware-iso" "debian-bullseye" {
  iso_url = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.2.0-amd64-netinst.iso"
  iso_checksum = "sha256:45c9feabba213bdc6d72e7469de71ea5aeff73faea6bfb109ab5bad37c3b43bd"
  ssh_username = "vagrant"
  ssh_password = "vagrant"
  ssh_timeout = "30m"
  shutdown_command = "sudo shutdown -h now"
  guest_os_type = "debian11-64"
  disk_adapter_type = "nvme"
  version = 19
  http_directory = "http"
  boot_command = [
    "<esc><wait>",
    "install <wait>",
    " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg <wait>",
    "debian-installer=fr_FR.UTF-8 <wait>",
    "auto <wait>",
    "locale=fr_FR.UTF-8 <wait>",
    "kbd-chooser/method=fr <wait>",
    "keyboard-configuration/xkb-keymap=fr <wait>",
    "netcfg/get_hostname={{ .Name }} <wait>",
    "netcfg/get_domain= <wait>",
    "fb=false <wait>",
    "debconf/frontend=noninteractive <wait>",
    "console-setup/ask_detect=false <wait>",
    "console-keymaps-at/keymap=fr <wait>",
    "grub-installer/bootdev=/dev/nvme0n1 <wait>",
    "<enter><wait>"
  ]
  usb = true
  vmx_data = {
    "usb_xhci.present" = "true"
  }
  memory = 2048
  cpus = 2
  disk_size = 40000
  vm_name = "Debian 11"
  output_directory = "output"
}

build {
  sources = ["sources.vmware-iso.debian-bullseye"]

  provisioner "shell" {
    scripts = [
      "add-key.sh",
      "vmware-cleanup.sh"
    ]
  }
}