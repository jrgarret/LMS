#!/bin/sh

: ${PUID:=1026}
: ${PGID:=100}

groupadd -g $PGID squeezeboxserver

useradd -u $PUID -g $PGID \
	-d /usr/share/squeezeboxserver/ \
	-c 'Logitech Media Server' \
	squeezeboxserver

for subdir in prefs logs cache; do
	mkdir -p /config/$subdir
done

# Change permissions on directories created in the Dockerfile
chown -R squeezeboxserver:squeezeboxserver /config

myip=$( ip addr show eth0 2> /dev/null | awk '$1 == "inet" {print $2}' | cut -f1 -d/ )

if [ "$myip" ]; then
	url="http://$myip:9000/"

	echo ======================================================================
	echo "$url"
	echo ======================================================================
	echo
fi

runuser -u squeezeboxserver --  squeezeboxserver \
	--prefsdir /config/prefs \
	--logdir /config/logs \
	--cachedir /config/cache "$@"
