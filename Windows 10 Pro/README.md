# Packer for make Vagrant Box of Windows 10

This packer file can make a vagrant box of Windows 10 Pro 21H2 FR for VMware and VirtualBox.

In this box you have :

- The shared folder
- OpenSSH Server & Client (You can't connect to the VM with SSH, the Vagrant public key isn't implement in box (in future release))
- Remote Desktop are activate 

# How to use with Packer

In default parameters, the packer file ('win10.json') download Windows 10 21H2 FR on Microsoft server, but if you want to use an other version of Windows 10 or an iso you have in local you can, just modify **variables iso_url** and **iso_checksum**.

## Checksum

To calculate the MD5 checksum of you're iso file if you doesn't have it, you can make :
- On Windows : With Powershell : ``Get-FileHash .\win10_21H2_French_x64.iso -Algorithm MD5 | Format-List``
- On MacOS : In Terminal : ``md5 win10_21H2_French_x64.iso``

## Language

You can change languages in response file **autounattend.xml** for VMware, for VirtualBox you have to modify the **autounattend.xml** in **autounattend.iso**.

## Building

To building boxes you have two options

### Build boxes for all providers

If you want to build box for VMware and VirtualBox you just have to run :
``packer build win10.json``

### Build box for a specific providers

If you just want to build a box for VMware or VirtualBox you have to add the key ``-only=``. 
For VMware : ``packer build -only=vmware-iso win10.json``
For VirtualBox : ``packer build -only=virtualbox-iso win10.json``

# How to use the box

You can use you're own builded boxes or you can use mine on the [Vagrant Cloud](https://app.vagrantup.com/thtom/boxes/Windows-10-Pro-21H2-FR)

To use the box you can copy the vagrantfile.template to use it to launch you're Vagrant Windows 10 Box.

After you make ``vagrant up``command, Vagrant will map ports to allow you to connect with the VM with WinRM and RDP.
When deployment are finished, you can tap ``vagrant rdp``to launch you're favorite remote desktop client and connect to the VM, the password is **vagrant**.

On Mac you can download the  Microsoft Remote Desktop App on [Mac AppStore](https://apps.apple.com/fr/app/microsoft-remote-desktop/id1295203466?mt=12)