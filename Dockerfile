FROM debian:buster-slim

RUN apt-get -y update && \
	apt-get install -y \
		libmicrohttpd-dev \
		libjansson-dev \
		libssl-dev \
		libsofia-sip-ua-dev \
		libglib2.0-dev \
		libopus-dev \
		libogg-dev \
		libcurl4-openssl-dev \
		liblua5.3-dev \
		libconfig-dev \
		libusrsctp-dev \
		libwebsockets-dev \
		libnanomsg-dev \
		librabbitmq-dev \
		pkg-config \
		gengetopt \
		libtool \
		automake \
		build-essential \
		wget \
		git \
		gtk-doc-tools && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*


RUN cd /tmp && \
	wget https://github.com/cisco/libsrtp/archive/v2.3.0.tar.gz && \
	tar xfv v2.3.0.tar.gz && \
	cd libsrtp-2.3.0 && \
	./configure --prefix=/usr --enable-openssl && \
	make shared_library && \
	make install

RUN cd /tmp && \
	git clone https://gitlab.freedesktop.org/libnice/libnice && \
	cd libnice && \
	./autogen.sh && \
	./configure --prefix=/usr && \
	make && \
	make install

COPY . /usr/local/src/janus-gateway

RUN cd /usr/local/src/janus-gateway && \
	sh autogen.sh && \
	./configure --prefix=/usr/local && \
	make && \
	make install && \
	make configs

FROM debian:buster-slim

RUN apt-get -y update && \
	apt-get install -y \
		libmicrohttpd12 \
		libjansson4 \
		libssl1.1 \
		libsofia-sip-ua0 \
		libglib2.0-0 \
		libopus0 \
		libogg0 \
		libcurl4 \
		liblua5.3-0 \
		libconfig9 \
		libusrsctp1 \
		libwebsockets8 \
		libnanomsg5 \
		librabbitmq4 && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

COPY --from=0 /usr/local/bin/janus /usr/local/bin/janus
COPY --from=0 /usr/local/bin/janus-cfgconv /usr/local/bin/janus-cfgconv
COPY --from=0 /usr/local/etc/janus /usr/local/etc/janus
COPY --from=0 /usr/local/lib/janus /usr/local/lib/janus
COPY --from=0 /usr/local/share/janus /usr/local/share/janus
COPY --from=0 /usr/lib/libsrtp2.so /usr/lib/libsrtp2.so
COPY --from=0 /usr/lib/libsrtp2.so.1 /usr/lib/libsrtp2.so.1
COPY --from=0 /usr/lib/libnice.la /usr/lib/libnice.la
COPY --from=0 /usr/lib/libnice.so /usr/lib/libnice.so
COPY --from=0 /usr/lib/libnice.so.10 /usr/lib/libnice.so.10
COPY --from=0 /usr/lib/libnice.so.10.9.0 /usr/lib/libnice.so.10.9.0

EXPOSE 10000-10200/udp
EXPOSE 8088
EXPOSE 8089
EXPOSE 8889
EXPOSE 8000
EXPOSE 7088
EXPOSE 7089

CMD ["/usr/local/bin/janus"]
