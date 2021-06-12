FROM dlang2/ldc-ubuntu:1.26.0 as build

ADD . /source
WORKDIR /source

RUN apt -y install git && \
	git submodule update --init --recursive && \
	./release.sh && \
	strip ./bin/dscanner

FROM busybox

MAINTAINER "DLang Community <community@dlang.io>"

COPY --from=build /source/bin/dscanner /dscanner
RUN chmod +x /dscanner

WORKDIR /src

ENTRYPOINT [ "/dscanner" ]
