//! Extend octocrab with ability to gather release information


use octocrab::{Octocrab,Page,Result, models};

#[async_trait::async_trait]
trait ReleaseExt {
  async fn get_latest_release(&self) -> Result<Page<models::Organization>>;
}

#[async_trait::async_trait]
impl ReleaseExt for Octocrab {
  async fn get_latest_release(&self) -> Result<Page<models::Organization>>{
    Ok(())
  }
}
