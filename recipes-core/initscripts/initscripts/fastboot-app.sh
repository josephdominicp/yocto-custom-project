#!/bin/sh
### BEGIN INIT INFO
# Provides:          fastboot-app
# Required-Start:    $local_fs
# Default-Start:     S
# Short-Description: Start custom application immediately
### END INIT INFO

# Launch your application binary in the background so it doesn't block the boot sequence
/usr/bin/my-app-binary &
