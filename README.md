### 直接使用可拉取镜像

`docker pull ericnothing0113/go-protoc:1.0.0`

### 运行

```
docker run --rm -v $(pwd):$(pwd) -w $(pwd) ericnothing0113/go-protoc:1.0.0 --proto_path=. --micro_out=. --go_out=. -I. xx.proto
```


