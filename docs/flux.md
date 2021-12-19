# Flux

## Github Einstellungen

```
export GITHUB_TOKEN="xyz";
flux --kubeconfig=./provision/kubeconfig bootstrap github \
--version=v0.12.1 \
--owner=FalkWinkler \
--repository=k3s-gitops \
--path=cluster/base \
--personal \
--private=false \
--network-policy=false
``` 
