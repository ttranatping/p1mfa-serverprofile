# PingOne MFA for PingFederate Quickstart

PingFederate server profile which configures P14C for 1FA (using html form adapter and P14C PCV), and 2FA (using the new P14C MFA Adapter).

## P14C Configuration
1. Instantiate your own override.env from override.env.template.
2. Configure an MFA only Authentication Policy.
     - Example name: "MFA-Only-Policy".
3. Configure override.env (instantiate from override.env.template) providing client details for the native worker app as instructed by the p14c adapter.
     - Worker app
      - Roles: Identity Data Admin
     - Native app
      - Scope: openid+profile
      - Response Types: ID Token, Token
      - Grant Type: Implicit
      - Policy: MFA-Only-Policy
4. Create users, enable MFA, add MFA devices.

## Launch docker and test

1. Run: docker-compose up -d
2. Launch: https://localhost:9031/as/authorization.oauth2?client_id=sampleclient&response_type=token
3. Log in with a P14C user that has MFA enabled.
