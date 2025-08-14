

1. 构建项目

```
sh build.sh
```



2. 打包生成的文件到output

```
sh install.sh
```

```
output
├── bin
│   ├── redis-benchmark
│   ├── redis-cli
│   ├── redis-sentinel
│   └── redis-server
├── conf
│   ├── redis.conf
│   └── sentinel.conf
├── logs
└── VERSION
```



3. 测试脚本

```
# 启动redis-server

./bin/redis-server --daemonize yes
ps aux | grep redis-server
```

```
# 启动redis-benchmark
./redis-benchmark
```

```
# 性能测试（10万请求，50并发）
./bin/redis-benchmark -n 100000 -c 50
```

```
# 单次测试后退出
./bin/redis-benchmark -n 100000 -q -t set
```

