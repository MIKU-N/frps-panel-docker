FROM alpine:3.19.1
LABEL maintainer="Rain <hi@im.ci>"

ENV VERSION 2.0.0
ENV TZ=Asia/Shanghai
WORKDIR /

RUN apk add --no-cache tzdata \
    && ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone

RUN if [ "$(uname -m)" = "x86_64" ]; then export PLATFORM=amd64 ; \
	elif [ "$(uname -m)" = "aarch64" ]; then export PLATFORM=arm64 ; \
	elif [ "$(uname -m)" = "armv7" ]; then export PLATFORM=arm ; \
	elif [ "$(uname -m)" = "armv7l" ]; then export PLATFORM=arm ; \
	elif [ "$(uname -m)" = "armhf" ]; then export PLATFORM=arm ; fi \
	&& wget --no-check-certificate https://github.com/yhl452493373/frps-panel/releases/download/${VERSION}/frps-panel-linux-${PLATFORM}-${VERSION}.zip \
	&& unzip frps-panel-linux-${PLATFORM}-${VERSION}.zip -d frps-panel-linux-${PLATFORM}-${VERSION}  \
	&& cd frps-panel-linux-${PLATFORM}-${VERSION} \
	&& mkdir /frps-panel \
	&& mv frps-panel frps-panel.toml frps-tokens.toml /frps-panel \
	&& cd .. \
	&& rm -rf *.zip frps-panel-linux-${PLATFORM}-${VERSION}

VOLUME /frps-panel

CMD ./frps-panel/frps-panel -c ./frps-panel.toml
