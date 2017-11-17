#!/bin/sh

set -xe

CONFIGFILE="idp-config.yml"

## install ruby
apt-get -y update
apt-get -y install build-essential wget zlib1g-dev libssl-dev curl git

wget http://ftp.ruby-lang.org/pub/ruby/2.4/ruby-2.4.2.tar.gz
tar -xzvf ruby-2.4.2.tar.gz
cd ruby-2.4.2/
./configure
make
make install
ruby -v
cd -

# install cf 
curl -L "https://packages.cloudfoundry.org/stable?release=linux64-binary&source=github" | tar -zx
mv cf /usr/local/bin
cf login -a $CF_API -u $CF_USERNAME -p $CF_PASSWORD -o $CF_ORG -s $CF_SPACE --skip-ssl-validation


cd ./saml-idp-app/
echo opsman_uaa: \"https://${OPSMANAGER_HOSTNAME}/uaa\" > $CONFIGFILE
echo bosh_uaa: \"https://${DIRECTOR_IP}:8443\" >> $CONFIGFILE
echo ert_uaa: \"http://${UAA_LOGIN_ENDPOINT}\" >> $CONFIGFILE
echo app_name: \"${IPD_APP_NAME}\" >> $CONFIGFILE

./deploy_new_saml_server.rb $CONFIGFILE -a
