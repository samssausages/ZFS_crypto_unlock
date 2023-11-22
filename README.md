# ZFS_crypto_unlock
A script that auto unlocks your encrypted ZFS datasets on boot.  With general instructions to setup ZFS encryption using keyfiles.

I created this so if someone stole my server they would also need the USB with the keyfiles to access the encrypted datasets.  To accomplish this I save the keyfiles to the usb and I hide the USB, so you wouldn't take that if you took the server.  I'm not going to get too specific on how I did that, but you can get quite creative.  Some ideas:
A USB extension that is hidden
A USB that goes to a locked cabinet
A Wireless USB adapter

You can also serve the keyfiles over networked methods, if your motherboard and system allow for that.  If you have creative ways that you want to share here, let me know and we can expand this.

***Do make sure you have appropriate permissions set for these keyfiles.  They should be protected and treated just like SSH keys.***

## How to use keyfiles with ZFS
### Create Dataset with keyfiles & load
1. Generate the Keyfile (modify save path and filename to suit, I'd save in a folder with same chmod)
```
dd if=/dev/urandom of=/zfs_keyfiles/zfs_keyfilename bs=32 count=1
chmod 0400 /zfs_keyfiles/zfs_keyfilename
```
2.  Create a ZFS Dataset that uses the keyfile you just made. Note the file location (you can set other -o options like compession at this point as well)
```
zfs create -o encryption=on -o keylocation=file:///zfs_keyfiles/zfs_keyfilename -o keyformat=raw poolname/datasetname
```
3.  Generic Load keys and Mount Command
```
zfs load-key poolname/datasetname
zfs mount poolname/datasetname
```

## How to use the script on boot  (Looking for someone to add general linux instructions)
This depends heavily on your system.
### Unraid
1. Install User Scripts Plugin
2. Create New Script and copy/paste ZFS_crypto_unlock.sh
3. Set to "At Startup of Array"
