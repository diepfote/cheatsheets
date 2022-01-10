# Docker containers

## container defaults

$ podman run --security-opt=no-new-privileges \
             --rm \
             ...

*or even*

$ podman run --security-opt=no-new-privileges \
             --cap-drop=ALL \
             --rm \
             ...


## run a container with custom entrypoint
 | run a container with custom cmd
 | run a container with custom command
 | run a container with command

$ podman run --security-opt=no-new-privileges \
             --cap-drop=ALL \
             --rm \
             --entrypoint=bash \
             -v (realpath ../qiime2_wrappers/qiime2/):/qiime2 \
             -it \
             --name planemo-instance \
             bgruening/planemo


## show namespace information (UTS, IPC, CGROUP, ...)

```
docker ps --ns
```

## `top` for docker containers

```
docker stats
```

## `top` for cgroups

```
systemd-cgtop
```
