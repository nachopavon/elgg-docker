#!/bin/sh

WAIT_MYSQL_START="30" # In seconds
MYSQL_PORT="$MYSQL_PORT"
MYSQL_USER="$MYSQL_USER"
MYSQL_PASS="$MYSQL_PASS"
ELGG_DB_HOST="$ELGG_DB_HOST"

#wait for mysql
i=0
while ! netcat $ELGG_DB_HOST $MYSQL_PORT >/dev/null 2>&1 < /dev/null; do
  i=`expr $i + 1`
  if [ $i -ge $MYSQL_LOOPS ]; then
    echo "$(date) - ${ELGG_DB_HOST}:${MYSQL_PORT} still not reachable, giving up."
    exit 0
  fi
  echo "$(date) - waiting for ${ELGG_DB_HOST}:${MYSQL_PORT}... $i/$MYSQL_LOOPS."
  sleep 1
done

php	/elgg-docker/elgg-install.php