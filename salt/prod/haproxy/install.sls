include:
  - pkg.pkg-init
haproxy-install:
  file.managed:
    - name: /usr/local/src/haproxy-1.5.3.tar.gz
    - source: salt://haproxy/files/haproxy-1.5.3.tar.gz
    - mode: 755
    - user: root
    - group: root
  cmd.run:
    - name: cd /usr/local/src && tar zxf haproxy-1.5.3.tar.gz && cd haproxy-1.5.3 && make TARGET=linux26 PREFIX=/usr/local/haproxy && make install PREFIX=/usr/local/haproxy
    - unless: test -d /usr/local/haproxy
    - require:
      - pkg: pkg-init
      - file: haproxy-install
/etc/init.d/haproxy:
  file.managed:
    - source: salt://haproxy/files/haproxy.init
    - mode: 755
    - user: root
    - group: root
    - require:
      - cmd: haproxy-install
net.ipv4.ip_nonlocal_bind:
  sysctl.present:
    - value: 1
haproxy-config-dir:
  file.directory:
    - name: /etc/haproxy
    - mode: 755
    - user: root
    - group: root
haproxy-init:
  cmd.run:
    - name: chkconfig --add haproxy
    - unless: chkconfig --list | grep haproxy
    - require:
      - file: /etc/init.d/haproxy
