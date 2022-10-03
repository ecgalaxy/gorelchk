# gorelchk

Allows to reproduce upstream GoReleaser builds.

## Prerequisites

See [Reproducible Builds](https://goreleaser.com/customization/build/#reproducible-builds).

## Example

```
docker build -t gorelchk --build-arg REPO=https://github.com/go-task/task.git --build-arg TAG=v3.15.0 .
```

The build outputs sha256sums to be compared with those generated from upstream builds, e.g.:

```
$ docker build -t gorelchk --build-arg REPO=https://github.com/go-task/task.git --build-arg TAG=v3.15.0 .

... build succeeded ...
e68acae21d83769aa2dc83f2801fd949fa0f7e789b01a9f3e4e9e2f84ab7b10e  ./dist/task_darwin_amd64_v1/task
dab2bcaf4575855eea574b1f4486dca73690e2de7207cce8c762308567e90926  ./dist/task_darwin_arm64/task
276ffdfd62ce0b076b78567d8fdbc8810b914f2401e55ed718faec1a6368ba41  ./dist/task_linux_amd64_v1/task
76af142d65a4d12fdd42d7c40e378834d6969a64f5f4c40f0b49ca505b023a53  ./dist/task_linux_386/task
ecda73e87cf0da74fbb55a3db57df5ace18ba8aaa30ddf3145c23783af0cf91a  ./dist/task_linux_arm_6/task
a660e2acdc8b9508cc8af3f9e4481ed3c51ce3cd16797682db84af7f27d6740b  ./dist/task_linux_arm64/task
9a967acb7178e02b632832408def9eaf15ceae2435b136cfe655014916338f50  ./dist/task_windows_386/task.exe
c5caf31d3dfde1e0cbf8618b7ed21903294efb12eedc9090a2e7ad6a71525db9  ./dist/task_windows_arm_6/task.exe
0f93444b1236efa8119e1d2faea9843f29b4e4106224a2739367b699424a5430  ./dist/task_windows_arm64/task.exe
9ca6397957228012d401befeee41c25f8b4c6ee2639204400f1e6556e118cab1  ./dist/task_windows_amd64_v1/task.exe
...
```

To be compared with:

```
$ curl -L -s https://github.com/go-task/task/releases/download/v3.15.0/task_darwin_amd64.tar.gz | tar -xz task -C /tmp && sha256sum task
e68acae21d83769aa2dc83f2801fd949fa0f7e789b01a9f3e4e9e2f84ab7b10e  task

$ curl -L -s https://github.com/go-task/task/releases/download/v3.15.0/task_linux_amd64.tar.gz | tar -xz task -C /tmp && sha256sum task
276ffdfd62ce0b076b78567d8fdbc8810b914f2401e55ed718faec1a6368ba41  task
```

Go and GoReleaser versions can be set via `GO_VER` and `GORELEASER_VER` variables, see Dockerfile.
