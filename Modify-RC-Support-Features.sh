#!/bin/sh

# rc_support modify script

BACKUP_DIR="/jffs/backups"
INIT_SCRIPT="/jffs/scripts/init-start"
RC_SUPPORT_BACKUP="$BACKUP_DIR/rc_support.bak"
INIT_MARKER="#rc_support modification"

# Ensure backup directory exists
mkdir -p "$BACKUP_DIR"

# Function to modify rc_support
modify_rc_support() {
    local action="$1"
    local feature="$2"

    # Backup current rc_support if not already backed up
    if [ ! -f "$RC_SUPPORT_BACKUP" ]; then
        nvram get rc_support > "$RC_SUPPORT_BACKUP"
    fi

    # Read current rc_support
    local rc_support
    rc_support=$(nvram get rc_support)

    case "$action" in
        "add")
            if ! echo "$rc_support" | grep -q "$feature"; then
                rc_support="$rc_support $feature"
            fi
            ;;
        "remove")
            rc_support=$(echo "$rc_support" | sed "s/$feature//g" | tr -s ' ')
            ;;
    esac

    # Set new rc_support value
    nvram set rc_support="$rc_support"
    echo "$INIT_MARKER" >> "$INIT_SCRIPT"
    logger -st "rc_support_script" "Modified rc_support: $rc_support"
}

# Function to restore original rc_support
restore_rc_support() {
    if [ -f "$RC_SUPPORT_BACKUP" ]; then
        local original_rc_support
        original_rc_support=$(cat "$RC_SUPPORT_BACKUP")
        nvram set rc_support="$original_rc_support"
        logger -st "rc_support_script" "Restored original rc_support"

        # Remove the marker line from init-start
        sed -i "/$INIT_MARKER/d" "$INIT_SCRIPT"
    else
        logger -st "rc_support_script" "Backup not found, cannot restore original rc_support!"
    fi
}

# Main script logic
case "$1" in
    "restore")
        restore_rc_support
        ;;
    "add")
        modify_rc_support "add" "$2"
        ;;
    "remove")
        modify_rc_support "remove" "$2"
        ;;
    *)
        echo "Usage: $0 restore|add|remove [feature]"
        exit 1
        ;;
esac
