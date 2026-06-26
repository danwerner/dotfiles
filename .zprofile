# ~/.profile: executed by all sh(1)-compatible shells
# vi: set sts=2 sw=2 et :

# the default umask is set in /etc/login.defs
#umask 002

# set variable identifying the chroot you work in
if [ -f /etc/debian_chroot ]; then
	debian_chroot=`cat /etc/debian_chroot`
fi

