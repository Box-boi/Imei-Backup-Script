#!/sbin/sh
mount -o rw /system_root
rm -rf /sdcard/imeibackup /sdcard/imeibackup.zip /sdcard/Flashable-IMEI-Backup.zip
mkdir -p /sdcard/imeibackup/META-INF/com/google/android

echo 'ui_print (" ");
ui_print (" ");
ui_print (" IMEI Restore Script(via Recovery) for Lancelot, Merlin, Shiva by Box-Boi(@Box_boi)");
ui_print (" ");
ui_print (" ");
ui_print (" Flashing nvram, nvdata, nvcfg, persist, protect1, protect2 .... ");
ui_print (" ");
ui_print (" ");

package_extract_file("nvram.bin", "/dev/block/by-name/nvram");
package_extract_file("nvdata.img", "/dev/block/by-name/nvdata");
package_extract_file("persist.img", "/dev/block/by-name/persist");
package_extract_file("protect1.img", "/dev/block/by-name/protect1");
package_extract_file("protect2.img", "/dev/block/by-name/protect2");
package_extract_file("nvcfg.img", "/dev/block/by-name/nvcfg");

ui_print (" Flashed All Partitions! ");
ui_print (" ");
ui_print (" ");
ui_print (" IMEI Should Hopefully Be Restored");
ui_print (" ");
ui_print (" ");' >> /sdcard/imeibackup/META-INF/com/google/android/updater-script

cp /sdcard/update-binary /sdcard/imeibackup/META-INF/com/google/android

for part in nvcfg nvdata persist protect1 protect2; do dd if=/dev/block/platform/bootdevice/by-name/$part of=/sdcard/imeibackup/${part}.img; done
for part in seccfg nvram; do dd if=/dev/block/platform/bootdevice/by-name/$part of=/sdcard/imeibackup/${part}.bin; done

cd /sdcard/imeibackup
zip -r Flashable-IMEI-Backup.zip *
rm -rf META-INF
cd -
cp /sdcard/imeibackup/Flashable-IMEI-Backup.zip /sdcard
