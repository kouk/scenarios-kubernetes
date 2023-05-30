#!/bin/sh

out=$(k get po -o json| jq -r '.items[]|[.metadata.labels.app, (.status.conditions[]|select(.type=="Ready")|.status)]|join(",")')
if [ "$out" != "podinfo,True
podinfo,True" ]; then
   echo pods not ready
   exit 1
fi

for ip in $(k get po -o json|jq -r '.items[]|.status.podIP'); do
  if ! curl -fs $ip:9898/readyz >/dev/null ; then
    echo "pod failed to respond!"
    exit 1
  fi 
  done