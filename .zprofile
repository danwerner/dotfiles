# ~/.profile: executed by all sh(1)-compatible shells

# the default umask is set in /etc/login.defs
#umask 002

# set variable identifying the chroot you work in
if [ -f /etc/debian_chroot ]; then
	debian_chroot=`cat /etc/debian_chroot`
fi

# Show entries for next 7 and past 1 day(s)
[ -e ~/.calendar ] && calendar -A 7 -B 1

date
