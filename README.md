# p1mfa-serverprofile

PingFederate server profile which configures P14C for 1FA (using html form adapter and P14C PCV), and 2FA (using the new P14C MFA Adapter).

1. Instantiate your own override.env from override.env.template.
2. Configure an MFA only Authentication Policy.
  - Call it something like "MFA-Only-Policy".
3. Configure override.env with a native app and worker app as instructed for the p14c adapter.
  - Worker app
    - Roles: Identity Data Admin
  - Native app
    - Scope: openid+profile
    - Response Types: ID Token, Token
    - Grant Type: Implicit
    - Policy: MFA-Only-Policy
4. Create users, enable MFA, add MFA devices.
5. Run: docker-compose up -d
6. Launch: https://localhost:9031/as/authorization.oauth2?client_id=sampleclient&response_type=token
7. Log in with a P14C user that has MFA enabled.
