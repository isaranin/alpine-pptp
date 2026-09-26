FROM alpine:3.17
LABEL org.opencontainers.image.authors="ivan@saranin.com"

# Installing pptpd, ppp and iptables
RUN apk add --no-cache \
    pptpd \
    ppp \
    iptables

COPY ./etc/pptpd.conf /etc/pptpd.conf
COPY ./etc/ppp/pptpd-options /etc/ppp/pptpd-options

COPY entrypoint.sh /entrypoint.sh
RUN chmod 0700 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["pptpd", "--fg"]
