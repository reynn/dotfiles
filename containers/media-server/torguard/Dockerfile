FROM debian

ENV REGION="Denmark"

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
      openvpn \
      openssl \
      ca-certificates

COPY configs/ /vpn/
COPY openvpn.sh /usr/local/bin/openvpn.sh

ENTRYPOINT ["openvpn.sh"]
