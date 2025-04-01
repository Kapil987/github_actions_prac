## Pre-requisite
- Kind or any kubernetes cluster
- Helm
- kubectl

## Kind installation
```bash 
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.27.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
```
Ref: [Kind Official docs](https://kind.sigs.k8s.io/docs/user/quick-start/)

## Helm install
```bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```
Ref: [Helm installation docs](https://helm.sh/docs/intro/install/)

## Kubectl
```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
mkdir -p ~/.local/bin
mv ./kubectl ~/.local/bin/kubectl
```
Note: Post installation you may need to re-login into your current shell

Ref: [Kubectl installation docs](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)

## ARC Runner Setup
>1. [Deploy runner scaleset controller](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners-with-actions-runner-controller/quickstart-for-actions-runner-controller)

```bash
NAMESPACE="arc-systems"
helm install arc \
    --namespace "${NAMESPACE}" \
    --create-namespace \
    oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set-controller

kubectl get po -n arc-systems
kubectl logs pod_name -n arc-systems
```
>2. [Create github app OR create PAT (personal access token) for authentication](https://docs.github.com/en/apps/creating-github-apps/registering-a-github-app/registering-a-github-app)
```bash
kubectl create ns arc-runners
kubectl create secret generic pre-defined-secret \
   --namespace=arc-runners \
   --from-literal=github_token='YOUR-PAT'
kubectl get secrets -n arc-runners
```
>3. Update [values.yaml](https://raw.githubusercontent.com/actions/actions-runner-controller/refs/heads/master/charts/gha-runner-scale-set/values.yaml)
make sure to update `githubConfigUrl` and `githubConfigSecret` in values.yaml

```bash
INSTALLATION_NAME="arc-runner-set"
NAMESPACE="arc-runners"
helm install "${INSTALLATION_NAME}" \
    --namespace "${NAMESPACE}" \
    --create-namespace \
    oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set --values ./values.yaml
```
```bash

```

>3. (Configuring a runner scale set)[https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners-with-actions-runner-controller/quickstart-for-actions-runner-controller#configuring-a-runner-scale-set]
```bash
INSTALLATION_NAME="arc-runner-set"
NAMESPACE="arc-runners"
GITHUB_CONFIG_URL="https://github.com/<your_enterprise/org/repo>"
GITHUB_PAT="<PAT>"
helm install "${INSTALLATION_NAME}" \
    --namespace "${NAMESPACE}" \
    --create-namespace \
    --set githubConfigUrl="${GITHUB_CONFIG_URL}" \
    --set githubConfigSecret.github_token="${GITHUB_PAT}" \
    oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set

```

Ref: https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners-with-actions-runner-controller/quickstart-for-actions-runner-controller

## Troubleshooting
```bash
kubectl delete secret pre-defined-secret --namespace=arc-runners
helm uninstall "${INSTALLATION_NAME}" --namespace "${NAMESPACE}"
helm uninstall arc-runner-set --namespace arc-runners

```
## Python
conda create --name <your_env_name> python=<python_version>