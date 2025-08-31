FROM sepa/nginx-ldap

COPY bin/nginx-ldap-auth-daemon /usr/local/bin/nginx-ldap-auth-daemon
COPY docker/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["nginx-ldap-auth-daemon", "--host=0.0.0.0"]
