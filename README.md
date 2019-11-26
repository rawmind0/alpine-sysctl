[![](https://images.microbadger.com/badges/image/rawmind/alpine-sysctl.svg)](https://microbadger.com/images/rawmind/alpine-sysctl "Get your own image badge on microbadger.com")

alpine-sysctl
=================

A base image to check and set hosts sysctl parameter. 

## Build

```
docker build -t rawmind/alpine-sysctl:<version> .
```

## Versions

- `0.2-1` [(Dockerfile)](https://github.com/rawmind0/alpine-sysctl/blob/0.2-1/Dockerfile).
- `0.1-1` [(Dockerfile)](https://github.com/rawmind0/alpine-sysctl/blob/0.1-1/Dockerfile).

## Env variables

- SYSCTL_KEY=""        	# Mandatory: Set sysctl key.
- SYSCTL_VALUE=0        # Mandatory: Set sysctl key desired value.
- SYSCTL_FORCE=0        # Set to 1 to force sysctl overwrite key value.
- KEEP_ALIVE="0"        # Set to 1 to keep container alive. (to run in k8s)

## Usage

This image basically, upgrade host sysctl key value if it's lower than desired.

```
docker run -t \
  -e "SYSCTL_KEY=KEY" \
  -e "SYSCTL_VALUE=VALUE" \
  --privileged \
  rawmind/alpine-sysctl:<version> .
```
