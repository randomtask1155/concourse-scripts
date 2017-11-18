#!/bin/bash

set -e 

# install cf 
curl -L "https://packages.cloudfoundry.org/stable?release=linux64-binary&source=github" | tar -zx
mv cf /usr/local/bin
cf login -a $CF_API -u $CF_USERNAME -p $CF_PASSWORD -o $CF_ORG -s $CF_SPACE --skip-ssl-validation


sed -i s/danl-sso/${SSO_SERVICE_INSTANCE}/g sso-hero-app/manifest.yml
cd sso-hero-app
cf push