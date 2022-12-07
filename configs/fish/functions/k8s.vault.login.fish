function k8s.vault.login --description 'Obtain a vault token using Kubernetes service account'
    set -l vault_namespace
    set -l vault_role
    set -l vault_server
    set -l k8s_sa default

    function ___usage
        set -l help_args -a "Show a list of pods for a Kubernetes namespace"
        set -a help_args -a "n|namespace|Vault namespace to use|"
        set -a help_args -a "r|role|Vault role to use|"
        set -a help_args -a "s|server|Vault server to authenticate with|"
        set -a help_args -a "|k8s-context|Kubernetes context to use to get the Service Account token|"
        set -a help_args -a "|k8s-service-account|Kubernetes service account to get token of|"
        set -a help_args -a "|k8s-cluster|Cluster name to use as part of the vault auth path|"

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case n namespace
                set vault_namespace $value
            case r role
                set vault_role $value
            case s server
                set vault_server $value
            case k8s-context
                set k8s_context $value
            case k8s-service-account
                set k8s_sa $value
            case k8s-cluster
                set k8s_cluster $value
                # Common args
            case h help
                ___usage
                return 0
            case q quiet
                set -x QUIET true
            case v verbose
                set -x DEBUG true
        end
    end
    set -q VAULT_NAMESPACE; and set vault_namespace $VAULT_NAMESPACE
    set -q VAULT_ROLE; and set vault_role $VAULT_ROLE
    set -q VAULT_ADDR; and set vault_server $VAULT_ADDR

    __log debug "Vault Namespace     : $vault_namespace"
    __log debug "Vault Role          : $vault_role"
    __log debug "Vault Server        : $vault_server"
    __log debug "K8S Context         : $k8s_context"
    __log debug "K8S Service Account : $k8s_sa"
    if test -z "$vault_namespace"
        __log error "No `vault-namespace` provided or set as `VAULT_NAMESPACE`"
        return 1
    end
    if test -z "$vault_server"
        __log error "No `vault-server` provided or set as `VAULT_ADDR`"
        return 1
    end
    if test -z "$vault_role"
        __log error "No `vault-role` provided or set as `VAULT_ROLE`"
        return 1
    end
    if test -z "$k8s_context"
        __log error "No `k8s-context` provided"
        return 1
    end
    if test -z "$k8s_cluster"
        __log error "No `k8s-cluster` provided"
        return 1
    end

    set K8S_SA_TOKEN (kubectl get --context $k8s_context secret (kubectl get --context $k8s_context sa $k8s_sa -o json | jq -r .secrets[0].name) -o json | jq -r .data.token | base64 -d)
    __log debug "K8S_SA_TOKEN: $K8S_SA_TOKEN"

    set LOGIN_PAYLOAD (echo '{}' | dasel put -r json -t string -v $VAULT_ROLE .role | dasel put --pretty=false -r json -t string -v $K8S_SA_TOKEN .jwt)
    __log debug "Login Payload: $LOGIN_PAYLOAD"
    set login_response (curl -k -s -H "X-Vault-Namespace: $vault_namespace" -X POST -d $LOGIN_PAYLOAD $vault_server/v1/auth/kraken/$k8s_cluster/login)
    __log debug "Login Response: $login_response"
    set -xg VAULT_TOKEN (echo $login_response | dasel select --plain -r json '.auth.client_token')
    __log "vault token has been set to `$VAULT_TOKEN`"
end
