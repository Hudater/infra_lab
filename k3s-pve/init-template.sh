# Run on Proxmox host as root
# CUSTOMIZED FOR MY OWN USE, NOT A GENERIC TEMPLATE
wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img
qm create 9000 --name ubuntu-22.04-cloud --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0
qm importdisk 9000 jammy-server-cloudimg-amd64.img xpg_nvme
qm set 9000 --scsihw virtio-scsi-pci --scsi0 xpg_nvme:vm-9000-disk-0
qm set 9000 --ide2 xpg_nvme:cloudinit
qm set 9000 --boot c --bootdisk scsi0
qm set 9000 --serial0 socket --vga serial0
qm set 9000 --agent enabled=1
qm template 9000
