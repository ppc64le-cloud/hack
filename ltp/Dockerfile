FROM quay.io/centos/centos:stream8

RUN dnf install --best --refresh -y \
    gcc git make pkgconf autoconf automake bison flex m4 kernel-headers glibc-headers \
    && dnf clean all \
    && rm -rf /var/cache/yum

RUN git clone https://github.com/linux-test-project/ltp.git \
    && cd ltp \
    && make autotools \
    && ./configure \
    && make \
    && make install \
    && cd .. \
    && rm -rf ltp
