#!/usr/bin/env bash

set +ex

if ! php --ri swoole ; then
    echo "Error: PHP exension \"Swoole\" is not installed or enabled."
    exit 1
fi

apt-get update
apt-get install libboost-all-dev --no-install-recommends -y

docker-php-source extract
mkdir /usr/src/php/ext/yasd
curl -sfL https://github.com/swoole/yasd/archive/refs/tags/v0.3.9.tar.gz -o yasd.tar.gz
tar xfz yasd.tar.gz --strip-components=1 -C /usr/src/php/ext/yasd
docker-php-ext-configure yasd
docker-php-ext-install -j$(nproc) yasd
rm -f yasd.tar.gz
docker-php-source delete
cp /usr/local/etc/php/conf.d/docker-php-ext-yasd.ini-suggested /usr/local/etc/php/conf.d/docker-php-ext-yasd.ini