# Requirements

* ( Optional ) Create a new org and space as this pipeline will create 5 apps
* Create a SSO service instance to work with
* Create a SSO admin client ( [see docs](http://docs.pivotal.io/p-identity/1-5/configure-apps/index.html#admin) ) in your new sso instance as the creds will be needed in the params.txt [ `sso-admin-client` | `sso-admin-secret`]


# External Repos

* simplesamlphp - https://github.com/pivotal-gss/simplesamlphp-for-cf
* sso hero - https://github.com/randomtask1155/sso-hero

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


## Default Internal Users

| Username  | Password | Description  |
|---|---|---|
|user1   |password   |  basic user |
|user2   |password   |  basic user |


## Default SAML Users

| Username  | Password | Description  |
|---|---|---|
|samluser   |password   |  basic user with external group `pcfusers` |
|samladmin   |password   |  basic user with external group `pcfadmins` |


## Switch from internal to SAML Auth in SSO

* import the metadat into the sso instance by going to the https://p-identity.system.domain and selecting `Manage Identity Providers`
* Select `New Identity Provider` and fill in the form
  * The identity name chosen will be the name of the orgin will will need to be known when creating the group mappings
  * identity provider type => SAML 2.0
  * input the metatdata url which should be something like http://idp-saml-ci.apps.domain/saml2/idp/metadata.php.  Where `idp-saml-ci` would be the value of `idp-app-name` in `params.txt`
* Click `Fetch Meatada`
* Add an attribute mappting `external_groups` => `external_groups` so uaa knows how to find the saml groups
* Use uaac to create a group mapping for pcfusers and pcfadmins.  Could be what ever you want.  In the example below we map saml group `pcfusers` to `power.fly` in the `simple-saml-idp` origin name selected in the first step

```
 uaac group map pcfusers --name power.fly --origin simple-saml-idp
```

* Go to appsmanager and find your sso service instance and click the manage link.  Select the app you want to enable saml for.  By default the apps will only use internal uaa store but you can choose to disable that or have both uaa and saml enabled. 




