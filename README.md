# PingOne MFA for PingFederate Quickstart

PingFederate server profile which configures P14C for 1FA (using html form adapter and P14C PCV), and 2FA (using the new P14C MFA Adapter).

## P14C Configuration
1. Configure an MFA only Authentication Policy.
     - Example name: "MFA-Only-Policy".
2. Create 2x OAuth clients in P14C as instructed by the p14c adapter.
     - Worker app
       - Example name: PF Adapter Worker Client
       - Roles: Identity Data Admin
     - Native app
       - Example name: PF Adapter End User Client
       - Scope: openid+profile
       - Response Types: ID Token, Token
       - Grant Type: Implicit
       - Policy: MFA-Only-Policy
3. [Create a user](https://apidocs.pingidentity.com/pingone/platform/v1/api/#post-create-user), [enable MFA](https://apidocs.pingidentity.com/pingone/platform/v1/api/#put-update-user-mfa-enabled), add MFA devices ([sms](https://apidocs.pingidentity.com/pingone/platform/v1/api/#post-create-mfa-user-device-sms)|[email](https://apidocs.pingidentity.com/pingone/platform/v1/api/#post-create-mfa-user-device-email)).

## Launch docker and test

1. Pull this git project.
    - git clone https://github.com/ttranatping/p1mfa-serverprofile.git
2. Navigate to the p1mfa-serverprofile folder.
3. Configure override.env providing client details for the native and worker app.
    - instantiate from override.env.template.
4. Start the docker container:
    - docker-compose up -d
5. Start the sample OAuth2 flow: 
    - https://localhost:9031/as/authorization.oauth2?client_id=sampleclient&response_type=token
6. Log in with a P14C user that has MFA enabled.
