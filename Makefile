CLUSTER_NAME := secret-from-vault
NB_NODES := 1

REGISTRY_NAME := secret-from-vault.localhost
REGISTRY_PORT := 5111


start:
	@bash cluster-init.sh $(CLUSTER_NAME) $(REGISTRY_NAME) $(REGISTRY_PORT) $(NB_NODES)

delete:
	@k3d cluster delete $(CLUSTER_NAME)

cleanup: delete
	@k3d registry delete $(REGISTRY_NAME)

stop:
	@k3d cluster stop $(CLUSTER_NAME) --all
	@docker stop k3d-secret-from-vault.localhost

.PHONY: start delete cleanup stop
