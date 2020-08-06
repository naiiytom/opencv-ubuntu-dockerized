# OpenCV on Ubuntu Containerized

build status [Unknown]

## Getting Started

### Run

```docker
docker run -it --rm --net=host --env="DISPLAY" -v="$HOME/.Xauthority:/root/.Xauthority:rw" -v ~/py/src/:/app/ --device="/dev/video0:/dev/video0" -w /app/ opencv
```
