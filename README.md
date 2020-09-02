# p1mfa-serverprofile

PingFederate server profile which configures P14C for 1FA (using html form adapter and P14C PCV), and 2FA (using the new P14C MFA Adapter).

1. Instantiate your own override.env from override.env.template.
2. Configure override.env with a native app and worker app as instructed for the p14c adapter.
3. Create users, enable MFA, add MFA devices.
4. Run: docker-compose up -d
5. Launch: https://localhost:9031/as/authorization.oauth2?client_id=sampleclient&response_type=token
