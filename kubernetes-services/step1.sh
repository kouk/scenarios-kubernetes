#!/bin/sh
set -ex
echo "checking pod readiness"
out=$(kubectl get po -o json| jq -r '.items[]|[.metadata.labels.app, (.status.conditions[]|select(.type=="Ready")|.status)]|join(",")')
if [ "$out" != "podinfo,True
podinfo,True" ]; then
   echo pods not ready
   exit 1
fi

echo "hitting pod with probe"
for ip in $(kubectl get po -o json|jq -r '.items[]|.status.podIP'); do
  if ! curl -fs $ip:9898/readyz >/dev/null ; then
    echo "pod failed to respond!"
    exit 1
  fi 
done



echo "hitting svc with probe"
ip=$(kubectl get svc -l nerd=someone -o go-template='{{ (index .items 0).spec.clusterIP }}')
curl -fs $ip:9898
