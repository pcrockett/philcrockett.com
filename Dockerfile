FROM docker.io/library/debian:trixie-slim
ARG DEBIAN_FRONTEND=noninteractive
ARG UID=1000
ARG GID=1000
ARG HOME="/home/user"

# don't need to pin apt package versions
# hadolint ignore=DL3008
RUN --mount=target=/var/lib/apt/lists,type=cache,sharing=locked \
    --mount=target=/var/cache/apt,type=cache,sharing=locked \
rm -f /etc/apt/apt.conf.d/docker-clean && \
apt-get update && \
apt-get install --yes --no-install-recommends curl ca-certificates git make extrepo && \
extrepo enable mise && \
apt-get update && \
apt-get install --yes --no-install-recommends mise && \
groupadd --gid "${GID}" user && \
useradd --create-home --uid "${UID}" --gid "${GID}" user

RUN --mount=target=/var/lib/apt/lists,type=cache,sharing=locked \
    --mount=target=/var/cache/apt,type=cache,sharing=locked \
apt-get update && \
apt-get install --yes --no-install-recommends libatomic1

WORKDIR /app
COPY mise.toml mise.lock ./
RUN chown -R user:user /app

USER user

RUN mise trust && mise install

ENV PATH="/home/user/.local/share/pnpm/bin:${PATH}"
RUN \
mise exec -- pnpm config set store-dir ~/.local/share/pnpm/store/v11 --global

ENTRYPOINT [ "mise", "exec", "--" ]
