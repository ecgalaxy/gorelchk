# gorelchk

Allows to reproduce upstream GoReleaser builds.

## Example

```
docker build -t gorelchk --build-arg REPO=https://github.com/go-task/task.git --build-arg TAG=v3.15.0 .
```
