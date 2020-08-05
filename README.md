# OpenCV on Ubuntu Containerized

## Getting Started

### Run

```docker
docker run -it --rm --net=host \ 
--env="DISPLAY" \
--volume="$HOME/.Xauthority:/root/.Xauthority:rw" \
--volume ./src/:/app/ \
--w="/app/" opencv
```
