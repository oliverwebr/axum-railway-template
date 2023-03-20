# Axum Railway Demo

Railway axum starter template for Railway

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/template/WOK8Vf?referralCode=qIV4GP)

## Links

- [Railway](https://railway.app/)
- [axum-server](https://crates.io/crates/axum-server)

## Getting Started

To change the name of your application you will need to replace it in a couple of spaces.

- Cargo.toml
  `name = "axum-railway-template"`
- Dockerfile
  Make sure to rename `axum-railway-template` and `axum_railway_template` respectively

## Environment

All environment variables can be defined in a `.env` and be overwritten on demand eg.
`RUST_LOG=DEBUG cargo run`

| Var    | Values                     | Default       |
| ------ | -------------------------- | ------------- |
| `ENV`  | `Production` `Development` | `Development` |
| `PORT` | Int                        | 3000          |

### Log Level

Tracing is setup and uses `DEBUG` level on `Development` and `INFO` level on `Production`
You can change that in your `.env` file and in the Environment Variable section in Railway.
Of course, you can also set them in the command line on demand `RUST_LOG=DEBUG cargo run`

### SocketAddr

For convenience, we set the socket address dynamically depending on the `ENV`.
Because [railway expects the service to start at 0.0.0.0](https://docs.railway.app/deploy/exposing-your-app)

- Production: 0.0.0.0
- Development: 127.0.0.1

## Credits

- The Dockerfile is heavily inspired by [linux-china/axum-demo](https://github.com/linux-china/axum-demo)
