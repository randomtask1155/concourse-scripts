#!/bin/sh

set -e

CONFIGFILE = "idp-config.yml"

echo opsman_uaa: \"https://${OPSMANAGER_HOSTNAME}/uaa\" > $CONFIGFILE
echo bosh_uaa: \"https://${DIRECTOR_IP}:8443\" >> $CONFIGFILE
echo ert_uaa: \"http://${UAA_LOGIN_ENDPOINT}\" >> $CONFIGFILE
echo app_name: \"${IPD_APP_NAME}\" >> $CONFIGFILE

./saml-idp-app/deploy_new_saml_server.rb $CONFIGFILE -a
