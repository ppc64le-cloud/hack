# LTP - Linux Test Project

Linux Test Project project goal is to deliver tests to the open source community that validate the reliability, robustness, and stability of Linux.

For more information - https://github.com/linux-test-project/ltp

The content here published is focusing running it in the containers.

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
