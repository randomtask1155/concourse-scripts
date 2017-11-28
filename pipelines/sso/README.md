# How to deploy SSO Saml Pipeline


* update `params.txt`

| Param  | Default  | Purpos  |
|---|---|---|
|cf-api   | empty  | PAS api endpoint  |   
|cf-username   |empty   | User used for deployment  |  
|cf-password   |empty   | Password of deployment user  |  
|cf-organization   |empty   | Org that has the sso instance deployed  |   
|cf-space   |empty   |  Space that has the sso instance deployed |  
|sso-service-instance   | empty  | Name of the deployed sso service instance  |   
|sso-service-target   |empty   | URL of the sso instance login "https://instance.login.system.domain"  |   
|sso-admin-client   |empty   | Client ID of the manually created admin client  |   
|sso-admin-secret   |empty   | Client secret of the manually created admin client   |   
|opsmanager-hostname   | empty  | opsmgr.domain.io  |  
|director-ip   | empty  | ip address of the deployed bosh director  |
|uaa-login-endpoint   |empty   |  PAS UAA login endpoint "https://login.system.domain" |  
|idp-app-name   |idp-saml-ci   |  Name used for the simplesamlphp app |   


* Deploy the pipeline

```
fly -t lab02 set-pipeline -p sso-saml -c deploy-saml-pipeline.yml -l params-test.yml
```

* make sure to create an admin client in your sso instance.  The id and secret should be set in params.txt for `sso-admin-client` and `sso-admin-secret`
  * http://docs.pivotal.io/p-identity/1-5/configure-apps/index.html#admin
