# Build Stage
FROM rust:1.68.0 as builder

RUN USER=root cargo new --bin axum-railway-template
WORKDIR ./axum-railway-template
ENV CARGO_REGISTRIES_CRATES_IO_PROTOCOL=sparse
COPY ./Cargo.toml ./Cargo.toml
# Build empty app with downloaded dependencies to produce a stable image layer for next build
RUN cargo build --release

# Build web app with own code
RUN rm src/*.rs
ADD . ./
RUN rm ./target/release/deps/axum_railway_template*
RUN cargo build --release


FROM debian:buster-slim
ARG APP=/usr/src/app

RUN apt-get update \
    && apt-get install -y ca-certificates tzdata \
    && rm -rf /var/lib/apt/lists/*

ENV TZ=Etc/UTC \
    APP_USER=appuser

RUN groupadd $APP_USER \
    && useradd -g $APP_USER $APP_USER \
    && mkdir -p ${APP}

COPY --from=builder /axum-railway-template/target/release/axum-railway-template ${APP}/axum-railway-template

RUN chown -R $APP_USER:$APP_USER ${APP}

USER $APP_USER
WORKDIR ${APP}

EXPOSE 3000
ENV PORT 3000


CMD ["./axum-railway-template"]
