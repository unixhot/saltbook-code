include:
  - memcached.install
  - user.www

memcached-service:
  cmd.run:
    - name: /usr/local/memcached/bin/memcached -d -m 128 -p 11211 -c 8096 -u www
    - unless: netstat -ntlp | grep 11211
    - require:
      - cmd: memcached-source-install
      - user: www-user-group
