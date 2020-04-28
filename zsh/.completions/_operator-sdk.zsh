#compdef _operator-sdk operator-sdk


function _operator-sdk {
  local -a commands

  _arguments -C \
    '--verbose[Enable verbose logging]' \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "add:Adds a controller or resource to the project"
      "alpha:Run an alpha subcommand"
      "build:Compiles code and builds artifacts"
      "bundle:Work with operator bundle metadata and bundle images"
      "cleanup:Delete and clean up after a running Operator"
      "completion:Generators for shell completions"
      "generate:Invokes a specific generator"
      "help:Help about any command"
      "migrate:Adds source code to an operator"
      "new:Creates a new operator application"
      "olm:Manage the Operator Lifecycle Manager installation in your cluster"
      "print-deps:Print Golang packages and versions required to run the operator"
      "run:Run an Operator in a variety of environments"
      "scorecard:Run scorecard tests"
      "test:Tests the operator"
      "version:Prints the version of operator-sdk"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  add)
    _operator-sdk_add
    ;;
  alpha)
    _operator-sdk_alpha
    ;;
  build)
    _operator-sdk_build
    ;;
  bundle)
    _operator-sdk_bundle
    ;;
  cleanup)
    _operator-sdk_cleanup
    ;;
  completion)
    _operator-sdk_completion
    ;;
  generate)
    _operator-sdk_generate
    ;;
  help)
    _operator-sdk_help
    ;;
  migrate)
    _operator-sdk_migrate
    ;;
  new)
    _operator-sdk_new
    ;;
  olm)
    _operator-sdk_olm
    ;;
  print-deps)
    _operator-sdk_print-deps
    ;;
  run)
    _operator-sdk_run
    ;;
  scorecard)
    _operator-sdk_scorecard
    ;;
  test)
    _operator-sdk_test
    ;;
  version)
    _operator-sdk_version
    ;;
  esac
}


function _operator-sdk_add {
  local -a commands

  _arguments -C \
    '--verbose[Enable verbose logging]' \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "api:Adds a new api definition under pkg/apis"
      "controller:Adds a new controller pkg"
      "crd:Adds a Custom Resource Definition (CRD) and the Custom Resource (CR) files"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  api)
    _operator-sdk_add_api
    ;;
  controller)
    _operator-sdk_add_controller
    ;;
  crd)
    _operator-sdk_add_crd
    ;;
  esac
}

function _operator-sdk_add_api {
  _arguments \
    '--api-version[Kubernetes APIVersion that has a format of $GROUP_NAME/$VERSION (e.g app.example.com/v1alpha1)]:' \
    '--crd-version[CRD version to generate]:' \
    '--kind[Kubernetes resource Kind name. (e.g AppService)]:' \
    '--skip-generation[Skip generation of deepcopy and OpenAPI code and OpenAPI CRD specs]' \
    '--verbose[Enable verbose logging]'
}

function _operator-sdk_add_controller {
  _arguments \
    '--api-version[Kubernetes APIVersion that has a format of $GROUP_NAME/$VERSION (e.g app.example.com/v1alpha1)]:' \
    '--custom-api-import[The External API import path of the form "host.com/repo/path[=import_identifier]" Note that import_identifier is optional. ( E.g. --custom-api-import=k8s.io/api/apps )]:' \
    '--kind[Kubernetes resource Kind name. (e.g AppService)]:' \
    '--verbose[Enable verbose logging]'
}

function _operator-sdk_add_crd {
  _arguments \
    '--api-version[Kubernetes apiVersion and has a format of $GROUP_NAME/$VERSION (e.g app.example.com/v1alpha1)]:' \
    '--crd-version[CRD version to generate]:' \
    '--kind[Kubernetes CustomResourceDefintion kind. (e.g AppService)]:' \
    '--verbose[Enable verbose logging]'
}


function _operator-sdk_alpha {
  local -a commands

  _arguments -C \
    '--verbose[Enable verbose logging]' \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  esac
}

function _operator-sdk_build {
  _arguments \
    '--go-build-args[Extra Go build arguments as one string such as "-ldflags -X=main.xyz=abc"]:' \
    '--image-build-args[Extra image build arguments as one string such as "--build-arg https_proxy=$https_proxy"]:' \
    '--image-builder[Tool to build OCI images. One of: [docker, podman, buildah]]:' \
    '--verbose[Enable verbose logging]'
}


