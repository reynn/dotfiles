use anyhow::Result;
use octocrab;

#[derive(Debug)]
pub struct ReleaseInfo {
    owner: String,
    repo: String,
    latest_version: String,
    assets: Vec<String>,
}

pub fn init_github(token: String) -> Result<()> {
  let builder = octocrab::OctocrabBuilder::new().personal_token(token);
  octocrab::initialise(builder)?;
  Ok(())
}

pub async fn get_latest_release(owner: &str, repo: &str) -> Result<ReleaseInfo> {
    let info = ReleaseInfo {
        latest_version: "".into(),
        assets: Vec::new(),
        owner: owner.into(),
        repo: repo.into(),
    };
    let response: serde_json::Value = octocrab::instance().graphql(r#"{
      repository(owner: "rust-analyzer", name: "rust-analyzer") {
        releases(first: 5, orderBy: {field: CREATED_AT, direction: DESC}) {
          nodes {
            name
            releaseAssets(first: 20) {
              nodes {
                downloadUrl
                name
              }
            }
          }
        }
      }
    }
    "#).await?;
    println!("octocrab Response: {:?}", response);
    Ok(info)
}
