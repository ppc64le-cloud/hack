# How to Build and Push

```
docker build -t quay.io/powercloud/ltp:latest
docker push quay.io/powercloud/ltp:latest
```

# How to run

## Docker
```
docker run -ti quay.io/powercloud/ltp:latest
```

## Openshift via debug pod

```
# Debug a node as an administrator
# To use host binaries, run `chroot /host`
oc debug node/<node_name> --image=quay.io/powercloud/ltp:latest
```
