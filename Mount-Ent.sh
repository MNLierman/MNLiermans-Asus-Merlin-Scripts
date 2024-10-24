#!/bin/sh

# Mount Entware - Minimal Version 
# Last updated 10-23-2024 | Free to modify, change, and distribute, I only ask that you share any improvements you make and credit me when appropriate.
# Summary: Detects and mounts Entware upon detection of a USB ready as per system notification.
# You must add "/jffs/scripts/Mount-Ent.sh &" to post-mount. Alternatively, if that doesn't work, add this to services-start and change your USB label below.
#
# This is the minimal version of @MikeLierman's (github.com/mnlierman) Mount Entware script. As other community Entware mounting scripts
# have been rumored to not be supported anymore and they were not working for us.
#
# Difference of Minimal vs Full versions: Minimal only checks the system provided mount point argument and your drive label specified below (optional).
# Also optional - 1) Mounts /tmp/opt/home to /tmp/home, as /tmp is a RAM drive and home folder is lost on reboot. 2) If you use chroot, this will
# ensure it's mounted with the necessary options. The Full version, does a bit of searching in /dev and /tmp/mnt to find Entware. If this version does
# not work for you, then try the Full version.

# Variables
drvlabel="Ent" # Optional, use your thumb drive label to mount Entware, helpful if system struggles to find Entware automatically or post-mount isn't executed
logging=1 # Log extra verbose information; could be helpful if Entware isn't getting mounted or script fails
logfile="/jffs/logs/USB-Mount.log"
chroot=0 # Change to 1 if you installed Debian or Ubuntu chroot, this will ensure the proper mount options are enabled
homefolder=1 # Recommended, this mounts /tmp/opt/home to /tmp/home, since /tmp/home is lost on reboot, as /tmp is a ram drive

# Verbose/extra logging function, enable above
log() {
    if [ "$logging" -eq 1 ]; then
        local message="$1"
        echo "$(date '+%d-%m-%Y %H:%M:%S') $message" >> "$logfile"
    fi
}

if [ "$logging" -eq 1 ]; then
    # Ensure log directory exists
    [ -d /jffs/logs ] || mkdir -p /jffs/logs

    # Redirect both stdout and stderr to the log file
    exec >> "$logfile" 2>&1
fi

# Check if Entware is already mounted
if [ -d "/opt/bin" ] && [ -f "/opt/etc/entware_release" ]; then
    if [ "$1" == "force" ]; then
        log "USB $1 detected, but Entware appears to already be mounted. Forced mode enabled, continuing."
        logger -t "[Mount Entware]" "USB $1 detected, but Entware appears to already be mounted. Forced mode enabled, continuing."
    else
        log "USB $1 detected, but Entware appears to already be mounted, exiting."
        logger -t "[Mount Entware]" "USB $1 detected, but Entware appears to already be mounted, exiting."
        exit 2
    fi
fi

# Log USB detection
log "USB $1 detected, checking if Entware exists."
logger -t "[Mount Entware]" "USB $1 detected, checking if Entware exists."

