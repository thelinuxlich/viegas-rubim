#/bin/sh

# Monta a particao com uClibc e busybox
sudo modprobe loop
sudo mount -o loop vm_uclibc/root_fs_i386.ext2 vm_uclibc/root/

# Gera imagem ext2
dd if=/dev/zero of=images/initrd bs=4440K count=1
mkfs.ext2 -F -m0 -b 1024 images/initrd

# Monta a particao
mount -o loop images/initrd mnt/initrd

# Copia o busybox compilado com uClibc
cp -av vm_uclibc/root/busybox/_install/* mnt/initrd

# Cria os diretorios e permissoes e arquivos a partir de um padrao
cp -av sources/initrd/* mnt/initrd
cp -av sources/opentracker/* mnt/initrd
cp -av sources/ctorrent/* mnt/initrd
cp -av sources/ntfs-progs/* mnt/initrd
cp -av sources/dropbear/* mnt/initrd

# Desmonta
umount mnt/initrd
sudo umount vm_uclibc/root

# Gera o gzip
gzip -9 images/initrd



