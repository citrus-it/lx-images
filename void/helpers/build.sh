#!/bin/sh

echo lx > /etc/hostname
touch /etc/void-release

# temporary - need to adjust omnios lxinit
sed -i 's/lxc/zone/' /etc/runit/functions

# Disable sysctl changes
sed -i 's/^[a-z]/#&/' /usr/lib/sysctl.d/10-void.conf

# Update the package manager
xbps-install -ySu xbps
# Update all packages
xbps-install -ySu
# Install extras
xbps-install -ySu \
	iproute2 iputils inetutils net-tools \
	ncurses-base \
	openssh joe vim

# Clean up cache and remove orphans
xbps-remove -yOo

svdir=/etc/runit/runsvdir/default

# Disable default agetty services
rm -f $svdir/agetty-tty*

# Enable serial console
ln -s /etc/sv/agetty-console $svdir/