function _operator-sdk_bundle {
  local -a commands

  _arguments -C \
    '--verbose[Enable verbose logging]' \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "create:Create an operator bundle image"
      "validate:Validate an operator bundle image"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  create)
    _operator-sdk_bundle_create
    ;;
  validate)
    _operator-sdk_bundle_validate
    ;;
  esac
}

function _operator-sdk_bundle_create {
  _arguments \
    '(-c --channels)'{-c,--channels}'[The comma-separated list of channels that bundle image belongs to]:' \
    '(-e --default-channel)'{-e,--default-channel}'[The default channel for the bundle image]:' \
    '(-d --directory)'{-d,--directory}'[The directory where bundle manifests are located, ex. <project-root>/deploy/olm-catalog/test-operator/0.1.0]:' \
    '(-g --generate-only)'{-g,--generate-only}'[Generate metadata/, manifests/ and a Dockerfile on disk without building the bundle image]' \
    '(-b --image-builder)'{-b,--image-builder}'[Tool to build container images. One of: [docker, podman, buildah]]:' \
    '(-o --output-dir)'{-o,--output-dir}'[Optional output directory for operator manifests]:' \
    '--overwrite[Overwrite bundle.Dockerfile, manifests and metadata dirs if they exist. If --output-dir is also set, the original files will not be overwritten]' \
    '(-p --package)'{-p,--package}'[The name of the package that bundle image belongs to. Set if package name differs from project name]:' \
    '(-t --tag)'{-t,--tag}'[The path of a registry to pull from, image name and its tag that present the bundle image (e.g. quay.io/test/test-operator:v0.1.0)]:' \
    '--verbose[Enable verbose logging]'
}

function _operator-sdk_bundle_validate {
  _arguments \
    '(-b --image-builder)'{-b,--image-builder}'[Tool to extract container images. One of: [docker, podman]]:' \
    '--verbose[Enable verbose logging]'
}

function _operator-sdk_cleanup {
  _arguments \
    '--kubeconfig[The file path to kubernetes configuration file. Defaults to location specified by $KUBECONFIG, or to default file rules if not set]:' \
    '--namespace[(Deprecated: use --operator-namespace instead.) The namespace from which operator and namespacesresources are cleaned up]:' \
    '--olm[The operator to be cleaned up is managed by OLM in a cluster. Cannot be set with another cleanup-type flag]' \
    '--olm-namespace[[olm only] The namespace where OLM is installed]:' \
    '--operator-namespace[[olm only] The namespace where operator resources are created. It must already exist in the cluster or be defined in a manifest passed to --include]:' \
    '--manifests[[olm only] Directory containing operator bundle directories and metadata]:' \
    '--operator-version[[olm only] Version of operator to deploy]:' \
    '--install-mode[[olm only] InstallMode to create OperatorGroup with. Format: InstallModeType=[ns1,ns2[, ...]]]:' \
    '*--include[[olm only] Path to Kubernetes resource manifests, ex. Role, Subscription. These supplement or override defaults generated by run/cleanup]:' \
    '--timeout[[olm only] Time to wait for the command to complete before failing]:' \
    '--verbose[Enable verbose logging]'
}


function _operator-sdk_completion {
  local -a commands

  _arguments -C \
    '--verbose[Enable verbose logging]' \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "bash:Generate bash completions"
      "zsh:Generate zsh completions"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  bash)
    _operator-sdk_completion_bash
    ;;
  zsh)
    _operator-sdk_completion_zsh
    ;;
  esac
}

function _operator-sdk_completion_bash {
  _arguments \
    '--verbose[Enable verbose logging]'
}

function _operator-sdk_completion_zsh {
  _arguments \
    '(-h --help)'{-h,--help}'[help for zsh]' \
    '--verbose[Enable verbose logging]'
}


function _operator-sdk_generate {
  local -a commands

  _arguments -C \
    '--verbose[Enable verbose logging]' \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "crds:Generates CRDs for API's"
      "csv:Generates a ClusterServiceVersion YAML file for the operator"
      "k8s:Generates Kubernetes code for custom resource"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  crds)
    _operator-sdk_generate_crds
    ;;
  csv)
    _operator-sdk_generate_csv
    ;;
  k8s)
    _operator-sdk_generate_k8s
    ;;
  esac
}

function _operator-sdk_generate_crds {
  _arguments \
    '--crd-version[CRD version to generate]:' \
    '--verbose[Enable verbose logging]'
}

