  File: [1m./booting/grub.md[0m
  [38;2;255;255;255m---[0m
  [38;2;255;255;255mid: grub[0m
  [38;2;255;255;255mtitle: Booting from an existing Linux installation using GRUB[0m
  [38;2;255;255;255msidebar_label: Booting from GRUB[0m
  [38;2;255;255;255mdescription: "How to use GRUB to boot into netboot.xyz"[0m
  [38;2;255;255;255mhide[0m[38;2;233;192;98m_table_[0m[38;2;255;255;255mof_contents: true[0m
  [38;2;255;255;255m---[0m
  
  [38;2;255;255;255mIf you have an existing Linux system where you are unable to use iPXE or boot from a disk image, but you can see the GRUB menu on boot, you can boot into netboot.xyz using `grub-imageboot`.[0m
  
  [38;2;254;220;197m## On Debian/Ubuntu[0m
  
  [38;2;255;255;255m```bash[0m
  [38;2;254;220;197m# Install grub-imageboot[0m
  [38;2;255;255;255mapt install grub-imageboot[0m
  
  [38;2;254;220;197m# Download netboot.xyz ISO[0m
  [38;2;255;255;255mmkdir /boot/images[0m
  [38;2;255;255;255mcd /boot/images[0m
  [38;2;255;255;255mwget https://boot.netboot.xyz/ipxe/netboot.xyz.iso[0m
  
  [38;2;254;220;197m# Update GRUB menu to include this ISO[0m
  [38;2;255;255;255mupdate-grub2[0m
  [38;2;255;255;255mreboot[0m
  [38;2;255;255;255m```[0m
  
  [38;2;254;220;197m## On Red Hat Based Systems[0m
  
  [38;2;255;255;255m```shell[0m
  [38;2;255;255;255myum install syslinux wget -y[0m
  [38;2;255;255;255mcp /usr/share/syslinux/memdisk /boot/memdisk[0m
  [38;2;255;255;255mmkdir /boot/images[0m
  [38;2;255;255;255mcd /boot/images[0m
  [38;2;255;255;255mwget https://boot.netboot.xyz/ipxe/netboot.xyz.iso[0m
  [38;2;255;255;255mln -s /usr/share/grub/grub-mkconfig[0m[38;2;233;192;98m_lib /usr/lib/grub/grub-mkconfig_[0m[38;2;255;255;255mlib[0m
  [38;2;255;255;255m#Download iamgeboot config file[0m
  [38;2;255;255;255mwget https://raw.githubusercontent.com/formorer/grub-imageboot/529ac5d2bf91e7da8c31b9e15f37702127bddc1c/bin/60[0m[38;2;233;192;98m_grub-imageboot -O /etc/grub.d/60_[0m[38;2;255;255;255mgrub-imageboot[0m
  [38;2;255;255;255mchmod 755 /etc/grub.d/60_grub-imageboot[0m
  [38;2;255;255;255mgrub2-mkconfig -o /boot/grub2/grub.cfg[0m
  [38;2;255;255;255mreboot[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mAfter reboot, select "Bootable ISO Image: netboot.xyz" in the GRUB menu.[0m
  
  [38;2;255;255;255mIf the GRUB menu disappears too quickly, you may need to edit `/etc/default/grub` and increase the `GRUB_TIMEOUT`. Run `update-grub2` any time you modify this file.[0m
  
  

  File: [1m./booting/ipxe.md[0m
  [38;2;255;255;255m---[0m
  [38;2;255;255;255mid: ipxe[0m
  [38;2;255;255;255mtitle: Boot using iPXE[0m
  [38;2;255;255;255msidebar_label: Boot using iPXE[0m
  [38;2;255;255;255mdescription: "Details how to chainload into netboot.xyz from iPXE"[0m
  [38;2;255;255;255mhide[0m[38;2;233;192;98m_table_[0m[38;2;255;255;255mof_contents: true[0m
  [38;2;255;255;255m---[0m
  
  [38;2;254;220;197m### NIC with Embedded iPXE[0m
  
  [38;2;255;255;255mIf you've already compiled your own iPXE, you can load up the netboot.xyz menu easily by entering CTRL-B when prompted, setting DHCP and then chainloading iPXE:[0m
  
  [38;2;255;255;255m```bash[0m
  [38;2;255;255;255mdhcp[0m
  [38;2;255;255;255mchain --autofree https://boot.netboot.xyz[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mIf you don't have DHCP on your network, you can manually set your network information:[0m
  
  [38;2;255;255;255m```bash[0m
  [38;2;255;255;255mset net0/ip <ip>[0m
  [38;2;255;255;255mset net0/netmask <netmask>[0m
  [38;2;255;255;255mset net0/gateway <gateway>[0m
  [38;2;255;255;255mset dns <nameserver>[0m
  [38;2;255;255;255mifopen net0[0m
  [38;2;255;255;255mchain --autofree https://boot.netboot.xyz[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mSome iPXE builds do not support HTTPS connections. If you get an "Operation not supported" error message, run this instead:[0m
  
  [38;2;255;255;255m```bash[0m
  [38;2;255;255;255mchain --autofree http://boot.netboot.xyz[0m
  [38;2;255;255;255m```[0m
  
  [38;2;254;220;197m### KVM[0m
  
  [38;2;255;255;255mOn VPSes that use KVM, you can usually connect to the VPS via VNC, reboot it, press escape while rebooting to get a boot menu, then select the iPXE option. Once iPXE has started, press Ctrl-B and follow the instructions above.[0m

  File: [1m./booting/iso.md[0m
  [38;2;255;255;255m---[0m
  [38;2;255;255;255mid: iso[0m
  [38;2;255;255;255mtitle: Booting with an ISO[0m
  [38;2;255;255;255msidebar_label: Booting with an ISO[0m
  [38;2;255;255;255mdescription: "How to use an ISO to boot into netboot.xyz"[0m
  [38;2;255;255;255mhide[0m[38;2;233;192;98m_table_[0m[38;2;255;255;255mof_contents: true[0m
  [38;2;255;255;255m---[0m
  
  [38;2;254;220;197m### Burning a CD/DVD[0m
  
  [38;2;255;255;255mTo create a bootable CD-ROM/DVD, burn the ISO image [[0m[38;2;204;255;102mnetboot.xyz.iso[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://boot.netboot.xyz/ipxe/netboot.xyz.iso[0m[38;2;255;255;255m) to a blank CD-ROM/DVD.  Insert the media into the server, set the proper boot order and boot up.[0m
  
  [38;2;254;220;197m### Virtual Machine Software[0m
  
  [38;2;255;255;255mYou can also use these ISOs to boot any sort of VM in Citrix XenServer, Proxmox VE, VMware ESXi, VMware Fusion, VirtualBox.[0m
  
  [38;2;254;220;197m### Out of Band Virtual Media[0m
  
  [38;2;255;255;255mThey are great for attaching to remote virtual media of a server like the Dell DRAC or HP iLOs.  Because the iPXE boot disk is so light weight, they are great for starting installations where there might be really low bandwidth.[0m

  File: [1m./booting/qemu.md[0m
  [38;2;255;255;255m---[0m
  [38;2;255;255;255mid: qemu[0m
  [38;2;255;255;255mtitle: Booting from QEMU[0m
  [38;2;255;255;255msidebar_label: Booting from QEMU[0m
  [38;2;255;255;255mdescription: "Methods of booting into netboot.xyz using QEMU"[0m
  [38;2;255;255;255mhide[0m[38;2;233;192;98m_table_[0m[38;2;255;255;255mof_contents: true[0m
  [38;2;255;255;255m---[0m
  [38;2;254;220;197m### Overview[0m
  
  [38;2;255;255;255mA quick way to try out netboot.xyz without any modifications to your existing environment is to leverage QEMU.  You can start up a virtual machine to evaluate what netboot.xyz is and how it works.  You will need the qemu-system package for your appropriate operating system and a window manager installed.  In the example below we are using Ubuntu 20.04.[0m
  
  [38;2;254;220;197m### Install dependencies[0m
  
  [38;2;255;255;255m```bash[0m
  [38;2;254;220;197m# install the qemu-system package[0m
  [38;2;255;255;255msudo apt-get install -y qemu-system ovmf[0m
  
  [38;2;254;220;197m# download the latest combined Legacy and EFI iso[0m
  [38;2;255;255;255mwget https://boot.netboot.xyz/ipxe/netboot.xyz.iso[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mIf you want to write to a disk, you can set one at this point, or optionally you can boot without a disk if you want to test drive netboot.xyz:[0m
  
  [38;2;254;220;197m### Create a disk (optional)[0m
  
  [38;2;255;255;255m```bash[0m
  [38;2;255;255;255mqemu-img create -f raw vmdisk 8G[0m
  
  [38;2;254;220;197m# add the following to end of the qemu-system lines below if you want to add a disk to write to:[0m
  [38;2;254;220;197m# -drive file=vmdisk,format=raw[0m
  [38;2;255;255;255m```[0m
  
  [38;2;254;220;197m### Booting with Legacy PCBIOS[0m
  
  [38;2;255;255;255m```bash[0m
  [38;2;255;255;255mqemu-system-x86_64 -cdrom netboot.xyz.iso -m 4G[0m
  [38;2;255;255;255m```[0m
  
  [38;2;254;220;197m### Booting with a UEFI BIOS[0m
  
  [38;2;255;255;255m```bash[0m
  [38;2;255;255;255mqemu-system-x86_64 -bios /usr/share/ovmf/OVMF.fd -cdrom netboot.xyz.iso -m 4G[0m
  [38;2;255;255;255m```[0m
  
  [38;2;254;220;197m### Booting on MacOS Apple Silicon (M1)[0m
  
  [38;2;255;255;255m```bash[0m
  [38;2;255;255;255m$ brew install qemu[0m
  [38;2;255;255;255m$ qemu-system-aarch64 --version                                       [0m
  [38;2;255;255;255mQEMU emulator version 7.1.0[0m
  [38;2;255;255;255m$ qemu-system-aarch64 -cpu host -M virt,accel=hvf -m 4G \[0m
  [38;2;255;255;255m-drive file=/opt/homebrew/share/qemu/edk2-aarch64-code.fd,if=pflash,format=raw,readonly=on \[0m
  [38;2;255;255;255m-kernel netboot.xyz-arm64.efi \[0m
  [38;2;255;255;255m-serial stdio \[0m
  [38;2;255;255;255m-device virtio-gpu-pci \[0m
  [38;2;255;255;255m-device nec-usb-xhci -device usb-kbd[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255m:::note[0m
  [38;2;255;255;255mAt least 4GB of memory is recommended for some of the images that are loaded into RAM.  If you experience problems during initrd load, the machine usually just needs more RAM.[0m
  [38;2;255;255;255m:::[0m

  File: [1m./booting/tftp.md[0m
  [38;2;255;255;255m---[0m
  [38;2;255;255;255mid: tftp[0m
  [38;2;255;255;255mtitle: Booting from TFTP[0m
  [38;2;255;255;255msidebar_label: Booting from TFTP[0m
  [38;2;255;255;255mdescription: "Methods of booting into netboot.xyz using TFTP and DHCP"[0m
  [38;2;255;255;255mhide[0m[38;2;233;192;98m_table_[0m[38;2;255;255;255mof_contents: true[0m
  [38;2;255;255;255m---[0m
  
  [38;2;255;255;255mIf you want to utilize netboot.xyz from your home or office network, it's relatively easy to set up.  It will allow all of your devices on your network to have netboot.xyz available whenever you need it by just changing the boot order on your device, selecting network boot, or manually selecting the device to boot.[0m
  
  [38;2;254;220;197m### DHCP Server Setup[0m
  
  [38;2;255;255;255mYou will have to tell your DHCP server to provide a "next-server", the address of a TFTP server on your network, and a "filename", the netboot.xyz boot file (you can choose among different architecture systems [[0m[38;2;204;255;102mhere[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://netboot.xyz/downloads/[0m[38;2;255;255;255m). When your clients boot up, if they are set to network boot, they'll automatically get a valid DHCP address, pull down the netboot.xyz iPXE bootloader and load up the Operating System menu.[0m
  
  [38;2;255;255;255mExample:[0m
  
  [38;2;255;255;255m```[0m
  [38;2;255;255;255mnext-server "1.2.3.4"[0m
  [38;2;255;255;255mfilename "netboot.xyz.kpxe"[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mIf you are using [[0m[38;2;204;255;102mdnsmasq as your DHCP server[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://wiki.archlinux.org/index.php/dnsmasq#DHCP_server[0m[38;2;255;255;255m) as well as your TFTP server then setting the next-server option is as simple as adding the following line to `/etc/dnsmasq.conf`: [0m
  
  [38;2;255;255;255m```[0m
  [38;2;255;255;255mdhcp-option=66,"0.0.0.0"[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255m`0.0.0.0` is parsed as the address of the machine running dnsmasq.[0m
  
  [38;2;254;220;197m### TFTP Server Setup[0m
  
  [38;2;255;255;255mYou will need to set up a tftp server to host the iPXE files.  There are various types of TFTP servers out there and they all usually work pretty well.  You can also use dnsmasq to host the files as well.[0m
  
  [38;2;255;255;255mIf you use dnsmasq you can add this configuration to `/etc/dnsmasq.conf`:[0m
  
  [38;2;255;255;255m```[0m
  [38;2;255;255;255menable-tftp[0m
  [38;2;255;255;255mtftp-root=/var/lib/tftp[0m
  [38;2;255;255;255mdhcp-boot=netboot.xyz.kpxe[0m
  [38;2;255;255;255m```[0m
  
  [38;2;254;220;197m### Fixing the dnsmasq service[0m
  
  [38;2;255;255;255mIf you are running systemd and you can start dnsmasq fine manually but it fails to start at boot you may need to edit the [Unit] section of `/lib/systemd/system/dnsmasq.service` by changing:[0m
  
  [38;2;255;255;255m```[0m
  [38;2;255;255;255mAfter=network.target[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mto[0m
  
  [38;2;255;255;255m```[0m
  [38;2;255;255;255mAfter=network-online.target [0m
  [38;2;255;255;255m```[0m
  
  [38;2;254;220;197m### Regular and Undionly Boot Files[0m
  
  [38;2;255;255;255mIf you experiencing issues with the regular [[0m[38;2;204;255;102mnetboot.xyz.kpxe[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://boot.netboot.xyz/ipxe/netboot.xyz.kpxe[0m[38;2;255;255;255m) bootloader, you can try and use the [[0m[38;2;204;255;102mnetboot.xyz-undionly.kpxe[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://boot.netboot.xyz/ipxe/netboot.xyz-undionly.kpxe[0m[38;2;255;255;255m) bootloader.  The regular bootloader includes common NIC drivers in the iPXE image, while the undionly loader will piggyback off the NIC boot firmware.[0m

  File: [1m./booting/usb.md[0m
  [38;2;255;255;255m---[0m
  [38;2;255;255;255mid: usb[0m
  [38;2;255;255;255mtitle: Booting from USB[0m
  [38;2;255;255;255msidebar_label: Booting from USB[0m
  [38;2;255;255;255mdescription: "How to create a USB stick capable of booting into netboot.xyz"[0m
  [38;2;255;255;255mhide[0m[38;2;233;192;98m_table_[0m[38;2;255;255;255mof_contents: true[0m
  [38;2;255;255;255m---[0m
  [38;2;255;255;255m:::danger[0m
  [38;2;255;255;255mBackup your important data before writing the USB as it will overwrite anything on the USB key.[0m
  [38;2;255;255;255m:::[0m
  
  [38;2;255;255;255mDownload a netboot.xyz USB disk:[0m
  
  [38;2;255;255;255m* [[0m[38;2;204;255;102mnetboot.xyz.img[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://boot.netboot.xyz/ipxe/netboot.xyz.img[0m[38;2;255;255;255m)[0m
  
  [38;2;254;220;197m## Creating USB Key on Linux[0m
  
  [38;2;255;255;255mInsert a USB key in your computer and find the device name. Then use following command:[0m
  
  [38;2;255;255;255m```shell[0m
  [38;2;255;255;255mcat netboot.xyz.img > /dev/sdX[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mor[0m
  
  [38;2;255;255;255m```shell[0m
  [38;2;255;255;255mdd if=netboot.xyz.img of=/dev/sdX[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mwhere sdX is your usb drive.[0m
  
  [38;2;255;255;255mThe USB key should be ready to eject once finished.[0m
  
  [38;2;254;220;197m## Creating USB Key on MacOS[0m
  
  [38;2;233;192;98m__Run:_[0m[38;2;255;255;255m_[0m
  
  [38;2;255;255;255m```shell[0m
  [38;2;255;255;255mdiskutil list[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mto get the current list of devices[0m
  
  [38;2;233;192;98m___[0m[38;2;255;255;255mInsert the flash media.[0m[38;2;233;192;98m___[0m
  
  [38;2;233;192;98m__Run:_[0m[38;2;255;255;255m_[0m
  
  [38;2;255;255;255m```shell[0m
  [38;2;255;255;255mdiskutil list[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255magain and determine the device node assigned to your flash media (e.g. /dev/disk2).[0m
  
  [38;2;233;192;98m__Run:_[0m[38;2;255;255;255m_[0m
  
  [38;2;255;255;255m```shell[0m
  [38;2;255;255;255mdiskutil unmountDisk /dev/diskN[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255m(replace N with the disk number from the last command; in the previous example, N would be 2).[0m
  
  [38;2;233;192;98m__Execute:_[0m[38;2;255;255;255m_[0m
  
  [38;2;255;255;255m```shell[0m
  [38;2;255;255;255msudo dd if=netboot.xyz.img of=/dev/rdiskN bs=1m[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255m* Using /dev/rdisk instead of /dev/disk may be faster[0m
  [38;2;255;255;255m* If you see the error dd: Invalid number '1m', you are using GNU dd. Use the same command but replace bs=1m with bs=1M[0m
  [38;2;255;255;255m* If you see the error dd: /dev/diskN: Resource busy, make sure the disk is not in use. Start the 'Disk Utility.app' and unmount (don't eject) the drive[0m
  
  [38;2;233;192;98m__Run:_[0m[38;2;255;255;255m_[0m
  
  [38;2;255;255;255m```shell[0m
  [38;2;255;255;255mdiskutil eject /dev/diskN[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mand remove your flash media when the command completes.[0m
  
  [38;2;254;220;197m## Creating USB Key on Windows[0m
  
  [38;2;255;255;255mCheck out [[0m[38;2;204;255;102mRufus[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://rufus.akeo.ie/[0m[38;2;255;255;255m) to install the IMG file to a USB key.[0m
  
  [38;2;254;220;197m## Booting[0m
  
  [38;2;255;255;255mOnce you've created your key, reboot and set your BIOS to load the USB key first if it's not set for that already. You should see iPXE load up either load up netboot.xyz automatically or you will be prompted to set your networking information up.[0m

  File: [1m./booting/vmware.md[0m
  [38;2;255;255;255m---[0m
  [38;2;255;255;255mid: vmware[0m
  [38;2;255;255;255mtitle: Boot using VMware[0m
  [38;2;255;255;255msidebar_label: Boot using VMware[0m
  [38;2;255;255;255mdescription: "Using netboot.xyz in VMware to install a VM"[0m
  [38;2;255;255;255mhide[0m[38;2;233;192;98m_table_[0m[38;2;255;255;255mof_contents: true[0m
  [38;2;255;255;255m---[0m
  
  [38;2;254;220;197m### VMware Fusion[0m
  
  [38;2;255;255;255mThese instructions are for setting up netboot.xyz in a VM on VMware's Fusion for MacOS.[0m
  
  [38;2;254;220;197m### Create the VM[0m
  
  [38;2;255;255;255m* Add a new virtual machine.[0m
  [38;2;255;255;255m* Select "Install from disc or image".[0m
  [38;2;255;255;255m* Click on "Use another disk or disc image...".[0m
  [38;2;255;255;255m* Download and select the netboot.xyz [[0m[38;2;204;255;102mISO[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://boot.netboot.xyz/ipxe/netboot.xyz.iso[0m[38;2;255;255;255m).[0m
  [38;2;255;255;255m* On the Choose Operating System Screen, select the OS type you are planning on installing.  If you plan on testing multiple types of installs, you can just choose a CentOS 64-bit OS.[0m
  [38;2;255;255;255m* Click the "Customize Settings" and give the VM a name, like "netboot.xyz".[0m
  
  [38;2;255;255;255mThis will create your VM.[0m
  
  [38;2;254;220;197m### Running the VM[0m
  
  [38;2;233;192;98m_You'll need to adjust the memory settings of the VM to ensure you'll have enough memory to run the OS installers in memory.  Typically it's good to bump the memory up to 2GB to 4GB._[0m
  
  [38;2;255;255;255m* Click the wrench icon and click on Processors & Memory and bump up the memory to the desired amount of memory.[0m
  [38;2;255;255;255m* Start the VM up and you should see the netboot.xyz loader.[0m
  [38;2;255;255;255m* If you determine you no longer want to boot from netboot.xyz, you can either change the boot order to boot from the hard drive by default or delete the ISO from the VM.[0m

  File: [1m./community/build-automation.md[0m
  [38;2;255;255;255m---[0m
  [38;2;255;255;255mid: build-automation[0m
  [38;2;255;255;255mtitle: Build Automation[0m
  [38;2;255;255;255mdescription: "Details how the netboot.xyz automated build system works"[0m
  [38;2;255;255;255msidebar_label: Build Automation[0m
  [38;2;255;255;255mhide[0m[38;2;233;192;98m_table_[0m[38;2;255;255;255mof_contents: false[0m
  [38;2;255;255;255mhide_title: true[0m
  [38;2;255;255;255m---[0m
  
  [38;2;255;255;255m```mdx-code-block[0m
  [38;2;255;255;255mimport BuildAutomation, {toc as BuildAutomationTOC} from "@site/external/build-automation.md"[0m
  
  [38;2;255;255;255m<BuildAutomation />[0m
  
  [38;2;255;255;255mexport const toc = BuildAutomationTOC;[0m
  [38;2;255;255;255m```[0m

  File: [1m./community/changelog.md[0m
  [38;2;255;255;255m---[0m
  [38;2;255;255;255mid: changelog[0m
  [38;2;255;255;255mtitle: netboot.xyz changelog[0m
  [38;2;255;255;255mdescription: netboot.xyz changelog[0m
  [38;2;255;255;255mhide_title: true[0m
  [38;2;255;255;255msidebar_label: Changelog[0m
  [38;2;255;255;255m---[0m
  
  [38;2;255;255;255m```mdx-code-block[0m
  [38;2;255;255;255mimport Changelog, {toc as ChangelogTOC} from "@site/external/changelog.md"[0m
  
  [38;2;255;255;255m<Changelog />[0m
  
  [38;2;255;255;255mexport const toc = ChangelogTOC;[0m
  [38;2;255;255;255m```[0m

  File: [1m./community/contributing.md[0m
  [38;2;255;255;255m---[0m
  [38;2;255;255;255mid: contributing[0m
  [38;2;255;255;255mtitle: Contributing[0m
  [38;2;255;255;255mdescription: How to contribute to the netboot.xyz project[0m
  [38;2;255;255;255msidebar_label: Contributing[0m
  [38;2;255;255;255mhide_title: true[0m
  [38;2;255;255;255mhide[0m[38;2;233;192;98m_table_[0m[38;2;255;255;255mof_contents: true[0m
  [38;2;255;255;255m---[0m
  
  [38;2;255;255;255m```mdx-code-block[0m
  [38;2;255;255;255mimport Contributing, {toc as ContributingTOC} from "@site/external/contributing.md"[0m
  
  [38;2;255;255;255m<Contributing/>[0m
  
  [38;2;255;255;255mexport const toc = ContributingTOC;[0m
  
  [38;2;255;255;255m```[0m

  File: [1m./community/nbxyz-users.md[0m
  [38;2;255;255;255m---[0m
  [38;2;255;255;255mid: nbxyz-users[0m
  [38;2;255;255;255mtitle: netboot.xyz around the Internet[0m
  [38;2;255;255;255mdescription: News, articles, and links from around the world related to netboot.xyz[0m
  [38;2;255;255;255msidebar_label: Users[0m
  [38;2;255;255;255mhide_title: true[0m
  [38;2;255;255;255mhide[0m[38;2;233;192;98m_table_[0m[38;2;255;255;255mof_contents: true[0m
  [38;2;255;255;255m---[0m
  
  [38;2;254;220;197m# netboot.xyz around the Internet[0m
  
  [38;2;254;220;197m## Hacker News[0m
  
  [38;2;255;255;255m- [[0m[38;2;204;255;102mNetboot.xyz: your favorite operating systems in one place[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://news.ycombinator.com/item?id=31814288[0m[38;2;255;255;255m) (2022-06-19)[0m
  [38;2;255;255;255m- [[0m[38;2;204;255;102mNetboot Linux over the internet[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://news.ycombinator.com/item?id=14883590[0m[38;2;255;255;255m) (2017-07-29)[0m
  [38;2;255;255;255m- [[0m[38;2;204;255;102mNetboot[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://news.ycombinator.com/item?id=10923460[0m[38;2;255;255;255m) (2016-01-18)[0m
  
  [38;2;254;220;197m## Youtube[0m
  
  [38;2;255;255;255m- [[0m[38;2;204;255;102mTechnoTim: Meet netboot.xyz - Network Boot Any Operating System[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://youtu.be/4btW5x_clpg[0m[38;2;255;255;255m) (2023-11-11)[0m
  [38;2;255;255;255m- [[0m[38;2;204;255;102mLinus Tech Tips: Download These Handy Tools NOW! Essential USB Tools[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://youtu.be/0EtgwIajVqs?t=426[0m[38;2;255;255;255m) (2023-07-19)[0m
  
  [38;2;254;220;197m## Hosting Providers[0m
  
  [38;2;255;255;255m- [[0m[38;2;204;255;102m1gservers[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://1gservers.com/blog/system-administration/booting-into-netboot-xyz-is-now-supported/[0m[38;2;255;255;255m)[0m
  [38;2;255;255;255m- [[0m[38;2;204;255;102mEquinix Metal[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://metal.equinix.com/developers/docs/operating-systems/custom-ipxe/[0m[38;2;255;255;255m)[0m
  [38;2;255;255;255m- [[0m[38;2;204;255;102mExtraVM[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://extravm.com/billing/knowledgebase/39/Can-I-use-my-own-ISO-on-VPS.html[0m[38;2;255;255;255m)[0m
  [38;2;255;255;255m- [[0m[38;2;204;255;102mLeaseweb[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://kb.leaseweb.com/products/dedicated-server/installing-servers-using-your-own-pxe-boot-environment/[0m[38;2;255;255;255m)[0m
  [38;2;255;255;255m- [[0m[38;2;204;255;102mMVPS[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://www.mvps.net/docs/how-to-use-netboot-xyz-iso-to-install-other-operating-systems-on-your-vps/[0m[38;2;255;255;255m)[0m
  [38;2;255;255;255m- [[0m[38;2;204;255;102mQeru[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://billing.qeru.net/index.php?rp=/knowledgebase/5/VPS-FAQ.html[0m[38;2;255;255;255m)[0m
  [38;2;255;255;255m- [[0m[38;2;204;255;102mVultr[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://www.vultr.com/docs/ipxe-boot-feature/[0m[38;2;255;255;255m)[0m
  
  [38;2;254;220;197m## Open Source Projects[0m
  
  [38;2;255;255;255m- [[0m[38;2;204;255;102mQuickemu[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://github.com/quickemu-project/quickemu[0m[38;2;255;255;255m)[0m
  [38;2;255;255;255m- [[0m[38;2;204;255;102mTinkerbell[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://tinkerbell.org/examples/netboot-xyz/[0m[38;2;255;255;255m)[0m
  [38;2;255;255;255m- [[0m[38;2;204;255;102mu-root[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://github.com/u-root/u-root/blob/main/cmds/exp/netbootxyz/netbootxyz.go[0m[38;2;255;255;255m)[0m
  
  [38;2;255;255;255mAnd many other places as well. If you find us somewhere on the net, update this page![0m

  File: [1m./docker.md[0m
  [38;2;255;255;255m---[0m
  [38;2;255;255;255mid: docker[0m
  [38;2;255;255;255mtitle: Docker Container[0m
  [38;2;255;255;255mdescription: "How to use the netboot.xyz docker container"[0m
  [38;2;255;255;255mhide[0m[38;2;233;192;98m_table_[0m[38;2;255;255;255mof_contents: true[0m
  [38;2;255;255;255m---[0m
  
  [38;2;255;255;255m```mdx-code-block[0m
  [38;2;255;255;255mimport Docker, {toc as DockerTOC} from "@site/external/docker.md"[0m
  
  [38;2;255;255;255m<Docker/>[0m
  
  [38;2;255;255;255mexport const toc = DockerTOC;[0m
  
  [38;2;255;255;255m```[0m

  File: [1m./faq.md[0m
  [38;2;255;255;255m---[0m
  [38;2;255;255;255mid: faq[0m
  [38;2;255;255;255mtitle: Frequently Asked Questions (FAQ)[0m
  [38;2;255;255;255msidebar_label: FAQ[0m
  [38;2;255;255;255mdescription: "Frequently Asked Questions about the netboot.xyz project"[0m
  [38;2;255;255;255mhide[0m[38;2;233;192;98m_table_[0m[38;2;255;255;255mof_contents: true[0m
  [38;2;255;255;255m---[0m
  
  [38;2;254;220;197m### What is this?[0m
  
  [38;2;255;255;255mnetboot.xyz is tool that allows you to boot your favorite Operating System's installer or various utilities over the network with minimal overhead and all from a single menu system. It's similar to various tools netbooting tools of the past like boot.kernel.org with a lot more flexibility. The boot loader is very light weight being under 1MB in size which translates into a very quick time to create a USB key.[0m
  
  [38;2;254;220;197m### How does this work?[0m
  
  [38;2;255;255;255mnetboot.xyz uses an open source tool called iPXE. The bootloader calls to a webserver that hosts that the iPXE source files. The iPXE source files contain menus and logic that understand how the various Linux installers operate. When you select an Operating System, netboot.xyz retrieves the images from the project directory when possible or known and trusted performant mirrors. The location the file is pulled from is always displayed during retrieval. From the very beginning, we have made it a priority to make sure that the source code for the project is open and available for review so that our users can view and understand what is happening.[0m
  
  [38;2;254;220;197m### What is PXE Booting?[0m
  
  [38;2;255;255;255mPXE stands for [0m[1;38;2;233;192;98m**P**[0m[38;2;255;255;255mre-Boot e[0m[1;38;2;233;192;98m**X**[0m[38;2;255;255;255mecution [0m[1;38;2;233;192;98m**E**[0m[38;2;255;255;255mnvironment. PXE booting has been used for years to allow for clients to boot from a server over the network. It gives you an oportunity to automate a system inside the BIOS before it boots off its hard drive which opens up the door for running stateless machines without having to use storage in the system. PXE booting is used in many applications but it's most common use is automating the installation of bare metal or a virtual machine.[0m
  
  [38;2;254;220;197m### Will my favorite distribution work with netboot.xyz?[0m
  
  [38;2;255;255;255mUsually you need three things to boot up an OS over the network, the vmlinuz, the initramfs, and the rootfs. Distributions that support an installer kernel hosted on a mirror are typically the easier ones to implement as they are very lightweight. Distributions that only release ISOs are typically a bit more involved to implement as we have to use memdisk to load it up into memory.[0m
  
  [38;2;255;255;255mFrom [[0m[38;2;204;255;102msyslinux - memdisk[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://www.syslinux.org/wiki/index.php/MEMDISK[0m[38;2;255;255;255m): The majority of Linux based CD images will also fail to work with MEMDISK ISO emulation. Linux distributions require kernel and initrd files to be specified, as soon as these files are loaded the protected mode kernel driver(s) take control and the virtual CD will no longer be accessible. If any other files are required from the CD/DVD they will be missing, resulting in boot error(s). Linux distributions that only require kernel and initrd files function fully via ISO emulation, as no other data needs accessing from the virtual CD/DVD drive once they have been loaded. The boot loader has read all necessary files to memory by using INT 13h, before booting the kernel.[0m
  
  [38;2;255;255;255mTo get around these limitations, especially since memdisk is not supported with UEFI, we have built a CI/CD system that consumes the ISOs from upstream projects and prepares the needed files to boot the operating system remotely as a release. In some cases this may involve a small modification to the init scripts in order to tune the network boot flexibility or handle multiple parts for larger operating systems. Those releases are added to the endpoints.yml in the main netboot.xyz repo and are then available for download.[0m
  
  [38;2;255;255;255mYou can read more about our build system [[0m[38;2;204;255;102mhere[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://github.com/netbootxyz/build-pipelines/blob/master/README.md[0m[38;2;255;255;255m).[0m
  
  [38;2;254;220;197m### My distribution uses ISOs for delivery, how can I see if they work?[0m
  
  [38;2;255;255;255mYou can do a quick check by loading up netboot.xyz in a virtual environment baremetal. Make sure you have plenty of RAM as you are loading the ISO into RAM. Then select the iPXE command line and enter the following;[0m
  
  [38;2;255;255;255m```[0m
  [38;2;255;255;255mkernel https://boot.netboot.xyz/memdisk iso raw[0m
  [38;2;255;255;255minitrd http://url/to/iso[0m
  [38;2;255;255;255mboot[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mThat should load the ISO and if you make it all the way into the installer, great, your OS may work. If it fails during initramfs load trying to load the CD device, then it has the issue of not being able to find the ISO in memory.[0m
  
  [38;2;254;220;197m### Can I create my own configurations?[0m
  
  [38;2;255;255;255mYes!  You can fork [[0m[38;2;204;255;102mnetboot.xyz-custom[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://github.com/netbootxyz/netboot.xyz-custom[0m[38;2;255;255;255m) and create your own menu. You can then set your Github user from the Utility menu and your menu will show up in the main menu. If you don't want to set your user every time, you can custom compile the netboot.xyz iPXE code and include your github_user during the compile. This allows you to create your own menu without the maintenance of everything else.[0m
  
  [38;2;254;220;197m### Does netboot.xyz support Secure Boot?[0m
  
  [38;2;255;255;255miPXE and hence netboot.xyz does not support Secure Boot because its [[0m[38;2;204;255;102mbinaries are not signed by Microsoft[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://ipxe.org/appnote/etoken[0m[38;2;255;255;255m). You must disable Secure Boot mode in your computers firmware configuration menu before you can boot netboot.xyz.[0m
  
  [38;2;254;220;197m### How do we keep versions current?[0m
  
  [38;2;255;255;255mWe have a CI/CD system that monitors upstream projects for new releases. When a new release is detected for releases without hosted installer kernels, it will download the ISO, extract it, and then repackage it with the needed iPXE files to make it bootable. It will then push the release to the netboot.xyz endpoints.yml file and then push the changes to the netboot.xyz repo. The endpoints.yml file is then used by the netboot.xyz iPXE code to display the menu options. Versions change a lot, so automation is key in making the maintenance of the project sustainable.[0m
  
  [38;2;254;220;197m### What Operating Systems are currently available on netboot.xyz?[0m
  
  [38;2;254;220;197m#### Operating Systems[0m
  
  [38;2;255;255;255m| Name       | URL             | Installer Kernel | Live OS       |[0m
  [38;2;255;255;255m|------------|-----------------|------------------|---------------|[0m
  [38;2;255;255;255m| AlmaLinux | https://almalinux.org/ | Yes | No |[0m
  [38;2;255;255;255m| Alpine Linux | https://alpinelinux.org | Yes | No |[0m
  [38;2;255;255;255m| Arch Linux | https://www.archlinux.org | Yes | No |[0m
  [38;2;255;255;255m| Backbox | https://www.backbox.org | No | Yes |[0m
  [38;2;255;255;255m| BlackArch Linux | https://blackarch.org | Yes | Yes |[0m
  [38;2;255;255;255m| Bluestar Linux | https://sourceforge.net/projects/bluestarlinux | No | Yes |[0m
  [38;2;255;255;255m| Bodhi Linux | https://www.bodhilinux.com | No | Yes |[0m
  [38;2;255;255;255m| CentOS | https://centos.org | Yes | No |[0m
  [38;2;255;255;255m| Fedora CoreOS | https://getfedora.org/en/coreos?stream=stable | Yes | No |[0m
  [38;2;255;255;255m| Debian | https://debian.org | Yes | Yes|[0m
  [38;2;255;255;255m| Deepin | https://www.deepin.org | No | Yes |[0m
  [38;2;255;255;255m| Devuan | https://devuan.org | Yes | No |[0m
  [38;2;255;255;255m| Elementary OS | https://elementary.io | No | Yes |[0m
  [38;2;255;255;255m| EndeavourOS | https://endeavouros.com | No | Yes |[0m
  [38;2;255;255;255m| Fatdog64 | https://distro.ibiblio.org/fatdog/web/ | No | Yes |[0m
  [38;2;255;255;255m| Fedora | https://fedoraproject.org | Yes | Yes |[0m
  [38;2;255;255;255m| Feren OS | https://ferenos.weebly.com/ | Yes | No |[0m
  [38;2;255;255;255m| Flatcar Linux | https://www.flatcar.org/releases/ | Yes | No |[0m
  [38;2;255;255;255m| FreeBSD | https://freebsd.org | Yes, disk image | No |[0m
  [38;2;255;255;255m| FreeDOS | https://www.freedos.org | ISO - Memdisk| No |[0m
  [38;2;255;255;255m| Garuda Linux | https://garudalinux.org/ | No | Yes |[0m
  [38;2;255;255;255m| Gentoo | https://gentoo.org | Yes | Yes |[0m
  [38;2;255;255;255m| Harvester | https://harvesterhci.io | Yes | No |[0m
  [38;2;255;255;255m| hrmpf | https://github.com/leahneukirchen/hrmpf/ | No | Yes |[0m
  [38;2;255;255;255m| IPFire | https://www.ipfire.org | Yes | No |[0m
  [38;2;255;255;255m| K3OS | https://k3os.io/ | Yes | Yes |[0m
  [38;2;255;255;255m| Kali Linux | https://www.kali.org | Yes | Yes |[0m
  [38;2;255;255;255m| KDE Neon | https://neon.kde.org | No | Yes |[0m
  [38;2;255;255;255m| Kodachi | https://www.digi77.com/linux-kodachi/ | No | Yes |[0m
  [38;2;255;255;255m| Linux Lite | https://www.linuxliteos.com | No | Yes |[0m
  [38;2;255;255;255m| LXLE | https://lxle.net/ | No | Yes |[0m
  [38;2;255;255;255m| Mageia | https://www.mageia.org | Yes | No |[0m
  [38;2;255;255;255m| Manjaro | https://manjaro.org | No | Yes |[0m
  [38;2;255;255;255m| Mint | https://linuxmint.com | No | Yes |[0m
  [38;2;255;255;255m| Microsoft Windows | https://www.microsoft.com | User supplied media | No |[0m
  [38;2;255;255;255m| MirOS | http://www.mirbsd.org | Yes | No |[0m
  [38;2;255;255;255m| Nitrux | https://nxos.org/ | No | Yes |[0m
  [38;2;255;255;255m| NixOS | https://nixos.org | Yes | No |[0m
  [38;2;255;255;255m| OpenBSD | https://openbsd.org | Yes | No |[0m
  [38;2;255;255;255m| openEuler | https://www.openeuler.org/ | Yes | No |[0m
  [38;2;255;255;255m| OpenSUSE | https://opensuse.org | Yes | No |[0m
  [38;2;255;255;255m| Oracle Linux | https://www.oracle.com/linux/ | Yes | Installer |[0m
  [38;2;255;255;255m| Parrot Security | https://www.parrotsec.org | No | Yes |[0m
  [38;2;255;255;255m| Peppermint | https://peppermintos.com | No | Yes |[0m
  [38;2;255;255;255m| Pop OS |https://system76.com/pop| No | Yes |[0m
  [38;2;255;255;255m| Proxmox VE | https://www.proxmox.com/ | Yes | No |[0m
  [38;2;255;255;255m| Q4OS | https://q4os.org | No | Yes |[0m
  [38;2;255;255;255m| Raizo | https://sourceforge.net/projects/live-raizo/ | No | Yes |[0m
  [38;2;255;255;255m| RancherOS | https://rancher.com/rancher-os | Yes | No |[0m
  [38;2;255;255;255m| Red Hat Enterprise Linux | https://www.redhat.com | User supplied media | No |[0m
  [38;2;255;255;255m| Regolith | https://regolith-linux.org | No | Yes |[0m
  [38;2;255;255;255m| Rocky Linux | https://rockylinux.org/ | Yes | No |[0m
  [38;2;255;255;255m| Scientific Linux | https://scientificlinux.org | Yes | No |[0m
  [38;2;255;255;255m| Septor | https://septor.sourceforge.io | No | Yes |[0m
  [38;2;255;255;255m| Slackware | https://www.slackware.com | Yes | No |[0m
  [38;2;255;255;255m| SmartOS | https://www.smartos.org/ | Yes | No |[0m
  [38;2;255;255;255m| SparkyLinux | https://sparkylinux.org/ | No | Yes |[0m
  [38;2;255;255;255m| Tails | https://tails.boum.org/ | No | Yes |[0m
  [38;2;255;255;255m| Talos | https://www.talos.dev/ | Yes | No |[0m
  [38;2;255;255;255m| Tiny Core Linux | http://www.tinycorelinux.net/ | Yes | Yes |[0m
  [38;2;255;255;255m| Ubuntu | https://www.ubuntu.com | Yes | Yes |[0m
  [38;2;255;255;255m| VMware | https://www.vmware.com | User supplied media | No |[0m
  [38;2;255;255;255m| Voyager | https://voyagerlive.org | No | Yes |[0m
  [38;2;255;255;255m| VyOS | https://vyos.io | Yes | No |[0m
  [38;2;255;255;255m| Zen Installer | https://sourceforge.net/projects/revenge-installer | Yes | No |[0m
  [38;2;255;255;255m| Zorin OS | https://zorinos.com | No | Yes |[0m
  
  [38;2;254;220;197m### Utilities[0m
  
  [38;2;255;255;255m| Name       | URL                     | Type |[0m
  [38;2;255;255;255m|------------|-------------------------|------|[0m
  [38;2;255;255;255m| 4MLinux | https://4mlinux.com/ | Kernel/Initrd |[0m
  [38;2;255;255;255m| ALT Linux Rescue | https://en.altlinux.org/Rescue | ISO - Memdisk |[0m
  [38;2;255;255;255m| BakAndImgCD | https://bakandimgcd.4mlinux.com/ | Kernel/Initrd |[0m
  [38;2;255;255;255m| Boot Repair CD | https://sourceforge.net/projects/boot-repair-cd/ | LiveCD |[0m
  [38;2;255;255;255m| Breakin | https://www.advancedclustering.com/products/software/breakin/ | Kernel/Initrd |[0m
  [38;2;255;255;255m| CAINE | https://www.caine-live.net/ | LiveCD |[0m
  [38;2;255;255;255m| Clonezilla | https://clonezilla.org/ | LiveCD |[0m
  [38;2;255;255;255m| DBAN | https://dban.org/ | Kernel |[0m
  [38;2;255;255;255m| GParted | https://gparted.org | LiveCD |[0m
  [38;2;255;255;255m| Grml | https://grml.org | LiveCD |[0m
  [38;2;255;255;255m| Kaspersky Rescue Disk | https://support.kaspersky.com/viruses/krd18 | LiveCD |[0m
  [38;2;255;255;255m| Memtest | https://www.memtest.org/ | Kernel |[0m
  [38;2;255;255;255m| MemTest86 Free | https://www.memtest86.com | USB Img |[0m
  [38;2;255;255;255m| Redo Rescue | http://redorescue.com/ | LiveCD |[0m
  [38;2;255;255;255m| Rescatux | https://www.supergrubdisk.org/rescatux/ | LiveCD |[0m
  [38;2;255;255;255m| Rescuezilla | https://rescuezilla.com/ | LiveCD |[0m
  [38;2;255;255;255m| ShredOS | https://github.com/PartialVolume/shredos.x86_64 | Kernel | [0m
  [38;2;255;255;255m| Super Grub2 Disk | https://www.supergrubdisk.org/ | ISO - Memdisk |[0m
  [38;2;255;255;255m| System Rescue | https://www.system-rescue.org/ | LiveCD |[0m
  [38;2;255;255;255m| The Smallest Server Suite | https://thesss.4mlinux.com/ | Kernel/Initrd |[0m
  [38;2;255;255;255m| Ultimate Boot CD | https://www.ultimatebootcd.com/ | ISO - Memdisk |[0m
  
  [38;2;254;220;197m### What are some good resources for learning more about network booting?[0m
  
  [38;2;255;255;255m* [[0m[38;2;204;255;102mThe iPXE Project[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://ipxe.org/[0m[38;2;255;255;255m)[0m
  [38;2;255;255;255m* [[0m[38;2;204;255;102mNetworkBoot.org[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://networkboot.org/[0m[38;2;255;255;255m)[0m
  [38;2;255;255;255m* [[0m[38;2;204;255;102mSyslinux Project[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://www.syslinux.org/wiki/index.php?title=The_Syslinux_Project[0m[38;2;255;255;255m)[0m

  File: [1m./introduction.md[0m
  [38;2;255;255;255m---[0m
  [38;2;255;255;255mid: introduction[0m
  [38;2;255;255;255mtitle: Introduction[0m
  [38;2;255;255;255mdescription: netboot.xyz uses iPXE to network boot Operating System installers and utilities from an easy to use menu."[0m
  [38;2;255;255;255mhide[0m[38;2;233;192;98m_table_[0m[38;2;255;255;255mof_contents: true[0m
  [38;2;255;255;255mslug: /[0m
  [38;2;255;255;255m---[0m
  
  [38;2;255;255;255m[[0m[38;2;204;255;102mnetboot.xyz[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://netboot.xyz[0m[38;2;255;255;255m) lets you [[0m[38;2;204;255;102mPXE[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://en.wikipedia.org/wiki/Preboot_Execution_Environment[0m[38;2;255;255;255m) boot various operating system installers or utilities from a single tool over the network. This lets you use one media for many types of operating systems or tools. The [[0m[38;2;204;255;102miPXE[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://ipxe.org/[0m[38;2;255;255;255m) project is used to provide a user friendly menu from within the BIOS that lets you easily choose the operating system you want along with any specific types of versions or bootable flags.[0m
  
  [38;2;255;255;255mYou can remote attach the ISO to servers, set it up as a rescue option in Grub, or even set up your home network to boot to it by default so that it's always available.[0m
  
  [38;2;255;255;255m![[0m[38;2;204;255;102mnetboot.xyz menu[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100m../static/img/netboot.xyz.gif[0m[38;2;255;255;255m)[0m
  
  [38;2;254;220;197m## Menu Overview[0m
  
  [38;2;254;220;197m### Linux Network Installs Menu[0m
  
  [38;2;255;255;255mFor Operating System projects that provide a network bootable installer, this a lightweight method for installation as it retrieves a minimal set of installer kernels and then installs packages as needed. This is typically the faster method of OS installation as it provides just enough installer to get you running and then downloads only the packages needed. You can also leverage built in tools for doing rescue boots too.[0m
  
  [38;2;254;220;197m### Live CD/Distro Menu[0m
  
  [38;2;255;255;255mMany Operating System projects provide their software as an ISO only or provide a Live CD/DVD that you can download and boot into memory without modifying the storage of the machine. Typically you then have the option to do an install from the live system.  These are typically heavier weight installs and can take a lot of bandwidth to install. iPXE generally does not boot the ISOs directly that well.[0m
  
  [38;2;255;255;255mIn order for us to make it easy to consume those types of images, we monitor new version updates from upstream, retrieve the releases, extract them, and re-release them with modifications to the initrd as needed to make them iPXE friendly. We then can load the smaller size kernel directly into memory for a better and more consistent experience.[0m
  
  [38;2;254;220;197m### Utilities Menu[0m
  
  [38;2;255;255;255mThe Utilities menu provides access to tools and utilities for tools like disk cloning, drive wiping, or other rescue type of tooling. You can also select other netboot.xyz endpoints to test menus that may be in development.[0m
  
  [38;2;254;220;197m## Supported Architectures[0m
  
  [38;2;255;255;255mnetboot.xyz supports x86 (both 32-bit and 64-bit) as well as arm64 architectures. Both Legacy and UEFI BIOS modes are supported. The menus identify the platform loaded and enable menu options based on the architecture loaded.[0m

  File: [1m./kb/hardware/steamdeck.md[0m
  [38;2;255;255;255m---[0m
  [38;2;255;255;255mid: steamdeck[0m
  [38;2;255;255;255mtitle: PXE Booting on the Steam Deck[0m
  [38;2;255;255;255msidebar_label: Steam Deck[0m
  [38;2;255;255;255mdescription: PXE Booting on the Steam Deck[0m
  [38;2;255;255;255mhide[0m[38;2;233;192;98m_table_[0m[38;2;255;255;255mof_contents: true[0m
  [38;2;255;255;255m---[0m
  
  [38;2;254;220;197m## Overview[0m
  
  [38;2;255;255;255mThis is a guide to PXE booting the [[0m[38;2;204;255;102mValve Steam Deck[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://store.steampowered.com/steamdeck[0m[38;2;255;255;255m).[0m
  
  [38;2;254;220;197m## Requirements[0m
  
  [38;2;255;255;255mTo get the Steam Deck to PXE boot, you will need:[0m
  
  [38;2;255;255;255m- [[0m[38;2;204;255;102mUSB-C Hub[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://amzn.to/3zveSgu[0m[38;2;255;255;255m) that supports Ethernet and USB[0m
  [38;2;255;255;255m- USB Keyboard[0m
  [38;2;255;255;255m- Hard Wired Ethernet[0m
  
  [38;2;255;255;255mConnect the hub, ethernet, and power up to the Steam Deck. The first thing you will want to do is set the BIOS to allow for PXE booting.[0m
  
  [38;2;254;220;197m## BIOS Configuration[0m
  
  [38;2;255;255;255mTo bring up the Steam Deck Boot Loader menus, shutdown the Steam Deck and:[0m
  
  [38;2;255;255;255m- Hold down `Volume +`, while pressing the power button `on` to access the Boot Manager, Setup Utility and Boot from File Menu. (`Volume -` will bring up just the Boot Manager)[0m
  [38;2;255;255;255m- Select Setup Utility to enter into the Setup.[0m
  [38;2;255;255;255m- Move down to the Boot Tab on the left and change these settings:[0m
  [38;2;255;255;255m  - Quick Boot: Disabled[0m
  [38;2;255;255;255m  - Quiet Boot: Disabled[0m
  [38;2;255;255;255m  - PXE Boot Capability: UEFI: IPv4 (Can change to what is appropriate for your network)[0m
  [38;2;255;255;255m  - Add Boot Options: First[0m
  [38;2;255;255;255m- Select Exit and Exit Saving Changes.[0m
  
  [38;2;254;220;197m## PXE Booting[0m
  
  [38;2;255;255;255mThe Steam Deck will now reboot and you will now see the Memory test as Quiet Boot has been disabled. If your Hub is connected to the network properly, and you have DHCP on the network, you should see:[0m
  
  [38;2;255;255;255m```shell[0m
  [38;2;255;255;255m>>Start PXE over IPv4...[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mAt this point you should be able to PXE boot a UEFI image.[0m
  
  [38;2;255;255;255mUse the:[0m
  
  [38;2;255;255;255m- [[0m[38;2;204;255;102mnetboot.xyz UEFI kernel[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://boot.netboot.xyz/ipxe/netboot.xyz.efi[0m[38;2;255;255;255m)[0m
  [38;2;255;255;255m- Set DHCP [[0m[38;2;204;255;102mnext-server[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://netboot.xyz/docs/booting/tftp[0m[38;2;255;255;255m) to TFTP server, and filename to the netboot.xyz UEFI image on the DHCP server[0m
  
  [38;2;255;255;255mIf you happen to break the Steam Deck when testing Operating Systems or tinkering with it, you can follow the Steam Deck Recovery Instructions [[0m[38;2;204;255;102mhere[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://help.steampowered.com/en/faqs/view/1B71-EDF2-EB6D-2BB3[0m[38;2;255;255;255m).[0m
  
  [38;2;255;255;255mIf you want to set the BIOS back to the default settings, you can load the BIOS back up, select Restore Defaults, and Exit Saving Changes. That will return the Steam Deck back to its original behavior.[0m

  File: [1m./kb/networking/asuswrt-merlin.md[0m
  [38;2;255;255;255m---[0m
  [38;2;255;255;255mid: asuswrt-merlin[0m
  [38;2;255;255;255mtitle: "Asuswrt-Merlin"[0m
  [38;2;255;255;255mdescription: Asuswrt-Merlin Usage[0m
  [38;2;255;255;255mhide[0m[38;2;233;192;98m_table_[0m[38;2;255;255;255mof_contents: true[0m
  [38;2;255;255;255m---[0m
  
  [38;2;255;255;255mThis will enable legacy BIOS, and UEFI devices to PXE boot into the [[0m[38;2;204;255;102mnetboot.xyz[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://github.com/netbootxyz/netboot.xyz[0m[38;2;255;255;255m) menu on Asuswrt-Merlin devices.[0m
  
  [38;2;255;255;255mAssume your AsusWRT-Merlin router is 192.168.1.1; Login to GUI[0m
  [38;2;255;255;255m1. LAN -> DHCP Server -> Basic Config: Set "Enable the DHCP Server" to Yes; IP Pool Starting Address: 192.168.1.2; IP Pool Ending Address: 192.168.1.254[0m
  [38;2;255;255;255m2. Administration -> System -> Service: Set "Enable SSH" to LAN Only[0m
  [38;2;255;255;255m3. Administration -> System -> Persistent JFFS2 partition: Set "Enable JFFS custom scripts and configs" to Yes  [0m
  
  [38;2;255;255;255m:::note[0m
  
  [38;2;255;255;255mJFFS is a writeable section of the flash memory (the size will vary between router models, with the newer models having a bit over 60 MB of space available), which will allow you to store small files (such as scripts) inside the router without needing to have a USB disk plugged in. This space will survive reboot ([0m[1;38;2;233;192;98m**but it might NOT survive firmware flashing, so back it up first before flashing!**[0m[38;2;255;255;255m).[0m
  
  [38;2;255;255;255m:::[0m
  
  [38;2;255;255;255m4. Reboot the router from the GUI and wait until you can ping 192.168.1.1[0m
  [38;2;255;255;255m5. `ssh username@192.168.1.1`[0m
  [38;2;255;255;255m6. `mkdir /jffs/tftproot`[0m
  [38;2;255;255;255m7. `curl -o /jffs/tftproot/netboot.xyz.kpxe https://boot.netboot.xyz/ipxe/netboot.xyz.kpxe`[0m
  [38;2;255;255;255m8. `curl -o /jffs/tftproot/netboot.xyz.efi https://boot.netboot.xyz/ipxe/netboot.xyz.efi`[0m
  [38;2;255;255;255m9. `touch /jffs/configs/dnsmasq.conf.add`[0m
  [38;2;255;255;255m10. `nano /jffs/configs/dnsmasq.conf.add` and add the following:[0m
  
  [38;2;255;255;255m> enable-tftp  [0m
  [38;2;255;255;255m> tftp-root=/jffs/tftproot  [0m
  [38;2;255;255;255m> dhcp-match=set:bios,60,PXEClient:Arch:00000  [0m
  [38;2;255;255;255m> dhcp-boot=tag:bios,netboot.xyz.kpxe,,192.168.1.1  [0m
  [38;2;255;255;255m> dhcp-match=set:efi32,60,PXEClient:Arch:00002  [0m
  [38;2;255;255;255m> dhcp-boot=tag:efi32,netboot.xyz.efi,,192.168.1.1  [0m
  [38;2;255;255;255m> dhcp-match=set:efi32-1,60,PXEClient:Arch:00006  [0m
  [38;2;255;255;255m> dhcp-boot=tag:efi32-1,netboot.xyz.efi,,192.168.1.1  [0m
  [38;2;255;255;255m> dhcp-match=set:efi64,60,PXEClient:Arch:00007  [0m
  [38;2;255;255;255m> dhcp-boot=tag:efi64,netboot.xyz.efi,,192.168.1.1  [0m
  [38;2;255;255;255m> dhcp-match=set:efi64-1,60,PXEClient:Arch:00008  [0m
  [38;2;255;255;255m> dhcp-boot=tag:efi64-1,netboot.xyz.efi,,192.168.1.1  [0m
  [38;2;255;255;255m> dhcp-match=set:efi64-2,60,PXEClient:Arch:00009  [0m
  [38;2;255;255;255m> dhcp-boot=tag:efi64-2,netboot.xyz.efi,,192.168.1.1  [0m
  
  [38;2;255;255;255m11. `reboot` and wait until you can ping 192.168.1.1[0m
  [38;2;255;255;255m12. from another device confirm that TFTP is working on the router[0m
  
  [38;2;255;255;255m> `tftp 192.168.1.1`  [0m
  [38;2;255;255;255m> tftp> `get netboot.xyz.kpxe`  [0m
  [38;2;255;255;255m> Received 368475 bytes in 0.5 seconds  [0m
  
  [38;2;255;255;255m13. Test with an UEFI device and with a legacy BIOS device that PXE booting is working (you might have enable PXE booting in the BIOS and/or in UEFI. For UEFI you usually have to enable UEFI Networking stack).[0m
  
  [38;2;255;255;255mReferences:[0m
  
  [38;2;255;255;255m* https://programmingflow.com/2015/04/08/boot-any-machine-in-your-home-with-pxe.html[0m
  [38;2;255;255;255m* https://netboot.xyz/docs/kb/networking/edgerouter[0m
  [38;2;255;255;255m* https://github.com/RMerl/asuswrt-merlin.ng/wiki/Custom-config-files[0m

  File: [1m./kb/networking/edgerouter.md[0m
  [38;2;255;255;255m---[0m
  [38;2;255;255;255mid: edgerouter[0m
  [38;2;255;255;255mtitle: "Ubiquiti EdgeRouter"[0m
  [38;2;255;255;255mdescription: Ubiquiti EdgeRouter Usage[0m
  [38;2;255;255;255mhide[0m[38;2;233;192;98m_table_[0m[38;2;255;255;255mof_contents: true[0m
  [38;2;255;255;255m---[0m
  
  [38;2;255;255;255mThis document covers how to setup netboot.xyz, a service that provides[0m
  [38;2;255;255;255miPXE-based installation and live boot of a bunch of operating systems,[0m
  [38;2;255;255;255mon a Ubiquiti EdgeRouter.[0m
  
  [38;2;255;255;255mThanks go to [[0m[38;2;204;255;102mSam Kottler[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://github.com/skottler[0m[38;2;255;255;255m) for originally writing up this how-to. Improve setup robustness by using the embedded TFTP daemon from dnsmasq by [[0m[38;2;204;255;102mYan Grunenberger[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://github.com/ravens[0m[38;2;255;255;255m) instead of external TFTP package.[0m
  
  [38;2;254;220;197m### Assumptions[0m
  
  [38;2;255;255;255mI've made a few assumptions throughout this document that will probably be[0m
  [38;2;255;255;255mdifferent for your setup:[0m
  
  [38;2;255;255;255m* There is a DHCP pool called `LAN`[0m
  [38;2;255;255;255m* The `LAN` pool manages `10.10.2.0/24`[0m
  
  [38;2;254;220;197m### Configure tftp support in dnsmasq[0m
  
  [38;2;255;255;255mBy default, dnsmasq is using in the Edgerouter to provide DNS services. In order to enable it :[0m
  
  [38;2;255;255;255m```bash[0m
  [38;2;255;255;255msudo mkdir /config/user-data/tftproot[0m
  [38;2;255;255;255msudo chmod ugo+rX /config/user-data/tftproot[0m
  
  [38;2;255;255;255mconfigure[0m
  
  [38;2;255;255;255mset service dns forwarding  options enable-tftp[0m
  [38;2;255;255;255mset service dns forwarding  options tftp-root=/config/user-data/tftproot[0m
  
  [38;2;255;255;255mcommit[0m
  [38;2;255;255;255msave[0m
  [38;2;255;255;255m```[0m
  
  [38;2;254;220;197m### Setup TFTP components[0m
  
  [38;2;255;255;255mDownload the kpxe image for netboot.xyz and set the permissions properly:[0m
  
  [38;2;255;255;255m```bash[0m
  [38;2;255;255;255msudo curl -o /config/user-data/tftproot/netboot.xyz.kpxe https://boot.netboot.xyz/ipxe/netboot.xyz.kpxe[0m
  [38;2;255;255;255msudo chmod ugo+r /config/user-data/tftproot/netboot.xyz.kpxe[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mAt this point you should be able to use a TFTP client from a client in[0m
  [38;2;255;255;255m`10.10.2.0/24` to fetch the image:[0m
  
  [38;2;255;255;255m```bash[0m
  [38;2;255;255;255m$ tftp 10.10.2.1[0m
  [38;2;255;255;255mtftp> get netboot.xyz.kpxe[0m
  [38;2;255;255;255mReceived 354972 bytes in 2.0 seconds[0m
  [38;2;255;255;255m```[0m
  
  [38;2;254;220;197m### Configure dhcpd[0m
  
  [38;2;255;255;255mWe're gonna configure DHCP on the EdgeRouter to serve the right parameters to[0m
  [38;2;255;255;255mclients:[0m
  
  [38;2;255;255;255m```bash[0m
  [38;2;255;255;255mconfigure[0m
  
  [38;2;255;255;255mset service dhcp-server global-parameters "option client-arch code 93 = unsigned integer 16;"[0m
  [38;2;255;255;255medit service dhcp-server shared-network-name LAN subnet 10.10.2.0/24[0m
  [38;2;255;255;255mset bootfile-server 10.10.2.1[0m
  [38;2;255;255;255mset bootfile-name netboot.xyz.kpxe[0m
  
  [38;2;255;255;255mcommit[0m
  [38;2;255;255;255msave[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mThe configuration for the `LAN` pool should now look something like the following:[0m
  
  [38;2;255;255;255m```bash[0m
  [38;2;255;255;255mskottler@edge1# show service dhcp-server shared-network-name LAN[0m
  [38;2;255;255;255m authoritative enable[0m
  [38;2;255;255;255m subnet 10.10.2.0/24 {[0m
  [38;2;255;255;255m     bootfile-name netboot.xyz.kpxe[0m
  [38;2;255;255;255m     bootfile-server 10.10.2.1[0m
  [38;2;255;255;255m     default-router 10.10.2.1[0m
  [38;2;255;255;255m     dns-server 10.10.2.1[0m
  [38;2;255;255;255m     lease 86400[0m
  [38;2;255;255;255m     start 10.10.2.100 {[0m
  [38;2;255;255;255m         stop 10.10.2.199[0m
  [38;2;255;255;255m     }[0m
  [38;2;255;255;255m }[0m
  [38;2;255;255;255m[edit][0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mThat's it![0m
  
  [38;2;254;220;197m## The advanced setup with support for Legacy and UEFI[0m
  
  [38;2;254;220;197m### Using ISC DHCP[0m
  
  [38;2;255;255;255mThis section was written by [[0m[38;2;204;255;102mSkyler Mäntysaari[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://github.com/samip5[0m[38;2;255;255;255m).[0m
  
  [38;2;255;255;255mThis requires that you do not use `set service dhcp-server use-dnsmasq enable`. If you do use that, it will not work.[0m
  
  [38;2;255;255;255mWe are going to start by removing the PXE boot related things from dhcp-server options, so the commands for that are something like:[0m
  
  [38;2;255;255;255m```bash[0m
  [38;2;255;255;255mdelete service dhcp-server shared-network-name LAN subnet 10.10.2.0/24 bootfile-name netboot.xyz.kpxe[0m
  [38;2;255;255;255mdelete service dhcp-server shared-network-name LAN subnet 10.10.2.0/24 bootfile-server 10.10.2.1[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mWe are now going to download the efi version of the boot file if it does not exist yet:[0m
  [38;2;255;255;255m```[0m
  [38;2;255;255;255msudo curl -o /config/user-data/tftproot/netboot.xyz.efi https://boot.netboot.xyz/ipxe/netboot.xyz.efi[0m
  [38;2;255;255;255msudo chmod ugo+r /config/user-data/tftproot/netboot.xyz.efi[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mNext we are going to create a scripts folder for the scripts, in persistent storage (should persist over upgrades):[0m
  
  [38;2;255;255;255m```bash[0m
  [38;2;255;255;255mmkdir --parents /config/user-data/scripts/pxe/[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mNext we are going to go into configure mode, and include the main pxe config file:[0m
  
  [38;2;255;255;255m```bash[0m
  [38;2;255;255;255mset service dhcp-server global-parameters "deny bootp;"[0m
  [38;2;255;255;255mset service dhcp-server global-parameters "include &quot;/config/user-data/scripts/pxe/option-space.conf&quot;;"[0m
  [38;2;255;255;255mset service dhcp-server shared-network-name LAN subnet 10.10.2.0/24 subnet-parameters "include &quot;/config/user-data/scripts/pxe/pxe.conf&quot;;"[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mIT NEEDS to be typed exactly like that, the "" part.[0m
  
  [38;2;255;255;255mThe file /config/user-data/scripts/pxe/pxe.conf:[0m
  
  [38;2;255;255;255m```bash[0m
  [38;2;255;255;255mallow booting;[0m
  [38;2;255;255;255mnext-server 10.10.2.1;[0m
  
  [38;2;255;255;255mif option arch = 00:07 {[0m
  [38;2;255;255;255m    filename "netboot.xyz.efi";[0m
  [38;2;255;255;255m} elsif option arch = 00:00 {[0m
  [38;2;255;255;255m    filename "netboot.xyz.kpxe";[0m
  [38;2;255;255;255m} else {[0m
  [38;2;255;255;255m    filename "netboot.xyz.efi";[0m
  [38;2;255;255;255m}[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mThe file /config/user-data/scripts/pxe/option-space.conf:[0m
  
  [38;2;255;255;255m```bash[0m
  [38;2;254;220;197m# Declare the iPXE/gPXE/Etherboot option space[0m
  [38;2;255;255;255moption space ipxe;[0m
  [38;2;255;255;255moption ipxe-encap-opts code 175 = encapsulate ipxe;[0m
  
  [38;2;254;220;197m# iPXE options, can be set in DHCP response packet[0m
  [38;2;255;255;255moption ipxe.priority         code   1 = signed integer 8;[0m
  [38;2;255;255;255moption ipxe.keep-san         code   8 = unsigned integer 8;[0m
  [38;2;255;255;255moption ipxe.skip-san-boot    code   9 = unsigned integer 8;[0m
  [38;2;255;255;255moption ipxe.syslogs          code  85 = string;[0m
  [38;2;255;255;255moption ipxe.cert             code  91 = string;[0m
  [38;2;255;255;255moption ipxe.privkey          code  92 = string;[0m
  [38;2;255;255;255moption ipxe.crosscert        code  93 = string;[0m
  [38;2;255;255;255moption ipxe.no-pxedhcp       code 176 = unsigned integer 8;[0m
  [38;2;255;255;255moption ipxe.bus-id           code 177 = string;[0m
  [38;2;255;255;255moption ipxe.bios-drive       code 189 = unsigned integer 8;[0m
  [38;2;255;255;255moption ipxe.username         code 190 = string;[0m
  [38;2;255;255;255moption ipxe.password         code 191 = string;[0m
  [38;2;255;255;255moption ipxe.reverse-username code 192 = string;[0m
  [38;2;255;255;255moption ipxe.reverse-password code 193 = string;[0m
  [38;2;255;255;255moption ipxe.version          code 235 = string;[0m
  [38;2;255;255;255moption iscsi-initiator-iqn   code 203 = string;[0m
  
  [38;2;254;220;197m# iPXE feature flags, set in DHCP request packet[0m
  [38;2;255;255;255moption ipxe.pxeext    code 16 = unsigned integer 8;[0m
  [38;2;255;255;255moption ipxe.iscsi     code 17 = unsigned integer 8;[0m
  [38;2;255;255;255moption ipxe.aoe       code 18 = unsigned integer 8;[0m
  [38;2;255;255;255moption ipxe.http      code 19 = unsigned integer 8;[0m
  [38;2;255;255;255moption ipxe.https     code 20 = unsigned integer 8;[0m
  [38;2;255;255;255moption ipxe.tftp      code 21 = unsigned integer 8;[0m
  [38;2;255;255;255moption ipxe.ftp       code 22 = unsigned integer 8;[0m
  [38;2;255;255;255moption ipxe.dns       code 23 = unsigned integer 8;[0m
  [38;2;255;255;255moption ipxe.bzimage   code 24 = unsigned integer 8;[0m
  [38;2;255;255;255moption ipxe.multiboot code 25 = unsigned integer 8;[0m
  [38;2;255;255;255moption ipxe.slam      code 26 = unsigned integer 8;[0m
  [38;2;255;255;255moption ipxe.srp       code 27 = unsigned integer 8;[0m
  [38;2;255;255;255moption ipxe.nbi       code 32 = unsigned integer 8;[0m
  [38;2;255;255;255moption ipxe.pxe       code 33 = unsigned integer 8;[0m
  [38;2;255;255;255moption ipxe.elf       code 34 = unsigned integer 8;[0m
  [38;2;255;255;255moption ipxe.comboot   code 35 = unsigned integer 8;[0m
  [38;2;255;255;255moption ipxe.efi       code 36 = unsigned integer 8;[0m
  [38;2;255;255;255moption ipxe.fcoe      code 37 = unsigned integer 8;[0m
  [38;2;255;255;255moption ipxe.vlan      code 38 = unsigned integer 8;[0m
  [38;2;255;255;255moption ipxe.menu      code 39 = unsigned integer 8;[0m
  [38;2;255;255;255moption ipxe.sdi       code 40 = unsigned integer 8;[0m
  [38;2;255;255;255moption ipxe.nfs       code 41 = unsigned integer 8;[0m
  
  [38;2;254;220;197m# Other useful general options[0m
  [38;2;254;220;197m# https://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters.xhtml[0m
  [38;2;255;255;255moption arch code 93 = unsigned integer 16;[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mAfter all of that, it should be it! I hope that helps.[0m
  
  [38;2;254;220;197m### Using dnsmasq[0m
  
  [38;2;255;255;255mThis section was written by [[0m[38;2;204;255;102mBenjamin Reich[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://benjaminreich.de/[0m[38;2;255;255;255m).[0m
  
  [38;2;255;255;255mThis Part is requierd if you using `set service dhcp-server use-dnsmasq enable`.[0m
  
  [38;2;255;255;255mConnect via SSH and replace `SERVERIP` with the actual IP.[0m
  
  [38;2;255;255;255m```bash[0m
  [38;2;255;255;255mconfigure[0m
  [38;2;255;255;255mset service dhcp-server use-dnsmasq enable[0m
  [38;2;255;255;255mset service dns forwarding options "dhcp-match=set:bios,60,PXEClient:Arch:00000"[0m
  [38;2;255;255;255mset service dns forwarding options "dhcp-boot=tag:bios,netboot.xyz.kpxe,,SERVERIP"[0m
  [38;2;255;255;255mset service dns forwarding options "dhcp-match=set:efi32,60,PXEClient:Arch:00002"[0m
  [38;2;255;255;255mset service dns forwarding options "dhcp-boot=tag:efi32,netboot.xyz.efi,,SERVERIP"[0m
  [38;2;255;255;255mset service dns forwarding options "dhcp-match=set:efi32-1,60,PXEClient:Arch:00006"[0m
  [38;2;255;255;255mset service dns forwarding options "dhcp-boot=tag:efi32-1,netboot.xyz.efi,,SERVERIP"[0m
  [38;2;255;255;255mset service dns forwarding options "dhcp-match=set:efi64,60,PXEClient:Arch:00007"[0m
  [38;2;255;255;255mset service dns forwarding options "dhcp-boot=tag:efi64,netboot.xyz.efi,,SERVERIP"[0m
  [38;2;255;255;255mset service dns forwarding options "dhcp-match=set:efi64-1,60,PXEClient:Arch:00008"[0m
  [38;2;255;255;255mset service dns forwarding options "dhcp-boot=tag:efi64-1,netboot.xyz.efi,,SERVERIP"[0m
  [38;2;255;255;255mset service dns forwarding options "dhcp-match=set:efi64-2,60,PXEClient:Arch:00009"[0m
  [38;2;255;255;255mset service dns forwarding options "dhcp-boot=tag:efi64-2,netboot.xyz.efi,,SERVERIP"[0m
  [38;2;255;255;255mcommit; save[0m
  [38;2;255;255;255m```[0m

  File: [1m./kb/networking/mikrotik.md[0m
  [38;2;255;255;255m---[0m
  [38;2;255;255;255mid: mikrotik[0m
  [38;2;255;255;255mtitle: "Mikrotik RouterOS"[0m
  [38;2;255;255;255mdescription: Mikrotik RouterOS Usage[0m
  [38;2;255;255;255mhide[0m[38;2;233;192;98m_table_[0m[38;2;255;255;255mof_contents: true[0m
  [38;2;255;255;255m---[0m
  
  [38;2;254;220;197m### Assumptions[0m
  
  [38;2;255;255;255m- You are running RouterOS 7.12.1 or later[0m
  [38;2;255;255;255m- You have a DHCP server, whose name you will substitute in instead of DHCPSERVER[0m
  [38;2;255;255;255m- You have a DHCP address pool whose name you will substitute in instead of DHCPPOOL[0m
  
  [38;2;255;255;255mThe steps referencing servers and pools can be repeated for as many servers and pools as you need.[0m
  
  [38;2;254;220;197m### Disable BOOTP support for the server[0m
  
  [38;2;255;255;255m```[0m
  [38;2;255;255;255m/ip dhcp-server/set DHCPSERVER bootp-support=none[0m
  [38;2;255;255;255m```[0m
  
  [38;2;254;220;197m### BIOS[0m
  
  [38;2;255;255;255mDownload `netboot.xyz.kpxe` and register it to the TFTP server:[0m
  
  [38;2;255;255;255m```[0m
  [38;2;255;255;255m/tool fetch url="https://boot.netboot.xyz/ipxe/netboot.xyz.kpxe"[0m
  [38;2;255;255;255m/ip tftp add req-filename=netboot.xyz.kpxe real-filename=netboot.xyz.kpxe allow=yes read-only=yes[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mAdd a DHCP option for the BIOS bootfile and add it to a BIOS PXE boot option set:[0m
  
  [38;2;255;255;255m```[0m
  [38;2;255;255;255m/ip dhcp-server option add code=67 name=pxe-bios-netboot.xyz value="'netboot.xyz.kpxe'"[0m
  [38;2;255;255;255m/ip dhcp-server/option/sets add name="pxe-bios" options=pxe-bios-netboot.xyz [0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mSet the BIOS PXE boot option set as the server's option set.[0m
  
  [38;2;255;255;255m```[0m
  [38;2;255;255;255m/ip dhcp-server/set DHCPSERVER dhcp-option-set=pxe-bios[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mNOTE: If you have an existing option set, you should skip creating a new option set and should instead add the PXE BIOS bootfile option to your existing option set.[0m
  
  [38;2;254;220;197m### UEFI[0m
  
  [38;2;255;255;255mDownload `netboot.xyz.efi` and register it to the TFTP server:[0m
  
  [38;2;255;255;255m```[0m
  [38;2;255;255;255m/tool fetch url="https://boot.netboot.xyz/ipxe/netboot.xyz.efi"[0m
  [38;2;255;255;255m/ip tftp add req-filename=netboot.xyz.efi real-filename=netboot.xyz.efi allow=yes read-only=yes[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mAdd a DHCP option for the UEFI bootfile and add it to a UEFI PXE boot option set:[0m
  
  [38;2;255;255;255m```[0m
  [38;2;255;255;255m/ip dhcp-server option add code=67 name=pxe-uefi-netboot.xyz value="'netboot.xyz.efi'"[0m
  [38;2;255;255;255m/ip dhcp-server/option/sets add name="pxe-uefi" options=pxe-uefi-netboot.xyz [0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mAdd a DHCP matcher that looks for the 0x0007 (x86-64 UEFI) architecture type and applies the PXE UEFI option set, overriding the default PXE BIOS options:[0m
  
  [38;2;255;255;255m```[0m
  [38;2;255;255;255m/ip dhcp-server/matcher/add name="pxe-uefi-matcher" server=DHCPSERVER address-pool=DHCPPOOL option-set=pxe-uefi code=93 value="0x0007"[0m
  [38;2;255;255;255m```[0m

  File: [1m./kb/providers/digitalocean.md[0m
  [38;2;255;255;255m---[0m
  [38;2;255;255;255mid: digitalocean[0m
  [38;2;255;255;255mtitle: DigitalOcean[0m
  [38;2;255;255;255mdescription: Using netboot.xyz on DigitalOcean[0m
  [38;2;255;255;255mhide[0m[38;2;233;192;98m_table_[0m[38;2;255;255;255mof_contents: true[0m
  [38;2;255;255;255m---[0m
  
  [38;2;255;255;255mnetboot.xyz can be loaded on a [[0m[38;2;204;255;102mDigitalOcean[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://m.do.co/c/ab4e8f17ba0d[0m[38;2;255;255;255m) droplet with a little bit of work so that you can then customize the droplet as needed. For this method, we'll use the smallest droplet size running Debian.[0m
  
  [38;2;255;255;255m:::info[0m
  [38;2;255;255;255mIf you haven't signed up for a DigitalOcean account, please utilize our affiliate link [[0m[38;2;204;255;102mhere[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://m.do.co/c/ab4e8f17ba0d[0m[38;2;255;255;255m). It will help provide us testing resources for improving this project![0m
  [38;2;255;255;255m:::[0m
  
  [38;2;254;220;197m### Create a Droplet[0m
  
  [38;2;255;255;255mFor this method, it's recommended to use an apt-based distro like Debian or Ubuntu. Start a droplet with one of those operating systems. Once it is up and running, connect to it via SSH or connect to it with the console button.[0m
  
  [38;2;254;220;197m### Install GRUB Imageboot and Download ISO[0m
  
  [38;2;255;255;255mWe will need to ensure that the GRUB menu pauses long enough for us to select the netboot.xyz option. For that we'll need to remove a timeout file and increase the timeout for GRUB. Adjust the time period as needed for your[0m
  [38;2;255;255;255msituation:[0m
  
  [38;2;255;255;255m```shell[0m
  [38;2;254;220;197m# Remove grub timeout configuration[0m
  [38;2;255;255;255mrm /etc/default/grub.d/15_timeout.cfg[0m
  
  [38;2;254;220;197m# Increase grub timeout if desired[0m
  [38;2;255;255;255msed -i 's/GRUB[0m[38;2;233;192;98m_TIMEOUT=5/GRUB_[0m[38;2;255;255;255mTIMEOUT=60/g' /etc/default/grub[0m
  
  [38;2;254;220;197m# Install grub-imageboot[0m
  [38;2;255;255;255mapt update[0m
  [38;2;255;255;255mapt install -y grub-imageboot[0m
  
  [38;2;254;220;197m# Download netboot.xyz ISO[0m
  [38;2;255;255;255mmkdir /boot/images[0m
  [38;2;255;255;255mcd /boot/images[0m
  [38;2;255;255;255mwget https://boot.netboot.xyz/ipxe/netboot.xyz.iso[0m
  
  [38;2;254;220;197m# Update GRUB menu to include this ISO[0m
  [38;2;255;255;255mupdate-grub2[0m
  
  [38;2;254;220;197m# reboot once you are ready, it may be good to load up the recovery console first[0m
  [38;2;255;255;255mreboot[0m
  [38;2;255;255;255m```[0m
  
  [38;2;254;220;197m### Connect via Recovery Console[0m
  
  [38;2;255;255;255mUnder the access section, connect to the Recovery Console. The recovery console is different from the regular console command in that it allows direct access to the droplet as it boots, including access to the GRUB menu.[0m
  [38;2;255;255;255mAt this point if you are within the timeout window, you should now see the Grub menu with the following option now available:[0m
  
  [38;2;255;255;255m```bash[0m
  [38;2;255;255;255mBootable ISO image: netboot.xyz[0m
  [38;2;255;255;255m```[0m
  
  [38;2;254;220;197m### Set Networking Up[0m
  
  [38;2;255;255;255mBecause the droplets use a static IP instead of DHCP, you will need to set up the networking for iPXE to talk to the networking. Upon selecting the netboot.xyz option, press [0m[1;38;2;233;192;98m**m**[0m[38;2;255;255;255m when prompted for the failsafe menu. You will need to set the networking of the instance so that iPXE can get on-line. You can get the networking information from the droplet control panel from the networking tab. Once you have the networking information, select Manual networking configuration:[0m
  
  [38;2;255;255;255m```bash[0m
  [38;2;255;255;255mSet network interface number [0 for net0, defaults to 0]: <set to 0>[0m
  [38;2;255;255;255mIP: <set to droplet IP>[0m
  [38;2;255;255;255mSubnet mask: <set to droplet netmask>[0m
  [38;2;255;255;255mGateway: <set to droplet gateway>[0m
  [38;2;255;255;255mDNS: <set DNS server, e.g. 1.1.1.1>[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mOnce set, you should connect right into netboot.xyz. If you do a installation, you should be able to reinstall over the existing drive at that point and customize the droplet as you see fit. Keep the networking information handy as you will need to populate that when doing an install.[0m
  
  [38;2;255;255;255m:::info[0m
  [38;2;255;255;255mIf you run into out of memory issues running an installer, you may need a larger droplet.[0m
  [38;2;255;255;255m:::[0m

  File: [1m./kb/providers/equinixmetal.md[0m
  [38;2;255;255;255m---[0m
  [38;2;255;255;255mid: equinixmetal[0m
  [38;2;255;255;255mtitle: Equinix Metal[0m
  [38;2;255;255;255mdescription: Using netboot.xyz with Equinix Metal bare metal servers[0m
  [38;2;255;255;255mhide[0m[38;2;233;192;98m_table_[0m[38;2;255;255;255mof_contents: true[0m
  [38;2;255;255;255m---[0m
  
  [38;2;255;255;255m[[0m[38;2;204;255;102mEquinix Metal[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://metal.equinix.com[0m[38;2;255;255;255m) fully supports netboot.xyz with its Custom iPXE[0m
  [38;2;255;255;255moperating system.[0m
  
  [38;2;254;220;197m### Usage[0m
  
  [38;2;255;255;255mSelect the "Custom iPXE" operating system from the portal, or the `custom_ipxe`[0m
  [38;2;255;255;255mslug when using the API.[0m
  
  [38;2;254;220;197m### Provisioning[0m
  
  [38;2;255;255;255mPut the netboot.xyz URL in the text field that appears in the portal, or use the[0m
  [38;2;255;255;255m`ipxe[0m[38;2;233;192;98m_script_[0m[38;2;255;255;255murl` parameter when creating the device via the API.[0m
  
  [38;2;255;255;255m```[0m
  [38;2;255;255;255mhttps://boot.netboot.xyz[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mPress "Deploy" to provision your device. It will take 2-3 minutes for the device[0m
  [38;2;255;255;255mto become active. Once it's online, connect to Equinix Metal's out-of-band[0m
  [38;2;255;255;255mserial-over-SSH service (S.O.S.) using the device's `id` and the facility where[0m
  [38;2;255;255;255mthe device was deployed, e.g. `ewr1`.[0m
  
  [38;2;255;255;255m```[0m
  [38;2;255;255;255mssh {server-uuid}@sos.{facility-code}.platformequinix.com[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mThe current list of facilities is [[0m[38;2;204;255;102mhere[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://metal.equinix.com/product/locations[0m[38;2;255;255;255m). The[0m
  [38;2;255;255;255mnetboot.xyz iPXE menu will appear and you can complete installation from there.[0m
  
  [38;2;255;255;255m:::note[0m
  
  [38;2;255;255;255mBy default, devices are set to boot from the local disk. During[0m
  [38;2;255;255;255mprovisioning, Equinix Metal sets the next boot to PXE. This happens once, which means that[0m
  [38;2;255;255;255mif you don't install an operating system before rebooting, it won't reload the[0m
  [38;2;255;255;255mnetboot.xyz menu. However, you can set your device to always boot to iPXE[0m
  [38;2;255;255;255mfirst by enabling that option under 'server actions' through the customer portal.[0m
  
  [38;2;255;255;255m:::[0m
  
  [38;2;254;220;197m### Networking[0m
  
  [38;2;255;255;255mDevices that are provisioned via Custom iPXE will be able to DHCP for the life of[0m
  [38;2;255;255;255mthe device; however, Equinix Metal recommends configuring networking statically. IP[0m
  [38;2;255;255;255maddress information can be found by querying https://metadata.platformequinix.com/metadata[0m
  [38;2;255;255;255mfrom the host.[0m
  
  [38;2;255;255;255mMore information on how Equinix Metal configures bonding can be found[0m
  [38;2;255;255;255m[[0m[38;2;204;255;102mhere[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://metal.equinix.com/developers/docs/networking/layer2/[0m[38;2;255;255;255m).[0m
  
  [38;2;255;255;255mNameservers should be configured as:[0m
  
  [38;2;255;255;255m```[0m
  [38;2;255;255;255mnameserver 147.75.207.207[0m
  [38;2;255;255;255mnameserver 147.75.207.208[0m
  [38;2;255;255;255m```[0m

  File: [1m./kb/providers/gce.md[0m
  [38;2;255;255;255m---[0m
  [38;2;255;255;255mid: gce[0m
  [38;2;255;255;255mtitle: Google Compute Engine[0m
  [38;2;255;255;255mdescription: Using netboot.xyz on Google Compute Engine[0m
  [38;2;255;255;255mhide[0m[38;2;233;192;98m_table_[0m[38;2;255;255;255mof_contents: true[0m
  [38;2;255;255;255m---[0m
  
  [38;2;254;220;197m## Using with netboot.xyz[0m
  
  [1;38;2;233;192;98m**Experimental, currently doesn't work on any images that utilize memdisk as console output cannot be altered.**[0m
  
  [38;2;255;255;255m*Note: Functionality will be limited as the console is Serial Over Lan.  Distros that utilize memdisk may not provide output while other distros that are retrieved via kernel allow for altering of the console settings during load.  This includes most of the utility tools.  I'll probably look at filtering out options that don't work in the future.  Console may work during the install but may stop working on first boot if it's not set during the install.*[0m
  
  [38;2;254;220;197m### Create a Bucket[0m
  
  [38;2;255;255;255mSet a name for your bucket and select the regional storage class.[0m
  
  [38;2;255;255;255mUpload the netboot.xyz-gce image from this [[0m[38;2;204;255;102mlink[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://boot.netboot.xyz/ipxe/netboot.xyz-gce.tar.gz[0m[38;2;255;255;255m) to the root of your bucket.[0m
  
  [38;2;255;255;255m```[0m
  [38;2;255;255;255mgsutil cp $tmp/$image[0m[38;2;233;192;98m_name.tar.gz gs://$gs_[0m[38;2;255;255;255mbucket[0m
  [38;2;255;255;255m```[0m
  
  [38;2;254;220;197m### Create an image[0m
  
  [38;2;255;255;255mUsing the gcloud utility or the Google Cloud Shell, create an image from the iPXE disk you uploaded in the previous step:[0m
  
  [38;2;255;255;255m```[0m
  [38;2;255;255;255mgcloud compute images create $image[0m[38;2;233;192;98m_name --source-uri gs://$gs_[0m[38;2;255;255;255mbucket/$image_name.tar.gz[0m
  [38;2;255;255;255m```[0m
  
  [38;2;254;220;197m### Boot an instance[0m
  
  [38;2;255;255;255mStart an instance from the image you created, make sure to enable the serial-port:[0m
  
  [38;2;255;255;255m```[0m
  [38;2;255;255;255mgcloud compute instances create $instance[0m[38;2;233;192;98m_name --image $image_[0m[38;2;255;255;255mname --metadata serial-port-enable=1[0m
  [38;2;255;255;255m```[0m
  
  [38;2;254;220;197m### Connect to the Instance over Serial Console[0m
  
  [38;2;255;255;255m```[0m
  [38;2;255;255;255mgcloud beta compute connect-to-serial-port $instance_name[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mFrom here you should see the netboot.xyz menu and that's probably all you'll be able to do at this point. :)[0m
  
  [38;2;254;220;197m### Configuring the Instance[0m
  
  [38;2;255;255;255mIn the event DHCP does not work, you'll need to set the static IP address during install time.  You can view this by going into instance details in the console, and clicking on default under network.  You'll need to set the internal IP of the instance along with the subnet and gateway on that page.[0m
  
  [38;2;254;220;197m### Notes[0m
  
  [38;2;255;255;255mHere are some notes on how the iPXE image is created in case you want to play around with vanilla iPXE in GCE.[0m
  
  [38;2;255;255;255mSee the iPXE commit [[0m[38;2;204;255;102mhere[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://github.com/ipxe/ipxe/commit/de85336abb7861e4ea4df2e296eb33d179c7c9bd[0m[38;2;255;255;255m) for more info of GCE support in iPXE.[0m
  
  [38;2;255;255;255mTo create a usable image for GCE:[0m
  
  [38;2;255;255;255m```[0m
  [38;2;255;255;255mmake bin/ipxe.usb CONFIG=cloud EMBED=$tmp/main.ipxe[0m
  [38;2;255;255;255mcp -f bin/ipxe.usb $tmp/disk.raw[0m
  [38;2;255;255;255m( cd $tmp; tar Sczvf $image_name.tar.gz disk.raw )[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mTo get the installers to work to output serial, when the GCE disk is detected, the console on the kernel command line is set to:[0m
  
  [38;2;255;255;255m```[0m
  [38;2;255;255;255mconsole=ttyS0,115200n8[0m
  [38;2;255;255;255m```[0m
  
  [38;2;254;220;197m## Using without netboot.xyz (standard iPXE)[0m
  
  [38;2;255;255;255mWhen building your script, you will want it to look something like this:[0m
  
  [38;2;255;255;255m```[0m
  [38;2;255;255;255m#!ipxe[0m
  [38;2;255;255;255mecho Google Compute Engine - iPXE boot via metadata[0m
  [38;2;255;255;255mifstat ||[0m
  [38;2;255;255;255mdhcp ||[0m
  [38;2;255;255;255mroute ||[0m
  [38;2;255;255;255mchain -ar http://metadata.google.internal/computeMetadata/v1/instance/attributes/ipxeboot[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mThen when provisioning your instance, you can specify your custom iPXE script file:[0m
  
  [38;2;255;255;255m```[0m
  [38;2;254;220;197m# Create shared boot image[0m
  [38;2;255;255;255mmake bin/ipxe.usb CONFIG=cloud EMBED=config/cloud/gce.ipxe[0m
  [38;2;254;220;197m# Configure per-instance boot script[0m
  [38;2;255;255;255mgcloud compute instances add-metadata <instance> \[0m
  [38;2;255;255;255m       --metadata-from-file ipxeboot=boot.ipxe[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mThis lets your custom compiled iPXE boot and then immediately chain to your[0m
  [38;2;255;255;255mcustom iPXE script.[0m

  File: [1m./kb/providers/linode.md[0m
  [38;2;255;255;255m---[0m
  [38;2;255;255;255mid: linode[0m
  [38;2;255;255;255mtitle: Linode[0m
  [38;2;255;255;255mdescription: Using netboot.xyz on Linode[0m
  [38;2;255;255;255mhide[0m[38;2;233;192;98m_table_[0m[38;2;255;255;255mof_contents: true[0m
  [38;2;255;255;255m---[0m
  
  [38;2;255;255;255mnetboot.xyz can be loaded on a [[0m[38;2;204;255;102mLinode[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://linode.com[0m[38;2;255;255;255m) instance so that you can then customize the Linode as needed. For this method, we'll use the smallest Linode size running Debian.[0m
  
  [38;2;254;220;197m### Create a Linode[0m
  
  [38;2;255;255;255mFor this method, it's recommended to use an apt-based distro like Debian or Ubuntu. Start a Linode with one of those operating systems. Once it is up and running, connect to it via SSH or connect to it with the console button.[0m
  
  [38;2;254;220;197m### Install GRUB Imageboot and Download ISO[0m
  
  [38;2;255;255;255mWe will need to ensure that the GRUB menu pauses long enough for us to select the netboot.xyz option. For that we'll need to remove a timeout file and increase the timeout for GRUB. Adjust the time period as needed for your[0m
  [38;2;255;255;255msituation:[0m
  
  [38;2;255;255;255m```shell[0m
  [38;2;254;220;197m# Increase grub timeout if desired[0m
  [38;2;255;255;255msed -i 's/GRUB[0m[38;2;233;192;98m_TIMEOUT=5/GRUB_[0m[38;2;255;255;255mTIMEOUT=60/g' /etc/default/grub[0m
  
  [38;2;254;220;197m# Install grub-imageboot[0m
  [38;2;255;255;255mapt update[0m
  [38;2;255;255;255mapt install -y grub-imageboot[0m
  
  [38;2;254;220;197m# Download netboot.xyz ISO[0m
  [38;2;255;255;255mmkdir /boot/images[0m
  [38;2;255;255;255mcd /boot/images[0m
  [38;2;255;255;255mwget https://boot.netboot.xyz/ipxe/netboot.xyz.iso[0m
  
  [38;2;254;220;197m# Update GRUB menu to include this ISO[0m
  [38;2;255;255;255mupdate-grub2[0m
  
  [38;2;254;220;197m# reboot once you are ready, it may be good to load up the recovery console first[0m
  [38;2;255;255;255mreboot[0m
  [38;2;255;255;255m```[0m
  
  [38;2;254;220;197m### Launch LISH Console[0m
  
  [38;2;255;255;255mUnder the Linode settings click ..., and select Launch LISH Console. For interraction with the GRUB Menu and netboot.xyz menus, you will need to click the Weblish tab. For interacting with an installer or other tool, you may need to use the Glish tab (Graphical).[0m
  
  [38;2;255;255;255mAt this point if you are within the timeout window, you should now see the Grub menu with the following option now available which you can select to load the netwboot.xyz menu:[0m
  
  [38;2;255;255;255m```bash[0m
  [38;2;255;255;255mBootable ISO image: netboot.xyz[0m
  [38;2;255;255;255m```[0m
  
  [38;2;254;220;197m### Networking[0m
  
  [38;2;255;255;255mLinode uses DHCP so netboot.xyz should be able to get an IP address and load up the menu. If DHCP does not work, you may need to use the alternative failsafe menu to set up the networking for the instance manually by pressing [0m[1;38;2;233;192;98m**m**[0m[38;2;255;255;255m when prompted for the failsafe menu.[0m
  
  [38;2;255;255;255mIf you do a installation, you should be able to reinstall over the existing drive at that point and customize the Linode as you see fit. Keep the networking information handy as you will need to populate that when doing an install. [0m
  
  [38;2;255;255;255m:::info[0m
  [38;2;255;255;255mIf you run into out of memory issues running an installer, you may need a larger Linode.[0m
  [38;2;255;255;255m:::[0m

  File: [1m./kb/providers/oci.md[0m
  [38;2;255;255;255m---[0m
  [38;2;255;255;255mid: oci[0m
  [38;2;255;255;255mtitle: Oracle Cloud Infrastructure[0m
  [38;2;255;255;255mdescription: Using netboot.xyz on Oracle Cloud Infrastructure[0m
  [38;2;255;255;255mhide[0m[38;2;233;192;98m_table_[0m[38;2;255;255;255mof_contents: true[0m
  [38;2;255;255;255m---[0m
  
  [38;2;255;255;255mnetboot.xyz can be loaded on [[0m[38;2;204;255;102mOCI[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://www.oracle.com/cloud/[0m[38;2;255;255;255m) compute instances so that you can then customize the compute instance as needed.[0m
  
  [38;2;255;255;255mFor this method, we'll use the standard Ubuntu image for the relevant architecture.[0m
  
  [38;2;254;220;197m### Create a compute instance[0m
  [38;2;255;255;255mWhen creating an instance, make sure to select:[0m
  [38;2;255;255;255m- Image: Ubuntu > Canonical Ubuntu (standard, not minimal)[0m
  
  [38;2;255;255;255mTake note of which shape you take, as it will determine further steps:[0m
  [38;2;255;255;255m- AMD (`x86_64`)[0m
  [38;2;255;255;255m- Ampere A1 (`arm64`)[0m
  
  [38;2;255;255;255m:::warning[0m
  [38;2;255;255;255mSet up SSH keys![0m
  [38;2;255;255;255mYou will need to log into the server and there is no default password.[0m
  
  [38;2;255;255;255mWe assume you know how to use SSH keys.[0m
  [38;2;255;255;255m:::[0m
  
  [38;2;254;220;197m### Get into the rescue shell[0m
  [38;2;255;255;255mFirst get onto your compute instance's details page, then scroll down to `Resources` under which you'll find `Console connection`.[0m
  
  [38;2;255;255;255mTo get into the rescue shell, we recommend you use the Cloud Shell, and not bother with a `local connection`. To do so, click on `Launch Cloud Shell connection` and wait for the console connection status to reach the `ACTIVE` state. Be patient, it can take a minute or two.[0m
  
  [38;2;255;255;255mYou do not need to log in, as we'll only use it control the UEFI Firmware.[0m
  
  [38;2;254;220;197m### Download the EFI binary, Setup GRUB and Reboot into UEFI[0m
  
  [38;2;255;255;255mNow that you have the rescue shell open, you need to open a SSH connection to entere the following commands, as there is no default password.[0m
  
  [38;2;255;255;255mFollow the instructions depending on which architecture/shape you chose earlier: `arm64` or `x86_64`.[0m
  
  [38;2;255;255;255m:::info[0m
  [38;2;255;255;255mThe rescue shell over the Oracle Cloud Shell can be somewhat buggy, for instance, you might have to press the Escape key twice instead of only once when in netboot.xyz[0m
  [38;2;255;255;255m:::[0m
  
  [38;2;254;220;197m#### `arm64` - Ampere A1[0m
  [38;2;255;255;255mThese steps apply to the Ampere A1 (`arm64`) instances.[0m
  
  [38;2;255;255;255mThe default GRUB configuration already contains the `UEFI Firmware` option, so we only have to download netboot.xyz and reboot into the correct option.[0m
  
  [38;2;255;255;255m```shell[0m
  [38;2;254;220;197m# Download netboot (arm64) into the EFI directory[0m
  [38;2;255;255;255msudo wget -O /boot/efi/netboot.xyz-arm64.efi https://boot.netboot.xyz/ipxe/netboot.xyz-arm64.efi[0m
  
  [38;2;254;220;197m# Set the default boot entry (for the following boot only) to the UEFI firmware[0m
  [38;2;255;255;255msudo grub-reboot "UEFI Firmware Settings"[0m
  
  [38;2;254;220;197m# Reboot the instance[0m
  [38;2;255;255;255msudo reboot[0m
  [38;2;255;255;255m```[0m
  
  [38;2;254;220;197m#### `x86_64` - AMD[0m
  [38;2;255;255;255mThese steps apply to the AMD/Intel (`x86_64`) instances.[0m
  
  [38;2;255;255;255mWe need to delete the default GRUB configuration and regenerate it, as it does not contain `UEFI Firmware`. Then, we can reboot into the UEFI Firmware and boot into netboot.xyz:[0m
  
  [38;2;255;255;255m```shell[0m
  [38;2;254;220;197m# Download netboot (amd64) into the EFI directory[0m
  [38;2;255;255;255msudo wget -O /boot/efi/netboot.xyz-snp.efi https://boot.netboot.xyz/ipxe/netboot.xyz-snp.efi[0m
  
  [38;2;254;220;197m# Delete the default configuration (does not contain UEFI Firmware by default)[0m
  [38;2;255;255;255msudo rm -rf /etc/default/grub /etc/default/grub.d/[0m
  
  [38;2;254;220;197m# Update GRUB menu (with default configuration)[0m
  [38;2;255;255;255msudo update-grub[0m
  
  [38;2;254;220;197m# Set the default boot entry (for the following boot only) to the UEFI firmware[0m
  [38;2;255;255;255msudo grub-reboot "UEFI Firmware Settings"[0m
  
  [38;2;254;220;197m# Reboot[0m
  [38;2;255;255;255msudo reboot[0m
  [38;2;255;255;255m```[0m
  
  [38;2;254;220;197m### Boot into netboot.xyz[0m
  [38;2;255;255;255mNow that you are in the UEFI Firmware, do the following:[0m
  [38;2;255;255;255m- Choose “Boot Maintenance Manager”[0m
  [38;2;255;255;255m- Choose “Boot From File”[0m
  [38;2;255;255;255m- Choose the only device[0m
  [38;2;255;255;255m- Choose the netboot.xyz EFI file[0m
  [38;2;255;255;255m- Wait for it to start and configure[0m
  
  [38;2;255;255;255m:::tip[0m
  [38;2;255;255;255mIf you were not able to boot into netboot.xyz correctly, simple repeat the `grub-reboot` and `reboot` steps to enter UEFI again.[0m
  [38;2;255;255;255m:::[0m
  
  [38;2;254;220;197m#### `x86_64` - Console quirks: Linux[0m
  [38;2;255;255;255mOnce you have booted into netboot.xyz on `x86_64`, if you plan on using Linux images, you must still set up custom `Kernel cmdline params` under `Utilities (UEFI)`.[0m
  
  [38;2;255;255;255mSet `Kernel cmdline params: []` to `console=ttyS0,9600`.[0m
  
  [38;2;255;255;255mIf you make a mistake, move with arrow keys, and use the Delete key.[0m
  
  [38;2;255;255;255mOnce you have typed it in, you might have to press the Escape key twice.[0m
  
  [38;2;255;255;255m:::warning[0m
  [38;2;255;255;255mThis is [0m[1;38;2;233;192;98m**not**[0m[38;2;255;255;255m applicable to `arm64`/Ampere A1.[0m
  [38;2;255;255;255m:::[0m

  File: [1m./kb/providers/openstack.md[0m
  [38;2;255;255;255m---[0m
  [38;2;255;255;255mid: openstack[0m
  [38;2;255;255;255mtitle: "OpenStack"[0m
  [38;2;255;255;255mdescription: "Using netboot.xyz with OpenStack"[0m
  [38;2;255;255;255mhide[0m[38;2;233;192;98m_table_[0m[38;2;255;255;255mof_contents: true[0m
  [38;2;255;255;255m---[0m
  
  [1;38;2;233;192;98m**Experimental, haven't had a chance to run through this recently so YMMV.**[0m
  
  [38;2;255;255;255mThe netboot.xyz ISO image can be used with OpenStack clouds to boot an instance[0m
  [38;2;255;255;255mand perform a custom installation of an operating system.[0m
  
  [38;2;254;220;197m### Command line[0m
  
  [38;2;255;255;255mStart by downloading the ISO and then import it into glance:[0m
  
  [38;2;255;255;255m```[0m
  [38;2;255;255;255m$ wget https://boot.netboot.xyz/ipxe/netboot.xyz.iso[0m
  [38;2;255;255;255m$ glance image-create --name netboot.xyz \[0m
  [38;2;255;255;255m    --disk-format iso \[0m
  [38;2;255;255;255m    --container-format bare \[0m
  [38;2;255;255;255m    --file netboot.xyz-dhcp.iso \[0m
  [38;2;255;255;255m    --visibility public[0m
  [38;2;255;255;255m+------------------+--------------------------------------+[0m
  [38;2;255;255;255m| Property         | Value                                |[0m
  [38;2;255;255;255m+------------------+--------------------------------------+[0m
  [38;2;255;255;255m| checksum         | 45cdcb89576b6c05598b11585aef46bc     |[0m
  [38;2;255;255;255m| container_format | bare                                 |[0m
  [38;2;255;255;255m| created_at       | 2016-01-27T20:02:06Z                 |[0m
  [38;2;255;255;255m| disk_format      | iso                                  |[0m
  [38;2;255;255;255m| id               | 4f11d49e-157b-4740-87ad-db7d59bb5d6d |[0m
  [38;2;255;255;255m| min_disk         | 0                                    |[0m
  [38;2;255;255;255m| min_ram          | 0                                    |[0m
  [38;2;255;255;255m| name             | netboot.xyz                          |[0m
  [38;2;255;255;255m| owner            | fbfce4cb346c4f9097a977c54904cafd     |[0m
  [38;2;255;255;255m| protected        | False                                |[0m
  [38;2;255;255;255m| size             | 1048576                              |[0m
  [38;2;255;255;255m| status           | active                               |[0m
  [38;2;255;255;255m| tags             | []                                   |[0m
  [38;2;255;255;255m| updated_at       | 2016-01-27T20:02:04Z                 |[0m
  [38;2;255;255;255m| virtual_size     | None                                 |[0m
  [38;2;255;255;255m| visibility       | public                               |[0m
  [38;2;255;255;255m+------------------+--------------------------------------+[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mIt should only take a few seconds to import.  Take the UUID from the `id` field[0m
  [38;2;255;255;255mreturned by glance and verify that the image imported successfully:[0m
  
  [38;2;255;255;255m```[0m
  [38;2;255;255;255m$ glance image-show 4f11d49e-157b-4740-87ad-db7d59bb5d6d[0m
  [38;2;255;255;255m+------------------+--------------------------------------+[0m
  [38;2;255;255;255m| Property         | Value                                |[0m
  [38;2;255;255;255m+------------------+--------------------------------------+[0m
  [38;2;255;255;255m| checksum         | 45cdcb89576b6c05598b11585aef46bc     |[0m
  [38;2;255;255;255m| container_format | bare                                 |[0m
  [38;2;255;255;255m| created_at       | 2016-01-27T20:02:06Z                 |[0m
  [38;2;255;255;255m| disk_format      | iso                                  |[0m
  [38;2;255;255;255m| id               | 4f11d49e-157b-4740-87ad-db7d59bb5d6d |[0m
  [38;2;255;255;255m| min_disk         | 0                                    |[0m
  [38;2;255;255;255m| min_ram          | 0                                    |[0m
  [38;2;255;255;255m| name             | netboot.xyz                          |[0m
  [38;2;255;255;255m| owner            | fbfce4cb346c4f9097a977c54904cafd     |[0m
  [38;2;255;255;255m| protected        | False                                |[0m
  [38;2;255;255;255m| size             | 1048576                              |[0m
  [38;2;255;255;255m| status           | active                               |[0m
  [38;2;255;255;255m| tags             | []                                   |[0m
  [38;2;255;255;255m| updated_at       | 2016-01-27T20:02:04Z                 |[0m
  [38;2;255;255;255m| virtual_size     | None                                 |[0m
  [38;2;255;255;255m| visibility       | public                               |[0m
  [38;2;255;255;255m+------------------+--------------------------------------+[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mThe image has a status of `active`, so we know that glance imported it[0m
  [38;2;255;255;255mproperly.[0m
  
  [38;2;255;255;255mLet's boot a new instance with this ISO:[0m
  
  [38;2;255;255;255m```[0m
  [38;2;255;255;255mnova boot --flavor m1.small \[0m
  [38;2;255;255;255m    --image <image-uuid-of-netbootxyz-image> \[0m
  [38;2;255;255;255m    --nic net-id=<network-uuid> \[0m
  [38;2;255;255;255m    netbootxyz-testing[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mWait about 30 seconds, then request a console URL:[0m
  
  [38;2;255;255;255m```[0m
  [38;2;255;255;255mnova get-spice-console c4ff017e-1234-4053-b740-e83eade277b9 spice-html5[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mOpen the console URL that nova returns and you should see the familiar[0m
  [38;2;255;255;255mnetboot.xyz iPXE interface in the spice console![0m
  
  [38;2;254;220;197m### Horizon[0m
  
  [38;2;255;255;255mStart by [[0m[38;2;204;255;102mdownloading the netboot.xyz ISO[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://boot.netboot.xyz/ipxe/netboot.xyz.iso[0m[38;2;255;255;255m)[0m
  [38;2;255;255;255mto your local workstation.  Follow these steps to import the image into your[0m
  [38;2;255;255;255mOpenStack cloud using Horizon:[0m
  
  [38;2;255;255;255m* Click the [0m[38;2;233;192;98m_Compute_[0m[38;2;255;255;255m tab on the left side, then click [0m[38;2;233;192;98m_Images_[0m
  [38;2;255;255;255m* Click [0m[38;2;233;192;98m_Create Image_[0m[38;2;255;255;255m (top right)[0m
  [38;2;255;255;255m  * Name: `netboot.xyz ISO`[0m
  [38;2;255;255;255m  * Image Source: Image File[0m
  [38;2;255;255;255m  * Image File: (browse to the ISO you downloaded)[0m
  [38;2;255;255;255m  * Format: ISO - Optical Disk Image[0m
  [38;2;255;255;255m  * Public: Checked (optional, but recommended if you want other tenants to use[0m
  [38;2;255;255;255m   it)[0m
  [38;2;255;255;255m* Click [0m[38;2;233;192;98m_Create Image_[0m
  
  [38;2;255;255;255mWait a moment for the status to become `active`. This should only take a few[0m
  [38;2;255;255;255mseconds.  To boot an instance with the ISO you uploaded, be sure to choose[0m
  [38;2;233;192;98m_Boot from image_[0m[38;2;255;255;255m and select [0m[38;2;233;192;98m_netboot.xyz ISO_[0m[38;2;255;255;255m from the drop down list.[0m
  [38;2;255;255;255mConfigure networking and security groups as you normally would for any other[0m
  [38;2;255;255;255minstance.[0m
  
  [38;2;255;255;255mWhen the instance has fully built and gone to active status, click on the[0m
  [38;2;255;255;255minstance name and then go to the [0m[38;2;233;192;98m_Console_[0m[38;2;255;255;255m tab. Depending on your browser,[0m
  [38;2;255;255;255myou may need to click the link to show only the console.[0m
  
  [38;2;255;255;255mAt that point, you should be able to view the netboot.xyz iPXE menu and install[0m
  [38;2;255;255;255myour operating system.[0m

  File: [1m./kb/providers/vultr.md[0m
  [38;2;255;255;255m---[0m
  [38;2;255;255;255mid: vultr[0m
  [38;2;255;255;255mtitle: "Vultr"[0m
  [38;2;255;255;255mdescription: "Using netboot.xyz with Vultr"[0m
  [38;2;255;255;255mhide[0m[38;2;233;192;98m_table_[0m[38;2;255;255;255mof_contents: true[0m
  [38;2;255;255;255m---[0m
  
  [38;2;255;255;255m[[0m[38;2;204;255;102mVultr[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttp://www.vultr.com/?ref=6870843[0m[38;2;255;255;255m) has some great support for using[0m
  [38;2;255;255;255mnetboot.xyz right out of the box.[0m
  
  [38;2;255;255;255m:::info[0m
  [38;2;255;255;255mIf you have not signed up for a Vultr account yet, please utilize our affiliate link[0m
  [38;2;255;255;255m[[0m[38;2;204;255;102mhere[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttp://www.vultr.com/?ref=6870843[0m[38;2;255;255;255m). It will help provide us testing resources[0m
  [38;2;255;255;255mfor improving this project![0m
  [38;2;255;255;255m:::[0m
  
  [38;2;254;220;197m### Boot from ISO[0m
  
  [38;2;255;255;255mOnce you've logged into the console, select ISOs.  In the remote URLs box,[0m
  [38;2;255;255;255menter in the URL of a netboot.xyz ISO and press upload:[0m
  
  [38;2;255;255;255m    https://boot.netboot.xyz/ipxe/netboot.xyz.iso[0m
  
  [38;2;255;255;255mGo back to the main console screen and press "Deploy New Instance". Follow[0m
  [38;2;255;255;255mthese steps:[0m
  
  [38;2;255;255;255m* Select [0m[38;2;233;192;98m_Custom_[0m[38;2;255;255;255m for the operating system[0m
  [38;2;255;255;255m* Select the ISO you uploaded[0m
  [38;2;255;255;255m* Click [0m[38;2;233;192;98m_Place Order_[0m
  
  [38;2;255;255;255mThe instance should be online in a few minutes.  Once it's online, go to the[0m
  [38;2;255;255;255mmain account page that lists all of your instances.  Click [0m[38;2;233;192;98m_Manage_[0m[38;2;255;255;255m next to the[0m
  [38;2;255;255;255minstance you just launched, and then click [0m[38;2;233;192;98m_View Console_[0m[38;2;255;255;255m under[0m
  [38;2;233;192;98m_Server Actions_[0m[38;2;255;255;255m. When the console appears, you should see the netboot.xyz[0m
  [38;2;255;255;255miPXE menu.[0m
  
  [38;2;255;255;255mWhen you've completed the OS installation, select [0m[38;2;233;192;98m_Custom ISO_[0m[38;2;255;255;255m from the Server[0m
  [38;2;255;255;255mManager page and click [0m[38;2;233;192;98m_Remove ISO_[0m[38;2;255;255;255m.  The ISO will be removed from your[0m
  [38;2;255;255;255minstance and it will reboot.[0m
  
  [38;2;254;220;197m### Boot from iPXE Chain URL[0m
  
  [38;2;255;255;255mUsing an iPXE chain url may be easier for some users.  Follow these steps:[0m
  
  [38;2;255;255;255m* Click [0m[38;2;233;192;98m_Deploy New Instance_[0m
  [38;2;255;255;255m* Select [0m[38;2;233;192;98m_Custom_[0m[38;2;255;255;255m for the operating system[0m
  [38;2;255;255;255m* Select [0m[38;2;233;192;98m_iPXE_[0m[38;2;255;255;255m in the Virtual ISO section[0m
  [38;2;255;255;255m* Set the chain URL to `https://boot.netboot.xyz`[0m
  [38;2;255;255;255m* Click [0m[38;2;233;192;98m_Place Order_[0m
  
  [38;2;255;255;255mThe instance will boot within a few minutes.  Once it boots, you'll have five[0m
  [38;2;255;255;255mminutes to launch a console and choose an option from the netboot.xyz menu:[0m
  
  [38;2;255;255;255m* Go back to your account home page with your instances listed[0m
  [38;2;255;255;255m* Click [0m[38;2;233;192;98m_Manage_[0m[38;2;255;255;255m next to the instance you just launched[0m
  [38;2;255;255;255m* Click [0m[38;2;233;192;98m_View Console_[0m[38;2;255;255;255m in the [0m[38;2;233;192;98m_Server Actions_[0m[38;2;255;255;255m section[0m
  [38;2;255;255;255m* Choose the OS you want to deploy in the netboot.xyz menu[0m
  [38;2;255;255;255m* Complete the OS installation[0m
  
  [38;2;255;255;255mOnce you've finished the installation, reboot the instance as you normally[0m
  [38;2;255;255;255mwould.  Vultr will automatically reboot your virtual machine into the OS you[0m
  [38;2;255;255;255mdeployed.[0m
  
  [38;2;254;220;197m### Boot from iPXE on a Vultr Bare Metal Server[0m
  
  [38;2;255;255;255mOn Vultr Bare Metal, you can find the iPXE options in the iPXE tab in the Server Type section.[0m
  
  [38;2;255;255;255m* Set the chain URL to `https://boot.netboot.xyz`[0m
  
  [38;2;255;255;255mMake sure to use Legacy (PCBIOS) images because Bare Metal does not support EFI at this time.[0m
  [38;2;255;255;255mYou can then load the console up and use the menu from there.[0m

  File: [1m./kb/pxe/ubuntu.md[0m
  [38;2;255;255;255m---[0m
  [38;2;255;255;255mid: ubuntu[0m
  [38;2;255;255;255mtitle: PXE Booting the Ubuntu Installer[0m
  [38;2;255;255;255msidebar_label: Ubuntu[0m
  [38;2;255;255;255mdescription: PXE Booting the Ubuntu Installer[0m
  [38;2;255;255;255mhide[0m[38;2;233;192;98m_table_[0m[38;2;255;255;255mof_contents: true[0m
  [38;2;255;255;255m---[0m
  
  [38;2;254;220;197m## Installer Kernels[0m
  
  [38;2;255;255;255mUbuntu maintains installer kernels that are lightweight way to load the Ubuntu installer and then stream packages over the network as needed. The installer kernels are located at:[0m
  
  [38;2;255;255;255m```bash[0m
  [38;2;254;220;197m# http://archive.ubuntu.com or other ubuntu mirrors[0m
  [38;2;254;220;197m#[0m
  [38;2;254;220;197m# (${version} == xenial, bionic, etc)[0m
  [38;2;254;220;197m# (${arch} == amd64, i386)[0m
  
  [38;2;254;220;197m# original release directory: [0m
  [38;2;254;220;197m# ubuntu/dists/${version}/main/installer-${arch}/current/images/netboot/[0m
  [38;2;254;220;197m# [0m
  [38;2;254;220;197m# updated release directory which contain newer kernels and updates:[0m
  [38;2;254;220;197m# ubuntu/dists/${version}-updates/main/installer-${arch}/current/images/netboot/[0m
  [38;2;254;220;197m#[0m
  [38;2;254;220;197m# kernel filename: linux[0m
  [38;2;254;220;197m# initrd filename: initrd.gz[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mIn order to load them, you'll need use a boot snippet in iPXE similar to:[0m
  
  [38;2;255;255;255m```bash[0m
  [38;2;255;255;255mset install_params auto=true priority=critical[0m
  [38;2;255;255;255mset mirror http://archive.ubuntu.com[0m
  [38;2;255;255;255mset base_dir ubuntu[0m
  [38;2;255;255;255mset ubuntu_version bionic[0m
  [38;2;255;255;255mset arch amd64[0m
  [38;2;255;255;255mset mirrorcfg mirror/suite=${ubuntu_version}[0m
  [38;2;255;255;255mset dir ${mirror}/${base_dir}/dists/${version}/main/installer-${arch}/current/images/netboot[0m
  
  [38;2;255;255;255mkernel ${dir}/linux ${install_params} ${mirrorcfg} -- quiet initrd=initrd.gz[0m
  [38;2;255;255;255minitrd ${dir}/initrd.gz[0m
  [38;2;255;255;255mboot[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mIf you want to use a [[0m[38;2;204;255;102mpreseed[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://help.ubuntu.com/lts/installation-guide/example-preseed.txt[0m[38;2;255;255;255m) url for automation, you can add this to the kernel line:[0m
  
  [38;2;255;255;255m```bash[0m
  [38;2;255;255;255mset preseedurl http://my.preseed.com/preseed.cfg[0m
  [38;2;255;255;255mpreseed/url=${preseedurl}[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mFor more examples you can view the netboot.xyz configuration for Ubuntu [[0m[38;2;204;255;102mhere[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://github.com/netbootxyz/netboot.xyz/blob/master/roles/netbootxyz/templates/menu/ubuntu.ipxe.j2[0m[38;2;255;255;255m).[0m
  
  [38;2;254;220;197m## Live Boot[0m
  
  [38;2;255;255;255mUbuntu also provides a number of Live Boot ISOs that will boot an OS directly into memory and can be used immediately without doing an install or modifying the hard drive.  The Live OS will also include the installer as well.  These are great for evaluating other desktops that you might want to try out without doing a full install.[0m
  
  [38;2;255;255;255m| Distribution | Website |[0m
  [38;2;255;255;255m| :--- | :--- |[0m
  [38;2;255;255;255m| Kubuntu | [[0m[38;2;204;255;102mhttps://kubuntu.org/[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://kubuntu.org/[0m[38;2;255;255;255m) |[0m
  [38;2;255;255;255m| Lubuntu | [[0m[38;2;204;255;102mhttps://lubuntu.me/[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://lubuntu.me/[0m[38;2;255;255;255m) |[0m
  [38;2;255;255;255m| Ubuntu Budgie | [[0m[38;2;204;255;102mhttps://ubuntubudgie.org/[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://ubuntubudgie.org/[0m[38;2;255;255;255m) |[0m
  [38;2;255;255;255m| Ubuntu Kylin | [[0m[38;2;204;255;102mhttps://www.ubuntukylin.com/[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://www.ubuntukylin.com/[0m[38;2;255;255;255m) |[0m
  [38;2;255;255;255m| Ubuntu Mate | [[0m[38;2;204;255;102mhttps://ubuntu-mate.org/[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://ubuntu-mate.org/[0m[38;2;255;255;255m) |[0m
  [38;2;255;255;255m| Ubuntu Studio | [[0m[38;2;204;255;102mhttps://ubuntustudio.org/[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://ubuntustudio.org/[0m[38;2;255;255;255m) |[0m
  [38;2;255;255;255m| Xubuntu | [[0m[38;2;204;255;102mhttps://xubuntu.org/[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://xubuntu.org/[0m[38;2;255;255;255m) |[0m

  File: [1m./kb/pxe/windows.md[0m
  [38;2;255;255;255m---[0m
  [38;2;255;255;255mid: windows[0m
  [38;2;255;255;255mtitle: "Windows"[0m
  [38;2;255;255;255mdescription: "Installing Windows 10 with netboot.xyz"[0m
  [38;2;255;255;255mhide[0m[38;2;233;192;98m_table_[0m[38;2;255;255;255mof_contents: true[0m
  [38;2;255;255;255m---[0m
  
  [38;2;255;255;255mThis is one of the most frequently asked questions, so this deserves its own page.  [0m
  [38;2;255;255;255mThis guide will assume that you're using the linuxserver.io Docker container.[0m
  
  [38;2;254;220;197m#### Requirements[0m
  
  [38;2;255;255;255m- Samba (SMB,CIFS) share with Windows 10 ISO extracted[0m
  [38;2;255;255;255m- Windows PE image as an ISO, instructions on how to build it can be found [[0m[38;2;204;255;102mhere[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/winpe-create-usb-bootable-drive#create-a-winpe-iso-dvd-or-cd[0m[38;2;255;255;255m)[0m
  
  [38;2;255;255;255mStep 1. Download WindowsPE/generate the image and download Windows 10 ISO.  [0m
  [38;2;255;255;255mStep 2. Setup an SMB share with Windows 10 ISO extracted to a directory there.  [0m
  [38;2;255;255;255mStep 3. Upload Windows PE to Linuxserver.io's netboot.xyz container's /assets/WinPE/x64/ folder.  [0m
  [38;2;255;255;255mStep 4. Boot the menu, go to Windows.  [0m
  [38;2;255;255;255mStep 5. Set the base URL to point to the container's IP address, the correct Nginx port for hosting assets and right directory (eg. http://192.168.2.46:8000/WinPE).  [0m
  [38;2;255;255;255mStep 6. Load the installer.  [0m
  [38;2;255;255;255mStep 7. You should be prompted with a terminal.[0m
  [38;2;255;255;255mStep 8. Type `wpeinit` to load networking support.[0m
  [38;2;255;255;255mStep 9. Mount the Windows ISO share, with `net use F: \\<server-ip-address>\<share-name> /user:<server-ip-address>\<username-if-needed> <password-if-needed>`[0m
  
  [38;2;255;255;255m:::note[0m
  
  [38;2;255;255;255mThe terminal uses US keyboard layout by default.  [0m
  
  [38;2;255;255;255m:::[0m
  [38;2;255;255;255mStep 10. Change into the mounted share (`F:`), and execute setup.exe or start it with `F:\setup.exe`[0m
  [38;2;255;255;255mStep 11. You should be greeted with the normal setup and be able to install it.[0m
  
  [38;2;254;220;197m### Persistent url for Windows with the docker container[0m
  
  [38;2;255;255;255mStep 1. Go to the container's configurator (Netboot.xyz Configuration), the place where you can manage local assets and menus.  [0m
  [38;2;255;255;255mStep 2. Go to Menus -> boot.cfg.  [0m
  [38;2;255;255;255mStep 3. Set win[0m[38;2;233;192;98m_base_[0m[38;2;255;255;255murl to to point to the container's IP address, the correct Nginx port for hosting assets and right directory, for example:[0m
  
  [38;2;255;255;255m```bash[0m
  [38;2;255;255;255mset win[0m[38;2;233;192;98m_base_[0m[38;2;255;255;255murl http://192.168.2.46:8000/WinPE[0m
  [38;2;255;255;255m```[0m
  [38;2;255;255;255mStep 4. You shouldn't need to input the URL anymore when booting Windows so enjoy.[0m

  File: [1m./quick-start.md[0m
  [38;2;255;255;255m---[0m
  [38;2;255;255;255mid: quick-start[0m
  [38;2;255;255;255mtitle: Quick Start[0m
  [38;2;255;255;255mdescription: "Getting started with netboot.xyz"[0m
  [38;2;255;255;255mhide[0m[38;2;233;192;98m_table_[0m[38;2;255;255;255mof_contents: true[0m
  [38;2;255;255;255m---[0m
  
  [38;2;254;220;197m### Getting started[0m
  
  [38;2;255;255;255m[[0m[38;2;204;255;102mDownload[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://netboot.xyz/downloads/[0m[38;2;255;255;255m) one of the netboot.xyz bootloaders that works best for your situation and start PXE booting your favorite operating system.  The bootloaders are precompiled versions of the latest version of [[0m[38;2;204;255;102miPXE[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://github.com/ipxe/ipxe[0m[38;2;255;255;255m) that will allow you to PXE boot into [[0m[38;2;204;255;102mhttps://boot.netboot.xyz[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://boot.netboot.xyz[0m[38;2;255;255;255m).  If you have DHCP it'll automatically attempt to boot from DHCP.  If you need to set a static IP address, hit the 'm' key during boot up for the failsafe menu and choose manual network configuration.[0m
  
  [38;2;255;255;255mYou can look at the next section entitled [[0m[38;2;204;255;102mBooting Methods[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://netboot.xyz/docs/category/booting-methods[0m[38;2;255;255;255m) for instructions on how to set up the downloaded bootloader.[0m
  
  [38;2;255;255;255mIf you already have iPXE up and running on the network, you can hit load the netboot.xyz kernel by typing the following when loaded in a Legacy Mode BIOS:[0m
  
  [38;2;255;255;255m```[0m
  [38;2;255;255;255mchain --autofree http://boot.netboot.xyz/ipxe/netboot.xyz.lkrn[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mor when in EFI mode BIOS:[0m
  
  [38;2;255;255;255m```[0m
  [38;2;255;255;255mchain --autofree http://boot.netboot.xyz/ipxe/netboot.xyz.efi[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mThis will load the appropriate netboot.xyz kernel with all of the proper options enabled.[0m
  
  [38;2;255;255;255m:::info[0m
  
  [38;2;255;255;255mIf your version of iPXE has HTTPS support compiled in, you can retrieve those images over HTTPS. By default the upstream iPXE project does not compile in HTTPS support.[0m
  
  [38;2;255;255;255m:::[0m
  
  [38;2;254;220;197m### System Requirements[0m
  
  [38;2;255;255;255m- i686, x86_64, or aarch64 Processor[0m
  [38;2;255;255;255m- Bare Metal or Virtual Machine[0m
  [38;2;255;255;255m- A hard wired ethernet connection (WiFi networking is not supported)[0m
  [38;2;255;255;255m- At least 4GB of RAM is recommended [0m
  
  [38;2;255;255;255m:::info[0m
  
  [38;2;255;255;255mMemory requirements vary depending on the distribution. Live CD Images typically require a lot more memory as the ramdisk is needed to be loaded into memory. Live CD Images loaded over the network may need more than 4GB. If you experience issues where it fails to load during the initrd process, try giving the hardware or virtual machine more RAM. You will typically see errors like `out of space` or `failure to write to destination` in the initrd once the kernel has loaded if you don't have enough RAM.[0m
  
  [38;2;255;255;255m:::[0m
  
  [38;2;254;220;197m### Source Code[0m
  
  [38;2;255;255;255mThe source code for netboot.xyz is located on [[0m[38;2;204;255;102mGithub[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://github.com/netbootxyz/netboot.xyz[0m[38;2;255;255;255m).[0m
  
  [38;2;254;220;197m### Contributing[0m
  
  [38;2;255;255;255mIs there a new version of an operating system out?  Have you found one that network boots well with iPXE?  Pull requests are welcomed and encouraged and helps out the project!  Feel free to issue a pull request for new versions or tools that you might find useful.  Once merged into master, [[0m[38;2;204;255;102mGithub Actions[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://github.com/netbootxyz/netboot.xyz/actions[0m[38;2;255;255;255m) will regenerate new versions of [[0m[38;2;204;255;102miPXE from upstream[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://github.com/ipxe/ipxe[0m[38;2;255;255;255m) and deploy the latest changes to netboot.xyz.  See more on contributing [[0m[38;2;204;255;102mhere[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://netboot.xyz/docs/contributing[0m[38;2;255;255;255m).[0m
  
  [38;2;254;220;197m### Testing New Features[0m
  
  [38;2;255;255;255mUnder the [0m[1;38;2;233;192;98m**Utilities**[0m[38;2;255;255;255m menu on netboot.xyz, there's an option for [[0m[38;2;204;255;102m"netboot.xyz endpoints"[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://github.com/netbootxyz/netboot.xyz/blob/development/roles/netbootxyz/templates/menu/nbxyz.ipxe.j2[0m[38;2;255;255;255m).  Features or changes that have been merged into the development branch can be loaded here to be tested before they are merged into production. [0m
  
  [38;2;255;255;255m:::info[0m
  
  [38;2;255;255;255mVersion updates are typically deployed to the development endpoint and the primary rolling endpoint at the same time automatically. Once the development branch stabilizes, a new release is cut from the development branch and merged into master. This provides our stable point releases and releases new changes and capabilities related to menus or new features.[0m
  
  [38;2;255;255;255m:::[0m
  
  [38;2;254;220;197m### Communication[0m
  
  [38;2;255;255;255mFeel free to open up an [[0m[38;2;204;255;102missue[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://github.com/netbootxyz/netboot.xyz/issues/new/choose[0m[38;2;255;255;255m) on Github or join us on our [[0m[38;2;204;255;102mDiscord[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://discord.gg/An6PA2a[0m[38;2;255;255;255m) server.  Follow us on [[0m[38;2;204;255;102mTwitter[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://twitter.com/netbootxyz[0m[38;2;255;255;255m) or like us on [[0m[38;2;204;255;102mFacebook[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://www.facebook.com/netboot.xyz[0m[38;2;255;255;255m)![0m

  File: [1m./selfhosting.md[0m
  [38;2;255;255;255m---[0m
  [38;2;255;255;255mid: selfhosting[0m
  [38;2;255;255;255mtitle: Self Hosting[0m
  [38;2;255;255;255mdescription: "How to self host your own netboot.xyz in your environment"[0m
  [38;2;255;255;255mhide[0m[38;2;233;192;98m_table_[0m[38;2;255;255;255mof_contents: true[0m
  [38;2;255;255;255m---[0m
  
  [38;2;254;220;197m### How can I self host netboot.xyz?[0m
  
  [38;2;255;255;255mnetboot.xyz was originally a hosted only tool and used static source files that were difficult to customize.  Now you can generate your own self hosted environment using the same tooling to generate the hosted site.[0m
  
  [38;2;255;255;255m[[0m[38;2;204;255;102mAnsible[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://www.ansible.com/[0m[38;2;255;255;255m), an open-source automation engine, is utilized to generate custom templates based on a set of default configurations which can then be overridden by the user. This allows a user to customize a netboot.xyz environment to their specification and set up a PXE server easily. The Ansible playbooks will generate:[0m
  
  [38;2;255;255;255m* Menus for their netboot.xyz environment using default configuration settings[0m
  [38;2;255;255;255m* iPXE Bootloaders for booting into that environment[0m
  [38;2;255;255;255m* Customized menu options for those who have additional options they want to add[0m
  
  [38;2;254;220;197m#### Role structure[0m
  
  [38;2;255;255;255mThe netbootxyz Ansible [[0m[38;2;204;255;102mrole[0m[38;2;255;255;255m]([0m[4;38;2;225;137;100mhttps://github.com/netbootxyz/netboot.xyz/tree/master/roles/netbootxyz[0m[38;2;255;255;255m) is located in the main netboot.xyz repository.  Most of the logic for netboot.xyz is contained in these areas:[0m
  
  [38;2;255;255;255m* defaults/main.yml - Consists default settings for deployment, OS versions, Utilities, and Bootloaders[0m
  [38;2;255;255;255m* tasks/* - Contains all tasks for rendering templates and compiling iPXE bootloaders [0m
  [38;2;255;255;255m* templates/disks - Templates for iPXE bootloaders[0m
  [38;2;255;255;255m* templates/menus - Templates for netboot.xyz menus[0m
  [38;2;255;255;255m* vars/* - Contain required package lists needed to support the compile and deployment of netboot.xyz[0m
  
  [38;2;254;220;197m#### Deploying using Ansible[0m
  
  [38;2;255;255;255mTo run a deployment using Ansible, first install Ansible, Apache and git:[0m
  
  [38;2;255;255;255m```bash[0m
  [38;2;254;220;197m# For Debian/Ubuntu:[0m
  [38;2;255;255;255mapt install -y ansible git apache2[0m
  
  [38;2;254;220;197m# For Red Hat/CentOS/Fedora[0m
  [38;2;255;255;255myum install -y ansible git httpd[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mThen check out the netboot.xyz repo:[0m
  
  [38;2;255;255;255m```bash[0m
  [38;2;255;255;255mgit clone https://github.com/netbootxyz/netboot.xyz.git /opt/netboot.xyz[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mFinally run the Ansible playbook:[0m
  
  [38;2;255;255;255m```bash[0m
  [38;2;255;255;255mcd /opt/netboot.xyz[0m
  [38;2;255;255;255mansible-playbook -i inventory site.yml[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mThe output will be dropped into `/var/www/html` by default.  You can override this to deploy to the web server directory of your choice.[0m
  
  [38;2;254;220;197m#### Deploying with Docker[0m
  
  [38;2;255;255;255mYou can also leverage docker to generate the netboot.xyz menu and disks in a container which then outputs the results of the rendered templates and compiled iPXE disks into a directory.  First ensure you have docker installed and then run:[0m
  
  [38;2;255;255;255m```bash[0m
  [38;2;255;255;255mdocker build -t localbuild -f Dockerfile .[0m
  [38;2;255;255;255mdocker run --rm -it -v $(pwd):/buildout localbuild[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mThe build output will be in the generated folder `buildout`. Docker provides a consistent and isolated environment for generating the build output. From there you'd drop the files into the root of your favorite web server.[0m
  
  [38;2;254;220;197m#### Local Overrides[0m
  
  [38;2;255;255;255mAnsible will handle source generation as well as iPXE disk generation with your settings.  It will generate Legacy (PCBIOS) and UEFI iPXE disks that can be used to load into your netboot.xyz environment. If you want to override the defaults, you can put overrides in user[0m[38;2;233;192;98m_overrides.yml.  See [`user_[0m[38;2;255;255;255moverrides.yml`](https://github.com/netbootxyz/netboot.xyz/blob/master/user_overrides.yml) for examples.[0m
  
  [38;2;255;255;255mUsing the overrides file, you can override all of the settings from the defaults/main.yml so that you can easily change the boot mirror URLs when the menus are rendered.  If you prefer to do this after the fact, you can also edit the boot.cfg to make changes, but keep in mind those changes will not be saved when you redeploy the menu.[0m
  
  [38;2;254;220;197m#### Self Hosted Custom Options[0m
  
  [38;2;255;255;255mIn addition to being able to host netboot.xyz locally, you can also create your own custom templates for custom menus within netboot.xyz. Those templates are rendered during deployment and are available from the main menu via the custom menu option.[0m
  
  [38;2;255;255;255mWhen these options are set:[0m
  
  [38;2;255;255;255m```bash[0m
  [38;2;255;255;255mcustom[0m[38;2;233;192;98m_generate_[0m[38;2;255;255;255mmenus: true[0m
  [38;2;255;255;255mcustom[0m[38;2;233;192;98m_templates_[0m[38;2;255;255;255mdir: "{{ netbootxyz[0m[38;2;233;192;98m_conf_[0m[38;2;255;255;255mdir }}/custom"[0m
  [38;2;255;255;255m```[0m
  
  [38;2;255;255;255mThe menu will add an option for custom menus and attempt to load into custom/custom.ipxe. From there custom options can be built and maintained separately from the netboot.xyz source tree so that both menus can be updated independently.[0m
  
  [38;2;255;255;255mA sample menu is provided to demonstrate how to configure and set up a menu. You can copy the custom directory from the repo:[0m
  
  [38;2;255;255;255m```bash[0m
  [38;2;255;255;255mcp etc/netbootxyz/custom /etc/netbootxyz/custom[0m
  [38;2;255;255;255m```[0m
