SUMMARY = "An ultra-minimal fast-booting image using BusyBox"
LICENSE = "MIT"

# Only install core boot packages and busybox
IMAGE_INSTALL = " \
    packagegroup-core-boot \
    busybox \
"

# Remove language packs and extra features to save space and time
IMAGE_LINGUAS = ""
IMAGE_FEATURES = ""

inherit image

IMAGE_FEATURES += "read-only-rootfs"

# === Day 10 Fast-Boot Optimizations ===
# Force the filesystem to have zero extra padding space
IMAGE_ROOTFS_EXTRA_SPACE = "0"
IMAGE_OVERHEAD_FACTOR = "1.0"

# Explicitly prevent unwanted/heavy hardware daemons from being pulled in
BAD_RECOMMENDATIONS += " \
    udev \
    sysvinit-pidof \
"
