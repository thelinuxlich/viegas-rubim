#/bin/sh

# Compila o busybox
#./sources/linux/make

# Gera imagem dosfs
dd if=/dev/zero of=images/disk.img bs=1440K count=1
mkdosfs images/disk.img

# Usa o syslinux
syslinux -s images/disk.img

# Monta a particao
mount -o loop images/disk.img mnt/disk

# Copia o kernel e init
cp sources/linux/bzImage mnt/disk/vmlinuz
cp images/initrd.gz mnt/disk

# Cria os diretorios e permissoes e arquivos a partir de um padrao
cp -rv sources/disk/normal/* mnt/disk

# Desmonta
umount mnt/disk

