# -----------------------------------------------------------------------------
# Artifactory functions -------------------------------------------------------

function artifactory_upload() {
  local matcher="${1:-*}"
  local repo="${2:-ext-util-sandbox-local}"
  local pattern="$PWD/$matcher"
  local spec_file="/tmp/`date '+%Y%m%d-%H%M%S'`-upload-spec.json"

  jq \
    -n \
    --arg target "$repo" \
    --arg pattern "$pattern" \
    '{files:[{pattern:$pattern,target:$target}]}' > $spec_file

  jfrog rt upload --spec $spec_file
}

function artifactory_download() {
  local matcher="${1:-*}"
  local repo="${2:-util-release}"
  local pattern="$repo/$matcher"
  local spec_file="/tmp/`date '+%Y%m%d-%H%M%S'`-download-spec.json"

  jq \
    -n \
    --arg target "$PWD" \
    --arg repo "$repo" \
    --arg pattern "$pattern" \
    '{files:[{pattern:$pattern,target:$target}]}' > $spec_file

  jfrog rt download --spec $spec_file
}

function artifactory_search() {
  local matcher="${1:-*}"
  local repo="${2:-util-release}"
  local pattern="$repo/$matcher"
  local spec_file="/tmp/`date '+%Y%m%d-%H%M%S'`-download-spec.json"

  jq \
    -n \
    --arg target "$PWD" \
    --arg repo "$repo" \
    --arg pattern "$pattern" \
    '{files:[{pattern:$pattern,target:$target}]}' > $spec_file

  jfrog rt search --spec $spec_file
}
