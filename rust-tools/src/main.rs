extern crate serde_json;

use clap::Clap;
use anyhow::Result;

mod github;

#[derive(Clap)]
#[clap(version = "0.1", author = "Nic Patterson <nic@reynn.dev>")]
struct App {
  #[clap(short, long)]
  binary: Option<String>,
}

#[tokio::main]
async fn main() -> Result<()> {
  let app: App = App::parse();
  github::init_github("c379e6723be31767cb639f01fac8b596fe854dc5".into())?;
  if let Some(bin) = app.binary {
    println!("Downloading binary: {}", bin);
    let release_data = github::get_latest_release("rust-analyzer", "rust-analyzer").await?;
    println!("{:#?}", release_data);
  }
  Ok(())
}
