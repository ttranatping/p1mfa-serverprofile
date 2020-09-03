# PingOne MFA for PingFederate Quickstart

PingFederate server profile which configures P14C for 1FA (using html form adapter and P14C PCV), and 2FA (using the new P14C MFA Adapter).

## P14C Configuration

### Option 1 - Create P1MFA/P14C environment using Postman

A postman collection is provided to help you get you set up quickly. 

1. Import the [postman collection](postman_setup_p1mfa.json) into Postman.
2. Configure the collection variables (right click collection and edit it).
    - Set the parent environment settings:
      - parentEnvID
      - adminAppID (worker app configured in your parent environment)
      - adminAppSecret
3. Configure an empty Postman environment.
4. Execute the Postman requests in sequence.
5. Collect environment details by running the last request "Get Environment Details" to configure later in override.env.
    - environmentId -> P14C_ENVIRONMENTID
    - workerapp-client_id -> P14C_WORKER_CLIENTID
    - workerapp-client_secret -> P14C_WORKER_CLIENTSECRET
    - enduser-client_id -> P14C_ENDUSER_CLIENTID
    - enduser-client_secret -> P14C_ENDUSER_CLIENTSECRET

### Option 2 - Manually create P1MFA/P14C environment

Alternatively you can run the following manual steps:

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
    - At minimum, update the following:
        - P14C_ENVIRONMENTID=
        - P14C_WORKER_CLIENTID=
        - P14C_WORKER_CLIENTSECRET=
        - P14C_ENDUSER_CLIENTID=
        - P14C_ENDUSER_CLIENTSECRET=
4. Start the docker container using one of the two methods:
    - docker-compose up -d
    - docker run -p 9031:9031 -p 9999:9999 -it --env-file override.env --env-file ~/.pingidentity/devops --rm  "pingidentity/pingfederate:edge"
5. Start the sample OAuth2 flow: 
    - https://localhost:9031/as/authorization.oauth2?client_id=sampleclient&response_type=token
6. Log in with a P14C user that has MFA enabled.
