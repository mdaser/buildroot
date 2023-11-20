setenv bootargs console=ttyS0,115200 earlyprintk rootwait root=/dev/nfs ip=192.168.0.100:::::eth0 nfsroot=192.168.0.1:/srv/nfs/pine64root/,nfsvers=3,tcp rw

fatload mmc 0 $kernel_addr_r Image
fatload mmc 0 $fdt_addr_r sun50i-a64-pine64-plus.dtb

booti $kernel_addr_r - $fdt_addr_r
