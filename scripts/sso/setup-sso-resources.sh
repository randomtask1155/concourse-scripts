#!/bin/sh

set -ex

UAA_TARGET=$SSO_SERVICE_TARGET
CLIENT=$SSO_ADMIN_CLIENT
SECRET=$SSO_ADMIN_SECRET

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
uaac target $UAA_TARGET --skip-ssl-validation
uaac token client get $CLIENT -s $SECRET


set +e # disable errors here in case user already exits etc.. 
uaac user add user1 --emails user1@domain.com -p password
uaac user add user2 --emails user2@domain.com -p password

uaac group add power.fly 
uaac group add power.strength 
uaac group add power.invisibility

uaac member add power.fly user1
uaac member add power.strength user1
uaac member add power.invisibility user1

uaac member add power.fly user2
uaac member add power.strength user2
uaac member add power.invisibility user2
set -e

