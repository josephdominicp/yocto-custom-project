
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

FILESEXTRAPATHS:prepend := "${THISDIR}/initscripts:"

SRC_URI += "file://fastboot-app.sh"

do_install:append() {
    # Install the startup script to /etc/init.d/
    install -m 0755 ${WORKDIR}/fastboot-app.sh ${D}${sysconfdir}/init.d/fastboot-app.sh

    # Link it to the default runlevel (S) so it runs as fast as possible
    # 'S99' ensures it runs at the very end of the core initialization
    ln -sf ../init.d/fastboot-app.sh ${D}${sysconfdir}/rcS.d/S99fastboot-app.sh
}

