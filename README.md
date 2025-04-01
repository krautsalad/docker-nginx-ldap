# docker-nginx-ldap

LDAP authentication for Nginx.

**docker-nginx-ldap** is a modified version of [sepa/nginx-ldap](https://hub.docker.com/r/sepa/nginx-ldap) that adds compatibility with OpenLDAP and the memberOf schema.

## Configuration

### Docker Compose Example

```yml
# docker-compose.yml
services:
  auth:
    container_name: nginx-auth
    expose:
      - "8888"
    image: krautsalad/nginx-ldap
    mem_limit: 64m
    restart: unless-stopped
    volumes:
      - ./config/pam_ldap.conf:/etc/pam_ldap.conf:ro
```

### PAM LDAP Configuration

Create a `./config/pam_ldap.conf` file with your LDAP server details:

```txt
base ou=users,dc=example,dc=com
binddn cn=search,dc=example,dc=com
bindpw VerySecurePassword
host ldap.example.com:636
ssl on
```

### Nginx Site Configuration

Integrate LDAP authentication into your Nginx site with the following example:

```nginx
server {
  server_name server.example.com;

  location / {
    auth_request /auth-proxy;
  }

  location = /auth-proxy {
    set $auth nginx-auth:8888;
    proxy_set_header X-Ldap-Allowed-Grp cn=server.example.com,ou=groups,dc=example,dc=com;

    internal;
    proxy_pass http://$auth;
    proxy_pass_request_body off;
    proxy_set_header Content-Length "";
  }
}
```

*Note*: For proper name resolution of Docker containers, ensure you have a DNS server running. See [krautsalad/dnsmasq](https://hub.docker.com/r/krautsalad/dnsmasq) for more details on setting up a DNS service.

## Source Code

You can find the full source code on [GitHub](https://github.com/krautsalad/docker-nginx-ldap).
