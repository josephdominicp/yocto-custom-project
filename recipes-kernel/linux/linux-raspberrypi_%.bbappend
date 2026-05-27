COMPATIBLE_MACHINE:rpi-fastboot = "rpi-fastboot"

# Tell BitBake to look in the 'files' directory for configuration fragments
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

# Add the fast-boot configuration fragment to the build
SRC_URI += "file://fastboot.cfg"
