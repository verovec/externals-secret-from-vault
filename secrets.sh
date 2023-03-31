#!/bin/bash

# Vault configuration
VAULT_UNSEAL_KEY=$(cat vault-keys.json | jq -r ".unseal_keys_b64[]")
VAULT_ROOT_KEY=$(cat vault-keys.json | jq -r ".root_token")
kubectl exec vault-0 -n vault -- vault operator unseal $VAULT_UNSEAL_KEY

if [[ "$1" = "kv" ]]; then
    # Key Value injection
    kubectl exec vault-0 -n vault -- /bin/sh -c "VAULT_TOKEN=$VAULT_ROOT_KEY vault secrets enable -version=2 kv"
    kubectl exec vault-0 -n vault -- /bin/sh -c "VAULT_TOKEN=$VAULT_ROOT_KEY vault kv put kv/example secret-exemple=my_value"
elif [[ "$1" = "secret" ]]; then
    # Vault secrets accessibility
    kubectl create secret generic vault-token -n default --from-literal=token=$VAULT_ROOT_KEY
    echo "INFO: Wait for external secret webhook get ready..."
    kubectl rollout status -n external-secrets deployment external-secrets-webhook;
    kubectl apply -f k8s/external-secrets/secret-store.yaml
    kubectl apply -f k8s/external-secrets/external-secrets.yaml
fi;