# Check for Entware directory
if [ -d "$1/entware/bin" ] || [ -d "/tmp/mnt/$drvlabel/entware/bin" ]; then

    # Create opt dir if it doesn't exist
    [ -d /tmp/opt ] || mkdir -p /tmp/opt

    # Determine location to mount Entware from; use user's provided drive label first if Entware exists there
    if [ -d "/tmp/mnt/$drvlabel/entware/bin" ]; then
        log "Entware successfully detected at /tmp/mnt/$drvlabel/entware, now mounting."
        logger -t "[Mount Entware]" "Entware successfully detected at /tmp/mnt/$drvlabel/entware, now mounting."
        mount --bind /tmp/mnt/$drvlabel/entware /tmp/opt
    elif [ -d "$1/entware/bin" ]; then
        logger -t "[Mount Entware]" "Entware successfully detected at $1/entware, now mounting."
        log "Entware successfully detected at $1/entware, now mounting."
        mount --bind $1/entware /tmp/opt    
    fi

    # Entware services
    log "Starting Entware services"
    /opt/etc/init.d/rc.unslung start $0
    rc rc_service restart_dnsmasq

    # Check if chroot is enabled
    if [ "$chroot" -eq 1 ]; then
        log "Adding additional location for Debian at /mnt/debian"
        mount --bind /tmp/opt/debian /mnt/debian

        log "Mounting with exec and dev for chroot."
        mount -i -o remount,exec,dev,noatime,nodiratime /tmp/opt
        mount -i -o remount,exec,dev,noatime,nodiratime /opt/..
        mount -i -o remount,exec,dev,noatime,nodiratime /
    fi

    # Mounts home folder from thumb drive, which fixes programs that store configs in /home, such as htop 
    # As stated by htop dev, creating dir manually with proper perms is sometimes needed: https://github.com/htop-dev/htop/issues/1092#issuecomment-1252762609
    if [ "$homefolder" -eq 1 ]; then

        log "Checking directory structure prior to mounting home folder."

        if [ ! -d /tmp/opt/home/root/.config/htop ]; then
            log "/tmp/opt/home/root/.config does not exist, creating it."
            mkdir -p /tmp/opt/home/root/.config/htop
            chmod -R 775 /tmp/opt/home/root/.config
        fi
        # Create /tmp/home/root/.config as fallback
        if [ ! -d /tmp/home/root/.config ]; then
            log "/tmp/home/root/.config does not exist, creating it as fallback."
            mkdir -p /tmp/home/root/.config/htop
            chmod -R 775 /tmp/home/root/.config
        fi
        # If you have btop installed, this will fix it too
        if [ -f /tmp/opt/sbin/btop ] || [ -f /tmp/opt/bin/btop ]; then
            if [ ! -d /tmp/opt/home/root/.config/btop ]; then
                log "/tmp/opt/home/root/.config/btop does not exist, creating it."
                mkdir -p /tmp/opt/home/root/.config/btop/themes
                chmod -R 775 /tmp/opt/home/root/.config/btop
            fi
            if [ ! -d /tmp/home/root/.config/btop ]; then
                log "/tmp/home/root/.config/btop does not exist, creating it as fallback."
                mkdir -p /tmp/home/root/.config/btop/themes
                chmod -R 775 /tmp/home/root/.config/btop
            fi
        fi

        # Check for current username and create folder structure if not root
        current_user=$(id -un)
        if [ "$current_user" != "root" ]; then
            if [ ! -d /tmp/opt/home/$current_user/.config ]; then
                log "/tmp/opt/home/$current_user/.config does not exist, creating it."
                mkdir -p /tmp/opt/home/$current_user/.config
                chmod -R 775 /tmp/opt/home/$current_user/.config
            fi
            if [ ! -d /tmp/home/$current_user/.config/htop ]; then
                log "/tmp/home/$current_user/.config/htop does not exist, creating it."
                mkdir -p /tmp/home/$current_user/.config/htop
                chmod -R 775 /tmp/home/$current_user/.config
            fi
            if [ ! -d /tmp/home/$current_user/.config/btop ]; then
                log "/tmp/home/$current_user/.config/btop does not exist, creating it."
                mkdir -p /tmp/home/$current_user/.config/btop
                chmod -R 775 /tmp/home/$current_user/.config
            fi
        fi

        # Set permissions for home folders
        log "Setting permissions for home folders, including sticky bit."
        chmod 1777 /tmp/opt/home
        chmod 700 /tmp/opt/home/root
        chmod 1777 /tmp/home
        chmod 700 /tmp/home/root

        log "Mounting home folder from /tmp/opt/home to /tmp/home."
        logger -t "[Mount Entware]" "Mounting home folder."

        mount --bind /tmp/opt/home /tmp/home
    fi

    if [ -d "/opt/bin" ] && [ -f "/opt/etc/entware_release" ]; then
        logger -t "[Mount Entware]" "Successfully started Entware services on $1"
        exit 0
    else
        logger -t "[Mount Entware]" "Entware was detected on $1 but mounting failed. Enable logging in this script to check for additional information."
        exit 1
    fi
else
    log "Entware not found on $1 or /tmp/mnt/$drvlabel/entware/bin."
    logger -t "[Mount Entware]" "Entware not found on $1 or /tmp/mnt/$drv"
    exit 0
fi
