
> Let's run a demo service called `podinfo`.
<br>
> bla bla .

Deploy the service:

```plain
kubectl apply -f /root/podinfo.yaml
```{{exec}}

And wait for it to start up:

```plain
kubectl rollout status -f /root/podinfo.yaml
```{{exec}}

Then create a service:

```plain
kubectl expose -f podinfo.yml  --dry-run -o yaml
```{{exec}}

Actually do it:

```plain
kubectl expose -f podinfo.yml
```{{exec}}


Next we need to run port-forward:

```plain
kubectl port-forward service/podinfo 9898:9898 --address 0.0.0.0
```{{exec}}

Now check the service:

[ACCESS PODINFO]({{TRAFFIC_HOST1_9898}})