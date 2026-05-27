BSP Development: Designed a custom Yocto Project board support package layer (meta-rpi-fastboot) for Raspberry Pi hardware targets using the Scarthgap release, implementing aggressive optimization flags (-Os) to focus binary generation purely on minimal footprint.

    Init System Restructuring: Replaced standard, resource-heavy multi-user systemd frameworks with a highly optimized, lightweight BusyBox and SysVinit core infrastructure, radically simplifying the user-space software initialization stack.

    Kernel & Driver Pruning: Streamlined the kernel initialization phase by removing unnecessary hardware drivers (including Bluetooth, Wi-Fi, HDMI audio subsystems, and unneeded device tree peripherals), severely cutting down on peripheral probing overhead during boot.

    Storage Optimization: Achieved a 97.4% reduction in active OS transport payload size (down to 1.3 MB) by migrating the platform from a standard read-write Ext4 partition to a read-only, block-compressed SquashFS-XZ architecture.

    Boot Latency Reduction: Drove power-on-to-application availability down from an unoptimized ~22-second window to an instant-on ~2.5-second runtime state by utilizing custom initscripts to execute target binaries directly via background initialization loops.
