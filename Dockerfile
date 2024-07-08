FROM ubuntu:jammy
ARG BUILDER_USER=runner GO_VER=1.21.11 GO_DIR=1.21.11 GORELEASER_VER=v2.0.1 REPO=https://github.com/user/repo.git TAG=0.0.1

RUN apt-get update && \
    apt-get install -y git make wget

RUN set -xe && \
    groupadd -r ${BUILDER_USER} && \
    useradd -m -g ${BUILDER_USER} ${BUILDER_USER} && \
    mkdir /opt/hostedtoolcache && \
    chown ${BUILDER_USER}:${BUILDER_USER} /opt/hostedtoolcache

USER ${BUILDER_USER}
RUN mkdir -p /home/${BUILDER_USER}/work
WORKDIR /home/${BUILDER_USER}

RUN wget -q https://go.dev/dl/go${GO_VER}.linux-amd64.tar.gz && \
    tar -xzf go${GO_VER}.linux-amd64.tar.gz && \
    mkdir -p /opt/hostedtoolcache/go/${GO_DIR} && \
    mv go /opt/hostedtoolcache/go/${GO_DIR}/x64 && \
    rm go${GO_VER}.linux-amd64.tar.gz
ENV PATH="/opt/hostedtoolcache/go/${GO_DIR}/x64/bin:${PATH}"
ENV GOPATH=/home/${BUILDER_USER}/go

RUN wget -q https://github.com/goreleaser/goreleaser/releases/download/${GORELEASER_VER}/goreleaser_Linux_x86_64.tar.gz && \
    mkdir -p /opt/hostedtoolcache/goreleaser && \
    tar -C /opt/hostedtoolcache/goreleaser -xzf goreleaser_Linux_x86_64.tar.gz && \
    rm goreleaser_Linux_x86_64.tar.gz
ENV PATH="/opt/hostedtoolcache/goreleaser:${PATH}"

WORKDIR /home/${BUILDER_USER}/work
RUN git clone -b ${TAG} ${REPO} . && \
    goreleaser build --clean && \
    find ./dist/ -type f -exec sha256sum "{}" +
