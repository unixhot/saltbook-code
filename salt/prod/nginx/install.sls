include:
  - pcre.install
  - user.www
nginx-source-install:
  file.managed:
    - name: /usr/local/src/nginx-1.9.1.tar.gz
    - source: salt://nginx/files/nginx-1.9.1.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /usr/local/src && tar zxf nginx-1.9.1.tar.gz && cd nginx-1.9.1&& ./configure --prefix=/usr/local/nginx --user=www --group=www --with-http_ssl_module --with-http_stub_status_module --with-file-aio --with-http_dav_module --with-pcre=/usr/local/src/pcre-8.37 && make && make install && chown -R www:www /usr/local/nginx
    - unless: test -d /usr/local/nginx
    - require:
      - user: www-user-group
      - file: nginx-source-install
      - pkg: pkg-init
      - cmd: pcre-source-install
