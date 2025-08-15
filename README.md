

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



```
222:C 14 Feb 2000 21:41:12.203 # WARNING Memory overcommit must be enabled! Without it, a background save or replication may fail under low memory condition. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
222:C 14 Feb 2000 21:41:12.204 * oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
222:C 14 Feb 2000 21:41:12.204 * Redis version=255.255.255, bits=64, commit=51f364f7, modified=1, pid=222, just started
222:C 14 Feb 2000 21:41:12.204 # Warning: no config file specified, using the default config. In order to specify a config file use ./redis-server /path/to/redis.conf
222:M 14 Feb 2000 21:41:12.204 * Increased maximum number of open files to 10032 (it was originally set to 1024).
222:M 14 Feb 2000 21:41:12.204 * monotonic clock: POSIX clock_gettime
                _._                                                  
           _.-``__ ''-._                                             
      _.-``    `.  `_.  ''-._           Redis Open Source            
  .-`` .-```.  ```\/    _.,_ ''-._      255.255.255 (51f364f7/1) 64 bit
 (    '      ,       .-`  | `,    )     Running in standalone mode
 |`-._`-...-` __...-.``-._|'` _.-'|     Port: 6379
 |    `-._   `._    /     _.-'    |     PID: 222
  `-._    `-._  `-./  _.-'    _.-'                                   
 |`-._`-._    `-.__.-'    _.-'_.-'|                                  
 |    `-._`-._        _.-'_.-'    |           https://redis.io       
  `-._    `-._`-.__.-'_.-'    _.-'                                   
 |`-._`-._    `-.__.-'    _.-'_.-'|                                  
 |    `-._`-._        _.-'_.-'    |                                  
  `-._    `-._`-.__.-'_.-'    _.-'                                   
      `-._    `-.__.-'    _.-'                                       
          `-._        _.-'                                           
              `-.__.-'                                               

222:M 14 Feb 2000 21:41:12.208 * Server initialized
222:M 14 Feb 2000 21:41:12.210 * Loading RDB produced by version 255.255.255
222:M 14 Feb 2000 21:41:12.210 * RDB age 46824 seconds
222:M 14 Feb 2000 21:41:12.210 * RDB memory usage when created 3.45 Mb
222:M 14 Feb 2000 21:41:12.221 * Done loading RDB, keys loaded: 5, keys expired: 0.
222:M 14 Feb 2000 21:41:12.221 * DB loaded from disk: 0.013 seconds
222:M 14 Feb 2000 21:41:12.221 * Ready to accept connections tcp
```

```
# ./redis-benchmark -n 100000 -q -t set
SET: 39872.41 requests per second, p50=0.807 msec  
```