function _operator-sdk_generate_csv {
  _arguments \
    '--apis-dir[Project relative path to root directory for API type defintions]:' \
    '--crd-dir[Project relative path to root directory for CRD and CR manifests]:' \
    '--csv-version[Semantic version of the CSV. This flag must be set if a package manifest exists]:' \
    '--deploy-dir[Project relative path to root directory for operator manifests (Deployment and RBAC)]:' \
    '--make-manifests[When set, the generator will create or update a CSV manifest in a '\''manifests'\'' directory. This directory is intended to be used for your latest bundle manifests. The default location is deploy/olm-catalog/<operator-name>/manifests. If --output-dir is set, the directory will be <output-dir>/manifests]' \
    '--operator-name[Operator name to use while generating CSV]:' \
    '--output-dir[Base directory to output generated CSV. If --make-manifests=false the resulting CSV bundle directory will be <output-dir>/olm-catalog/<operator-name>/<csv-version>. If --make-manifests=true, the bundle directory will be <output-dir>/manifests]:' \
    '--update-crds[Update CRD manifests in deploy/<operator-name>/<csv-version> from the default CRDs dir deploy/crds or --crd-dir if set. If --make-manifests=false, this option is false by default]' \
    '--verbose[Enable verbose logging]'
}

function _operator-sdk_generate_k8s {
  _arguments \
    '--verbose[Enable verbose logging]'
}

function _operator-sdk_help {
  _arguments \
    '--verbose[Enable verbose logging]'
}

function _operator-sdk_migrate {
  _arguments \
    '--header-file[Path to file containing headers for generated Go files. Copied to hack/boilerplate.go.txt]:' \
    '--repo[Project repository path. Used as the project'\''s Go import path. This must be set if outside of $GOPATH/src (e.g. github.com/example-inc/my-operator)]:' \
    '--verbose[Enable verbose logging]'
}

function _operator-sdk_new {
  _arguments \
    '--api-version[Kubernetes apiVersion and has a format of $GROUP_NAME/$VERSION (e.g app.example.com/v1alpha1) - used with "ansible" or "helm" types]:' \
    '--crd-version[CRD version to generate (Only used for --type=ansible|helm)]:' \
    '--generate-playbook[Generate a playbook skeleton. (Only used for --type ansible)]' \
    '--git-init[Initialize the project directory as a git repository (default false)]' \
    '--header-file[Path to file containing headers for generated Go files. Copied to hack/boilerplate.go.txt]:' \
    '--helm-chart[Initialize helm operator with existing helm chart (<URL>, <repo>/<name>, or local path)]:' \
    '--helm-chart-repo[Chart repository URL for the requested helm chart]:' \
    '--helm-chart-version[Specific version of the helm chart (default is latest version)]:' \
    '--kind[Kubernetes CustomResourceDefintion kind. (e.g AppService) - used with "ansible" or "helm" types]:' \
    '--repo[Project repository path for Go operators. Used as the project'\''s Go import path. This must be set if outside of $GOPATH/src (e.g. github.com/example-inc/my-operator)]:' \
    '--skip-validation[Do not validate the resulting project'\''s structure and dependencies. (Only used for --type go)]' \
    '--type[Type of operator to initialize (choices: "go", "ansible" or "helm")]:' \
    '--vendor[Use a vendor directory for dependencies]' \
    '--verbose[Enable verbose logging]'
}


function _operator-sdk_olm {
  local -a commands

  _arguments -C \
    '--verbose[Enable verbose logging]' \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "install:Install Operator Lifecycle Manager in your cluster"
      "status:Get the status of the Operator Lifecycle Manager installation in your cluster"
      "uninstall:Uninstall Operator Lifecycle Manager from your cluster"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  install)
    _operator-sdk_olm_install
    ;;
  status)
    _operator-sdk_olm_status
    ;;
  uninstall)
    _operator-sdk_olm_uninstall
    ;;
  esac
}

function _operator-sdk_olm_install {
  _arguments \
    '--timeout[time to wait for the command to complete before failing]:' \
    '--version[version of OLM resources to install]:' \
    '--verbose[Enable verbose logging]'
}

function _operator-sdk_olm_status {
  _arguments \
    '--olm-namespace[namespace where OLM is installed]:' \
    '--timeout[time to wait for the command to complete before failing]:' \
    '--verbose[Enable verbose logging]'
}

function _operator-sdk_olm_uninstall {
  _arguments \
    '--timeout[time to wait for the command to complete before failing]:' \
    '--verbose[Enable verbose logging]'
}

function _operator-sdk_print-deps {
  _arguments \
    '--verbose[Enable verbose logging]'
}

