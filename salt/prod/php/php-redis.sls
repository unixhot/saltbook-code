redis-plugin:
  file.managed:
    - name: /usr/local/src/phpredis-2.2.7.tgz
    - source: salt://php/files/phpredis-2.2.7.tgz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /usr/local/src && tar zxf phpredis-2.2.7.tgz && cd phpredis-2.2.7&& /usr/local/php-fastcgi/bin/phpize && ./configure --with-php-config=/usr/local/php-fastcgi/bin/php-config &&  make&& make install
    - unless: test -f /usr/local/php-fastcgi/lib/php/extensions/*/redis.so
  require:
    - file: redis-plugin
    - cmd: php-install

/usr/local/php-fastcgi/etc/php.ini:
  file.append:
    - text:
      - extension=redis.so
