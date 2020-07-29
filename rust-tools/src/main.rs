extern crate serde_json;

use anyhow::Result;
use clap::{crate_authors, crate_name, crate_version, Clap};
use directories_next::{BaseDirs, ProjectDirs, UserDirs};
use hubcaps::{
    releases::{Asset, Release},
    Credentials, Github,
};
use lazy_static::lazy_static;
use log::*;
use regex::Regex;
use skim::prelude::*;

use std::io::Cursor;

// lazy_static!{
//   static BASE_OUTPUT_PATH: String = ProjectDirs::new().unwrap()
// }

cfg_if::cfg_if! {
    if #[cfg(any(target_os = "macos", target_os = "ios"))] {
      fn os_filter(r: &Asset) -> Option<String> {
        lazy_static!{
            static ref RE: Regex = Regex::new("^.+?(darwin|macosx|macos|osx).+$").unwrap();
        }
        if RE.is_match(r.name.as_str()) {
          Some(String::from(r.browser_download_url.as_str()))
        } else {
          None
        }
      }
    } else {
      fn os_filter(r: &Asset) -> Option<String> {
        lazy_static!{
            static ref RE: Regex = Regex::new("^.+?(linux64|linux).+$").unwrap();
        }
        if RE.is_match(r.name.as_str()) {
          Some(String::from(r.browser_download_url.as_str()))
        } else {
          None
        }
      }
    }
}

#[derive(Debug, Clone)]
struct Downloadable {
    version: String,
    name: String,
    url: String,
}

impl From<&Release> for Downloadable {
    fn from(r: &Release) -> Self {
        let url: String = r
            .assets
            .as_slice()
            .into_iter()
            .filter_map(|r| os_filter(r))
            .collect();
        Self {
            version: String::from(r.tag_name.as_str()),
            name: String::from(r.name.as_str()),
            url,
        }
    }
}

#[derive(Clap, Debug)]
#[clap(version = crate_version!(), author = crate_authors!())]
struct Config {
    #[clap(short = "o", long = "owner")]
    owner: String,
    #[clap(short = "r", long = "repo")]
    repo: String,
    #[clap(long = "output_path")]
    output_path: Option<String>,
    #[clap(short = "p", long = "pre-release")]
    pre_release: bool,
    #[clap(short = "i", long = "interactive")]
    interactive: bool,
    #[clap(short = "t", long = "token")]
    token: Option<String>,
    #[clap(short = "v", long = "verbose")]
    verbose: bool,
}

#[tokio::main]
async fn main() -> Result<()> {
    let agent_name = format!("reynn/{}:{}", crate_name!(), crate_version!());
    let config: Config = Config::parse();
    let log_level = if config.verbose {
        log::LevelFilter::Debug
    } else {
        log::LevelFilter::Info
    };
    setup_logging(log_level)?;

    debug!("{}: Config: {:?}", agent_name, config);

    let github = if let Some(token) = config.token {
        Github::new(agent_name, Credentials::Token(token))?
    } else {
        Github::new(agent_name, None)?
    };

    let downloadables = if config.interactive {
        interactive_select(config.owner, config.repo, &github).await?
    } else {
        let latest_release = github
            .repo(config.owner, config.repo)
            .releases()
            .latest()
            .await?;
        debug!("Assets: {:#?}", latest_release);
        vec![Downloadable::from(&latest_release)]
    };

    info!("Versions to download = {:#?}", downloadables);

    download_binaries(config.output_path, downloadables).await?;

    Ok(())
}

async fn download_binaries(
    out_path: Option<String>,
    downloadables: Vec<Downloadable>,
) -> Result<()> {
    Ok(())
}

async fn interactive_select(
    org: String,
    repo: String,
    github: &Github,
) -> Result<Vec<Downloadable>> {
    let options = SkimOptionsBuilder::default()
        .height(Some("50%"))
        .multi(true)
        .build()
        .unwrap();

    info!("Getting versions for {}/{}", org, repo);

    let releases = github.repo(org, repo).releases().list().await?;

    let assets: Vec<Downloadable> = releases.iter().map(|r| Downloadable::from(r)).collect();

    debug!("{:#?}", assets);

    let versions = assets
        .iter()
        .map(|d| String::from(d.version.as_str()))
        .collect::<Vec<String>>()
        .join("\n")
        .to_string();

    // `SkimItemReader` is a helper to turn any `BufRead` into a stream of `SkimItem`
    // `SkimItem` was implemented for `AsRef<str>` by default
    let item_reader = SkimItemReader::default();
    let items = item_reader.of_bufread(Cursor::new(versions));

    // `run_with` would read and show items from the stream
    let selected_items: Vec<String> = Skim::run_with(&options, Some(items))
        .map(|out| out.selected_items)
        .unwrap_or_else(|| Vec::new())
        .iter()
        .map(|item| item.text().to_string())
        .collect();

    let mut downloadables = Vec::new();

    for item in selected_items.into_iter() {
        for asset in assets.iter() {
            if item == asset.version {
                downloadables.push(asset.to_owned())
            }
        }
    }

    Ok(downloadables)
}

fn setup_logging(lvl: log::LevelFilter) -> Result<()> {
    fern::Dispatch::new()
        // Perform allocation-free log formatting
        .format(|out, message, record| {
            out.finish(format_args!(
                "{}[{}][{}] {}",
                chrono::Local::now().format("[%Y-%m-%d][%H:%M:%S]"),
                record.target(),
                record.level(),
                message
            ))
        })
        // Add blanket level filter -
        .level(lvl)
        // Output to stdout, files, and other Dispatch configurations
        .chain(std::io::stdout())
        // Configly globally
        .apply()?;
    Ok(())
}
