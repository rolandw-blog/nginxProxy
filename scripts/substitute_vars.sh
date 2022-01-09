#! /bin/bash

# BW_PORT=$(sed '1q;d' .env | cut -d'=' -f2)
# BB_PORT=$(sed '2q;d' .env | cut -d'=' -f2)

# echo "BLOG WATCHER PORT: $BW_PORT"
# echo "BLOG BUILDER PORT: $BB_PORT"

# for i in /etc/nginx/locations*; do
#   sed -i "s/\${BLOGWATCHER_PORT}/$BLOGWATCHER_PORT/g" "$i"
#   sed -i "s/\${BLOGBUILDER_PORT}/$BLOGBUILDER_PORT/g" "$i"
# done

find /etc/nginx/locations -type f -exec sed -i "s/\${BLOGWATCHER_PORT}/$BLOGWATCHER_PORT/g" {} \;
find /etc/nginx/locations -type f -exec sed -i "s/\${BLOGBUILDER_PORT}/$BLOGBUILDER_PORT/g" {} \;

# sed -i "s/\${BLOGWATCHER_PORT}/$BW_PORT/g" "blogwatcher.conf"
