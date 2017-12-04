FROM ubuntu:xenial


ENV SIAB_VERSION=2.19 \
  SIAB_USERCSS="Normal:+/etc/shellinabox/options-enabled/00+Black-on-White.css,Reverse:-/etc/shellinabox/options-enabled/00_White-On-Black.css;Colors:+/etc/shellinabox/options-enabled/01+Color-Terminal.css,Monochrome:-/etc/shellinabox/options-enabled/01_Monochrome.css" \
  SIAB_PORT=8080 \
  SIAB_ADDUSER=true \
  SIAB_USER=geekyzk \
  SIAB_USERID=1000 \
  SIAB_GROUP=root \
  SIAB_GROUPID=0 \
  SIAB_PASSWORD=123456 \
  SIAB_SHELL=/bin/bash \
  SIAB_HOME=/home/geekyzk \
  SIAB_SUDO=true \
  SIAB_SSL=true \
  SIAB_SERVICE=/:LOGIN \
  SIAB_PKGS=none \
  SIAB_SCRIPT=none

RUN apt-get update && apt-get install -y openssl curl openssh-client sudo \
      shellinabox=${SIAB_VERSION} && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  ln -sf '/etc/shellinabox/options-enabled/00+Black on White.css' \
    /etc/shellinabox/options-enabled/00+Black-on-White.css && \
  ln -sf '/etc/shellinabox/options-enabled/00_White On Black.css' \
    /etc/shellinabox/options-enabled/00_White-On-Black.css && \
  ln -sf '/etc/shellinabox/options-enabled/01+Color Terminal.css' \
    /etc/shellinabox/options-enabled/01+Color-Terminal.css

EXPOSE 4200

VOLUME /etc/shellinabox /var/log/supervisor /home

ADD assets/entrypoint.sh /usr/local/sbin/

ENTRYPOINT ["entrypoint.sh"]
CMD ["shellinabox"]
