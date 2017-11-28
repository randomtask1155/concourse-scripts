#!/bin/bash

set -e 

apt-get -y update
apt-get -y install curl

# install cf 
curl -L "https://packages.cloudfoundry.org/stable?release=linux64-binary&source=github" | tar -zx
mv cf /usr/local/bin
cf login -a $CF_API -u $CF_USERNAME -p $CF_PASSWORD -o $CF_ORG -s $CF_SPACE --skip-ssl-validation

sed -i s/https:\\/\\/hero.apps.domain/https:\\/\\/hero.${CF_APP_DOMAIN}/g sso-hero-app/manifest.yml
sed -i s/sso-danl/${SSO_SERVICE_INSTANCE}/g sso-hero-app/manifest.yml
cd sso-hero-app
cf push
