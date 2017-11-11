#!/bin/sh

set -e

INSTANCE=$1
CLIENT=$2
SECRET=$3

echo $INSTANCE
apt-get -y update
apt-get -y install build-essential wget zlib1g-dev libssl-dev

wget http://ftp.ruby-lang.org/pub/ruby/2.4/ruby-2.4.2.tar.gz
tar -xzvf ruby-2.4.2.tar.gz
cd ruby-2.4.2/
./configure
make
make install
ruby -v
cd -

gem install bundler
gem install cf-uaac

uaac -v
uaac target $INSTANCE --skip-ssl-validation
uaac token client get $CLIENT -s $SECRET
uaac user add --emails user1@domain.com -p password
uaac user add --emails user2@domain.com -p password

uaac member add power.fly user1
uaac member add power.strength user1
uaac member add power.invisibility user1

uaac member add power.fly user2
uaac member add power.strength user2
uaac member add power.invisibility user2
