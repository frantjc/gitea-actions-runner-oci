FROM gitea/act_runner:0.2.11
RUN apk update
RUN apk add --no-cache nodejs
ENV DOCKER_VERSION=27.4.1
RUN set -eux; \
    wget -O docker.tgz https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz; \
    tar --extract \
        --file docker.tgz \
        --strip-components 1 \
        --directory /usr/local/bin/ \
        --no-same-owner \
        'docker/docker'; \
    rm docker.tgz; \
    docker --version
ENV DOCKER_BUILDX_VERSION=27.4.1
RUN set -eux; \
    wget -O docker-buildx https://github.com/docker/buildx/releases/download/v0.19.3/buildx-v0.19.3.linux-amd64; \
	plugin='/usr/local/libexec/docker/cli-plugins/docker-buildx'; \
	mkdir -p "$(dirname "$plugin")"; \
	mv -vT 'docker-buildx' "$plugin"; \
	chmod +x "$plugin"; \
	docker buildx version
