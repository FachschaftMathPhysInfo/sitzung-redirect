#!/bin/bash
if [ -z "$REDIRECT_TYPE" ]; then
	REDIRECT_TYPE="permanent"
fi

if [ -z "$REDIRECT_TARGET" ]; then
	echo "Redirect target variable not set (REDIRECT_TARGET)"
	exit 1
else
	OFFSET="+$((3-$(date +%u))) day"
	DATE=$(date -d "$OFFSET" '+%Y-%m-%d')
	REDIRECT_TARGET="${REDIRECT_TARGET}/FS-Sitzung-${DATE}"
	# Add https if not set
	if ! [[ $REDIRECT_TARGET =~ ^https?:// ]]; then
		REDIRECT_TARGET="https://$REDIRECT_TARGET"
	fi
fi

LISTEN="80"

cat <<EOF > /etc/nginx/conf.d/default.conf
server {
	listen ${LISTEN};
	rewrite ^(.*)\$ ${REDIRECT_TARGET} ${REDIRECT_TYPE};
}
EOF


echo "Listening to $LISTEN, Redirecting HTTP requests to ${REDIRECT_TARGET}..."

exec nginx -g "daemon off;"
