CLUSTER_NAME := secret-from-vault
NB_NODES := 1

REGISTRY_NAME := secret-from-vault.localhost
REGISTRY_PORT := 5111


start:
	@bash cluster-init.sh $(CLUSTER_NAME) $(REGISTRY_NAME) $(REGISTRY_PORT) $(NB_NODES)

forward:
	@kubectl port-forward -n vault pod/vault-0 8200:8200 &

kv:
	@bash secrets.sh kv

secret:
	@bash secrets.sh secret

delete:
	@k3d cluster delete $(CLUSTER_NAME)

cleanup: delete
	@k3d registry delete $(REGISTRY_NAME)

stop:
	@k3d cluster stop $(CLUSTER_NAME) --all
	@docker stop k3d-secret-from-vault.localhost

.PHONY: start forward kv secret delete cleanup stop
