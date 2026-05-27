# Custom Raspberry Pi Fast-Boot Embedded Linux BSP Layer
> **An architectural shift from a generic multi-user developer baseline OS to an optimized, single-purpose instant-on embedded system.**

This repository houses `meta-rpi-fastboot`, a custom Yocto Project metadata layer built on the **Scarthgap (5.0.x)** release. The project target was to aggressively minimize both cold-boot latency and storage footprint on a Raspberry Pi platform, simulating constraints common in automotive telematics, medical devices, and industrial IoT gateways.

---

## 📊 Performance Metrics Dashboard

| Metric | Day 1 (Poky Reference Baseline) | Day 16 (Optimized Build) | Total Performance Gain |
| :--- | :--- | :--- | :--- |
| **Cold Boot Latency** | ~22.0 seconds | **~2.5 seconds** | **~88.6% Reduction** 🚀 |
| **Active OS Payload** | ~50.0 MB (Ext4) | **1.3 MB (SquashFS)** | **97.4% Reduction** 📉 |
| **Total Flashed Disk Image** | 170.8 MB (`.wic`) | **60.0 MB** (`.rpi-sdimg`) | **64.8% Reduction** 💾 |

---

## 🛠️ Architectural Optimization Vectors

To drive down the boot sequence to **~2.5 seconds**, structural changes were engineered across three distinct layers of the embedded stack:

### 1. User-Space & Init Restructuring
* **Eradicated Systemd Bloat:** Replaced standard multi-user enterprise initialization frameworks with a streamlined **BusyBox and SysVinit** core infrastructure.
* **Direct Application Hand-off:** Modified the primary execution loop sequence (`rcS`) to execute target binaries via background initialization scripts (`S99fastboot-app.sh`) at the earliest possible millisecond of user-space lifecycle availability, completely bypassing terminal shell login overhead.

### 2. Kernel & Hardware Driver Pruning
* **Eliminated Probing Overhead:** Reconfigured the Linux Kernel via custom configuration fragments (`.cfg`), completely disabling unused subsystems including Bluetooth, Wi-Fi, HDMI audio, and extensive legacy network structures.
* **Toolchain Optimization:** Forced the compiler toolchain to optimize code size over raw unrolling using the `-Os` flag via Yocto’s internal compilation tunables, ensuring a microscopic executable footprint.

### 3. Storage I/O Acceleration
* **Block-Compressed Read-Only Rootfs:** Migrated the root partition from standard read-write Ext4 blocks to a high-ratio, read-only **SquashFS-XZ** file system layout. 
* **The I/O Paradox:** Because physical SD card read boundaries are a severe bottleneck on embedded devices, reducing the raw data payload from ~50MB to a microscopic **1.3MB** drastically minimizes the time the CPU spends waiting for storage blocks, allowing near-instantaneous transfers directly into high-speed system RAM.

---

## 📂 Repository Structure & Key Assets

```text
meta-rpi-fastboot/
├── COPYING.MIT
├── README.md
├── conf/
│   ├── layer.conf
│   └── examples/                  # Clean copies of operational parameters
│       ├── local.conf             # Contains -Os variables, SquashFS toggles, and image variables
│       └── bblayers.conf
├── recipes-core/
│   ├── busybox/                   # Tailored BusyBox applet compilation configs
│   └── initscripts/               # Custom master rcS sequence and application startup scripts
└── recipes-kernel/
    └── linux/                     # Custom Linux-RaspberryPi .bbappend adding driver fragments
