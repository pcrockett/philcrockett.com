FROM docker.io/library/debian:12-slim
ARG DEBIAN_FRONTEND=noninteractive

# don't need to pin apt package versions
# hadolint ignore=DL3008
RUN --mount=target=/var/lib/apt/lists,type=cache,sharing=locked \
    --mount=target=/var/cache/apt,type=cache,sharing=locked \
rm -f /etc/apt/apt.conf.d/docker-clean && \
apt-get update && \
apt-get install --yes --no-install-recommends curl ca-certificates git make && \
useradd --create-home user && \
mkdir /app && \
chown -R user:user /app

USER user
WORKDIR /app
COPY .tool-versions package.json package-lock.json .

ENV HOME="/home/user"
ENV ASDF_DIR="${HOME}/.asdf"
ENV PATH="${HOME}/.local/bin:${ASDF_DIR}/shims:${PATH}"

RUN \
curl -SsfL https://philcrockett.com/yolo/v1.sh \
    | bash -s -- asdf && \
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
RUN asdf install
