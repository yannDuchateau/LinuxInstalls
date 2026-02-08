#View the partition table of the LUN in exact sectors
fdisk -ul /dev/mpathX

#Re-scan the LUN
echo into rescan or issue_lip, or run rescan-scsi-bus.sh, or however you do it

#Confirm the block device now has the larger size
fdisk -ul /dev/mpathX

#Edit the partition table
fdisk -u /dev/mpathX

#Delete the partition, re-create the partition with the same starting sector 
#but a new end sector which reaches to the new end of the larger block device.
#If your partition starts at an early sector like 63 but fdisk will only let you start 
#a partition at 2048 or later, then create the partition starting at 2048, then go 
#into "expert mode" and "move beginning of data" back to 63.

#Unmount your filesystem
umount /opt/application

#Set the VG inactive
vgchange -an /dev/mapper/vg-lv

#Have the system recognise the new partition table
partprobe /dev/mpathX

#Grow the PV to the new size of the partition
pvresize /dev/mpathX

#Set the VG active
vgchange -ay /dev/mapper/vg-lv

#Resize the LV and its underlying filesystem
lvresize -r -l+100%FREE /dev/mapper/vg-lv

#Mount the filesystem and confirm its new size
df -h /opt/application