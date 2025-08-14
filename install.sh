#!/bin/bash

# 定义输出目录（可修改为任意路径）
OUTPUT_DIR="output"

# 创建目录结构
mkdir -p ${OUTPUT_DIR}/bin ${OUTPUT_DIR}/conf ${OUTPUT_DIR}/logs

# 拷贝核心可执行文件
cp src/redis-server ${OUTPUT_DIR}/bin/
cp src/redis-cli ${OUTPUT_DIR}/bin/
cp src/redis-benchmark ${OUTPUT_DIR}/bin/ 2>/dev/null || echo "redis-benchmark不存在，跳过"
cp src/redis-sentinel ${OUTPUT_DIR}/bin/ 2>/dev/null || echo "redis-sentinel不存在，跳过"

# 拷贝配置文件
cp redis.conf ${OUTPUT_DIR}/conf/
cp sentinel.conf ${OUTPUT_DIR}/conf/ 2>/dev/null || echo "sentinel.conf不存在，跳过"

# 拷贝必要依赖（如果是动态链接）
if file src/redis-server | grep -q "dynamically linked"; then
  mkdir -p ${OUTPUT_DIR}/lib
  ldd src/redis-server | grep "=>" | awk '{print $3}' | xargs -I {} cp {} ${OUTPUT_DIR}/lib/
fi

# 设置权限
chmod +x ${OUTPUT_DIR}/bin/*
chmod 644 ${OUTPUT_DIR}/conf/*

# 生成版本信息
src/redis-server --version > ${OUTPUT_DIR}/VERSION 2>&1

echo "所有文件已整理到 ${OUTPUT_DIR} 目录"