#!/bin/bash

# This script itterates through all of your datasets and tries to load the encryption keyfiles to unlock them.  It also mounts the dataset when done.
# ZFS Load Keys and Mount
zfs get -H -o name,value keystatus | grep -w 'unavailable' | grep -v '@' | cut -f1 | while read -r dataset; do
    echo "Loading key for $dataset..."
    zfs load-key "$dataset"
    
    if [ $? -eq 0 ]; then
        echo "Successfully loaded key for $dataset."
    else
        echo "Failed to load key for $dataset. Attempting to mount anyway..."
    fi
    
    zfs mount "$dataset"
    if [ $? -eq 0 ]; then
        echo "Successfully mounted $dataset."
    else
        echo "Failed to mount $dataset."
    fi
done
