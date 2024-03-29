# Secret from Vault

This repository shows you how to create secret in your cluster from Hashicorp Vault

:warning: Never transform encrypted variable from Vault in base64 encoded data for sensitive values is they are not RBAC'd. You may prefer inject these variables directly in pod where they are needed.


## Prerequisites
![](https://img.shields.io/badge/devspace-6.2.5-informationnal)
![](https://img.shields.io/badge/Helm-3-9cf)
![](https://img.shields.io/badge/docker-20.10.22-blue)
![](https://img.shields.io/badge/k3d-5.4.7-yellow)


## How it works

![](resources/architecture.png)

## How to

1. Create your cluster / install Vault and External-Secret helm chart / configure Vault

    ```bash
    make start
    ```

2. Inject example variable as encrypted key value in Vault

    ```bash
    make kv
    ```

3. Create secret in your cluster from encrypted key value 

    ```bash
    make secret
    ```

## Cleanup your system

1. delete everything in your system about this project
    ```bash
    make cleanup
    ```
