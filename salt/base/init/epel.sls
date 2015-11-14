yum_repo_release:
  pkg.installed:
    - sources:
      - epel-release: http://mirrors.aliyun.com/epel/6/x86_64/epel-release-6-8.noarch.rpm
    - unless: rpm -qa | grep epel-release-6-8
