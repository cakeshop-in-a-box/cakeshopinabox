#!/bin/bash
# This is the entry point for configuring the system.
#####################################################
INSTALL_DIR=`pwd`

source setup/functions.sh # load our functions

# Check system setup: Are we running as root on Ubuntu 18.04 on a
# machine with enough memory? Is /tmp mounted with exec.
# If not, this shows an error and exits.
source setup/preflight.sh


# Ensure Python reads/writes files in UTF-8. If the machine
# triggers some other locale in Python, like ASCII encoding,
# Python may not be able to read/write files. This is also
# in the management daemon startup script and the cron script.

if ! locale -a | grep en_US.utf8 > /dev/null; then
    # Generate locale if not exists
    hide_output locale-gen en_US.UTF-8
fi


export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_TYPE=en_US.UTF-8

# Fix so line drawing characters are shown correctly in Putty on Windows. See #744.
export NCURSES_NO_UTF8_ACS=1

#SKIP THIS - file will never be called cakeshop1.conf
# Recall the last settings used if we're running this a second time.
if [ -f /etc/cakeshopinabox.conf ]; then
	echo "Not the first run..."
	sleep 1
	# Run any system migrations before proceeding. Since this is a second run,
	# we assume we have Python already installed.
#	setup/migrate.py --migrate || exit 1

	# Load the old .conf file to get existing configuration options loaded
	# into variables with a DEFAULT_ prefix.
	cat /etc/cakeshopinabox.conf | sed s/^/DEFAULT_/ > /tmp/cakeshopinabox.prev.conf
	source /tmp/cakeshopinabox.prev.conf
	rm -f /tmp/cakeshopinabox.prev.conf
	PROVIDE_ADMIN=1
else
	FIRST_TIME_SETUP=1
fi

# Put a start script in a global location. We tell the user to run 'cakeshop'
# in the first dialog prompt, so we should do this before that starts.
cat > /usr/local/bin/cakeshopinabox << EOF;
#!/bin/bash
cd `pwd`
source setup/start.sh
EOF
chmod +x /usr/local/bin/cakeshopinabox

# Ask the user for the PRIMARY_HOSTNAME, PUBLIC_IP, and PUBLIC_IPV6,
# if values have not already been set in environment variables. When running
# non-interactively, be sure to set values for all! Also sets STORAGE_USER and
# STORAGE_ROOT.
source setup/questions.sh

# Run some network checks to make sure setup on this machine makes sense.
# Skip on existing installs since we don't want this to block the ability to
# upgrade, and these checks are also in the control panel status checks.
if [ -z "${DEFAULT_PRIMARY_HOSTNAME:-}" ]; then
if [ -z "${SKIP_NETWORK_CHECKS:-}" ]; then
	source setup/network-checks.sh
fi
fi

# Create the STORAGE_USER and STORAGE_ROOT directory if they don't already exist.
# If the STORAGE_ROOT is missing the cakeshopinabox.version file that lists a
# migration (schema) number for the files stored there, assume this is a fresh
# installation to that directory and write the file to contain the current
# migration number for this version of Cakeshop-in-a-Box.
if ! id -u $STORAGE_USER >/dev/null 2>&1; then
	useradd -m $STORAGE_USER
fi
if [ ! -d $STORAGE_ROOT ]; then
	mkdir -p $STORAGE_ROOT
fi
#if [ ! -f $STORAGE_ROOT/cakeshopinabox.version ]; then
#	echo $(setup/migrate.py --current) > $STORAGE_ROOT/cakeshopinabox.version
#	chown $STORAGE_USER.$STORAGE_USER $STORAGE_ROOT/cakeshopinabox.version
#fi


# Save the global options in /etc/cakeshopinabox.conf so that standalone
# tools know where to look for data.
cat > /etc/cakeshopinabox.conf << EOF;
STORAGE_USER=$STORAGE_USER
STORAGE_ROOT=$STORAGE_ROOT
PRIMARY_HOSTNAME=$PRIMARY_HOSTNAME
PUBLIC_IP=$PUBLIC_IP
PUBLIC_IPV6=$PUBLIC_IPV6
PRIVATE_IP=$PRIVATE_IP
PRIVATE_IPV6=$PRIVATE_IPV6
EOF
#KOMODO_BRANCH=dollarKOMODOBRANCHCHOICE

if [ ! -z "${PROVIDE_ADMIN:-}" ];then
  echo "Providing console"
  sleep 1
  source setup/console.sh
else
  echo "First install"
  sleep 2
  # Start service configuration.
  init_pubkey
  source setup/pubkey.sh
  source setup/system.sh
  #source setup/ssl.sh
  #source setup/web.sh
  #source setup/management.sh
  #source setup/munin.sh
  source setup/nanomsg.sh
  source setup/choosebase.sh
  #source setup/komodo.sh
  #setup_devwallet
  source setup/console.sh
fi
# Wait for the management daemon to start...
until nc -z -w 4 127.0.0.1 10222
do
	echo Waiting for the Cakeshop-in-a-Box management daemon to start...
	sleep 2
	echo Not required
	break
done

# Give fail2ban another restart. The log files may not all have been present when
# fail2ban was first configured, but they should exist now.
echo "Restarting fail2ban..."
restart_service fail2ban

# If there aren't any cakeshop users yet, create one.
#source setup/firstuser.sh

## Register with Let's Encrypt, including agreeing to the Terms of Service.
## We'd let certbot ask the user interactively, but when this script is
## run in the recommended curl-pipe-to-bash method there is no TTY and
## certbot will fail if it tries to ask.
#if [ ! -d $STORAGE_ROOT/ssl/lets_encrypt/accounts/acme-v02.api.letsencrypt.org/ ]; then
#echo
#echo "-----------------------------------------------"
#echo "Cakeshop-in-a-Box uses Let's Encrypt to provision free SSL/TLS certificates"
#echo "to enable HTTPS connections to your box. We're automatically"
#echo "agreeing you to their subscriber agreement. See https://letsencrypt.org."
#echo
#certbot register --register-unsafely-without-email --agree-tos --config-dir $STORAGE_ROOT/ssl/lets_encrypt
#fi

# Done.
echo
echo "-----------------------------------------------"
echo
echo Your cakeshop-in-a-box is running with these blockchains 1 per line
echo
ps aux | grep komodod | grep -v grep | awk -F " " '{$1=$2=$3=$4=$5=$6=$7=$8=$9=$10=""; print $0 }'
ps aux | grep hushd | grep -v grep | awk -F " " '{$1=$2=$3=$4=$5=$6=$7=$8=$9=$10=""; print $0 }'
