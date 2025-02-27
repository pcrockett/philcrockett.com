FROM docker.io/library/debian:12-slim
ARG DEBIAN_FRONTEND=noninteractive
ARG USERNAME=root
ARG UID=0
ARG GID=0
ARG HOME="/root"

# don't need to pin apt package versions
# hadolint ignore=DL3008
RUN --mount=target=/var/lib/apt/lists,type=cache,sharing=locked \
    --mount=target=/var/cache/apt,type=cache,sharing=locked \
rm -f /etc/apt/apt.conf.d/docker-clean && \
apt-get update && \
apt-get install --yes --no-install-recommends curl ca-certificates git make && \
test "${UID}" -eq 0 || groupadd --gid "${GID}" "${USERNAME}" && \
test "${UID}" -eq 0 || useradd --create-home --uid "${UID}" --gid "${GID}" "${USERNAME}" && \
mkdir /app && \
chown -R "${USERNAME}:${USERNAME}" /app

USER ${USERNAME}
WORKDIR /app
COPY .tool-versions package.json package-lock.json .

ENV HOME="${HOME}"
ENV ASDF_DIR="${HOME}/.asdf"
ENV PATH="${HOME}/.local/bin:${ASDF_DIR}/shims:${PATH}"

RUN \
curl -SsfL https://philcrockett.com/yolo/v1.sh \
    | bash -s -- asdf && \
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
RUN asdf install