function _operator-sdk_run {
  _arguments \
    '--kubeconfig[The file path to kubernetes configuration file. Defaults to location specified by $KUBECONFIG, or to default file rules if not set]:' \
    '--namespace[(Deprecated: use --watch-namespace instead.)The namespace where the operator watches for changes.]:' \
    '--olm[The operator to be run will be managed by OLM in a cluster. Cannot be set with another run-type flag]' \
    '--olm-namespace[[olm only] The namespace where OLM is installed]:' \
    '--operator-namespace[[olm only] The namespace where operator resources are created. It must already exist in the cluster or be defined in a manifest passed to --include]:' \
    '--manifests[[olm only] Directory containing operator bundle directories and metadata]:' \
    '--operator-version[[olm only] Version of operator to deploy]:' \
    '--install-mode[[olm only] InstallMode to create OperatorGroup with. Format: InstallModeType=[ns1,ns2[, ...]]]:' \
    '*--include[[olm only] Path to Kubernetes resource manifests, ex. Role, Subscription. These supplement or override defaults generated by run/cleanup]:' \
    '--timeout[[olm only] Time to wait for the command to complete before failing]:' \
    '--local[The operator will be run locally by building the operator binary with the ability to access a kubernetes cluster using a kubeconfig file. Cannot be set with another run-type flag.]' \
    '--watch-namespace[[local only] The namespace where the operator watches for changes. Set "" for AllNamespaces, set "ns1,ns2" for MultiNamespace]:' \
    '--operator-flags[[local only] The flags that the operator needs. Example: "--flag1 value1 --flag2=value2"]:' \
    '--go-ldflags[[local only] Set Go linker options]:' \
    '--enable-delve[[local only] Start the operator using the delve debugger]' \
    '--verbose[Enable verbose logging]'
}

function _operator-sdk_scorecard {
  _arguments \
    '(-b --bundle)'{-b,--bundle}'[OLM bundle directory path, when specified runs bundle validation]:' \
    '--config[config file (default is '\''<project_dir>/.osdk-scorecard.yaml'\''; the config file'\''s extension and format must be .yaml]:' \
    '--kubeconfig[Path to kubeconfig of custom resource created in cluster]:' \
    '(-L --list)'{-L,--list}'[If true, only print the test names that would be run based on selector filtering]' \
    '(-o --output)'{-o,--output}'[Output format for results. Valid values: text, json]:' \
    '(-l --selector)'{-l,--selector}'[selector (label query) to filter tests on]:' \
    '--version[scorecard version. Valid values: v1alpha2]:' \
    '--verbose[Enable verbose logging]'
}


function _operator-sdk_test {
  local -a commands

  _arguments -C \
    '--verbose[Enable verbose logging]' \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "local:Run End-To-End tests locally"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  local)
    _operator-sdk_test_local
    ;;
  esac
}

function _operator-sdk_test_local {
  _arguments \
    '--debug[Enable debug-level logging]' \
    '--global-manifest[Path to manifest for Global resources (e.g. CRD manifests)]:' \
    '--go-test-flags[Additional flags to pass to go test]:' \
    '--image[Use a different operator image from the one specified in the namespaced manifest]:' \
    '--kubeconfig[Kubeconfig path]:' \
    '--local-operator-flags[The flags that the operator needs (while using --up-local). Example: "--flag1 value1 --flag2=value2"]:' \
    '--molecule-test-flags[Additional flags to pass to molecule test]:' \
    '--namespace[(Deprecated: use --operator-namespace instead) If non-empty, single namespace to run tests in]:' \
    '--namespaced-manifest[Path to manifest for per-test, namespaced resources (e.g. RBAC and Operator manifest)]:' \
    '--no-setup[Disable test resource creation]' \
    '--operator-namespace[Namespace where the operator will be deployed, CRs will be created and tests will be executed (By default it will be in the default namespace defined in the kubeconfig)]:' \
    '--skip-cleanup-error[If set as true, the cleanup function responsible to remove all artifacts will be skipped if an error is faced.]' \
    '--up-local[Enable running operator locally with go run instead of as an image in the cluster]' \
    '--watch-namespace[(only valid with --up-local) Namespace where the operator watches for changes. Set "" for AllNamespaces, set "ns1,ns2" for MultiNamespace(if not set then watches Operator Namespace]:' \
    '--verbose[Enable verbose logging]'
}

function _operator-sdk_version {
  _arguments \
    '--verbose[Enable verbose logging]'
}
