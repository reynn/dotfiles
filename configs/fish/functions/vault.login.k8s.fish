#!/usr/bin/env fish

function vault.login.k8s -d 'Login to a vault instance using a Kubernetes service account'
    function ___usage
        set -l help_args -a 'Login to a vault instance using a Kubernetes service account'
        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case c cluster-name
                set -xg CLUSTER_NAME $value
            case vault-addr
                set -xg VAULT_ADDR $value
            case r role
                set -xg VAULT_ROLE $value
            case n namespace
                set -xg VAULT_NAMESPACE $value
            case a service-account
                set -xg K8S_SA $value
            case k8s-namespace
                set -xg K8S_NAMESPACE $value
            case k8s-context
                set -xg K8S_CONTEXT $value
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

    __log debug "CLUSTER_NAME     : $CLUSTER_NAME"
    __log debug "VAULT_ADDR       : $VAULT_ADDR"
    __log debug "VAULT_ROLE       : $VAULT_ROLE"
    __log debug "VAULT_NAMESPACE  : $VAULT_NAMESPACE"
    __log debug "K8S_SA           : $K8S_SA"
    __log debug "K8S_NAMESPACE    : $K8S_NAMESPACE"
    __log debug "K8S_CONTEXT      : $K8S_CONTEXT"

    if not set -q K8S_SA
        __log error "Must provide a Kubernetes service account name"
    end
    set -l k8s_common
    if set -q K8S_NAMESPACE
        set -a k8s_common -n $K8S_NAMESPACE
    end
    if set -q K8S_CONTEXT
        set -a k8s_common --context $K8S_CONTEXT
    end

    set -x k8s_secret_name (kubectl get sa $k8s_common $K8S_SA -o json | dasel -r json -w plain '.secrets.first().name')
    set -x k8s_sa_token (kubectl get secret $k8s_common $k8s_secret_name -o json | dasel -r json -w plain .data.token | base64 -d)

    __log debug "K8S_SECRET_NAME  : '$k8s_secret_name'"
    __log debug "K8S_SA_TOKEN     : '$k8s_sa_token'"

    set login_payload (echo '{}' | dasel put -r json -t string -v $VAULT_ROLE .role | dasel put --pretty=false -r json -t string -v $k8s_sa_token .jwt)
    __log debug "LOGIN_PAYLOAD    : '$login_payload'"

    set login_result (curl -k -s -H "X-Vault-Namespace: $VAULT_NAMESPACE" -X POST -d $login_payload $VAULT_ADDR/v1/auth/kraken/$CLUSTER_NAME/login)
    __log debug "LOGIN_RESULT     : '$login_result'"
    set -xg VAULT_TOKEN (echo $login_result | dasel -r json -w plain .auth.client_token)
end
