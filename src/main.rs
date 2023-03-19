mod config;

use config::Configuration;

use axum::{http::StatusCode, response::IntoResponse, routing::get, Router};
use dotenvy::dotenv;
use std::net::SocketAddr;

#[tokio::main]
async fn main() {
    // Parse dotenv files and expose them as environment variables
    dotenv().ok();

    // envy uses our Configuration struct to parse environment variables
    let config = envy::from_env::<Configuration>().expect("Please provide PORT env var");

    // initialize tracing
    tracing_subscriber::fmt()
        // With the log_level from our config
        .with_max_level(config.log_level())
        .init();

    // build our application with a route
    let app = Router::new().route("/", get(root_handler));

    // run our app with hyper
    // `axum::Server` is a re-export of `hyper::Server`
    let addr = SocketAddr::from((config.socket_addr(), config.port));

    axum::Server::bind(&addr)
        .serve(app.into_make_service())
        .await
        .unwrap();
}

async fn root_handler() -> impl IntoResponse {
    (StatusCode::OK, "Hello World!")
}
