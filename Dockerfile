FROM lifei/baseimage

RUN apt-get install -y openvpn iptables git-core openvpn-auth-ldap
RUN git clone https://github.com/OpenVPN/easy-rsa.git /usr/local/share/easy-rsa
RUN cd /usr/local/share/easy-rsa && git checkout -b tested 89f369c5bbd13fbf0da2ea6361632c244e8af532
RUN ln -s /usr/local/share/easy-rsa/easyrsa3/easyrsa /usr/local/bin

# Needed by scripts
ENV OPENVPN /etc/openvpn
ENV EASYRSA /usr/local/share/easy-rsa/easyrsa3
ENV EASYRSA_PKI $OPENVPN/pki
ENV EASYRSA_VARS_FILE $OPENVPN/vars

# Internally uses port 1194, remap using docker
EXPOSE 1194/udp

WORKDIR /etc/openvpn

ADD ./bin /usr/local/bin
