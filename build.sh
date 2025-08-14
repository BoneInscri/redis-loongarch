#!/bin/bash

# 设置交叉编译环境
export CC="loongarch64-linux-gnu-gcc"
export CXX="loongarch64-linux-gnu-g++"
export CFLAGS="-O2 -march=loongarch64 -mabi=lp64d"
export CXXFLAGS="$CFLAGS"
export LDFLAGS="-static -latomic -lpthread"

# 1. 清理旧构建
make distclean

# 2. 编译所有依赖库
cd deps

# (1) 修复fast_float编译
echo "==== 编译 fast_float ===="
cd fast_float
make clean
make CXX="$CXX" CXXFLAGS="$CXXFLAGS"
cd ..

# (2) 修复linenoise编译
echo "==== 编译 linenoise ===="
cd linenoise
make clean
make CC="$CC" CFLAGS="$CFLAGS"
cd ..

# (3) 编译其他必要依赖
for lib in hiredis lua; do
    echo "==== 编译 $lib ===="
    cd $lib
    make clean
    make CC="$CC" CFLAGS="$CFLAGS" LDFLAGS="$LDFLAGS"
    cd ..
done
cd ..

# 3. 修复fast_float库路径问题（某些版本需要）
if [ ! -f "deps/fast_float/libfast_float.a" ]; then
    mkdir -p deps/fast_float
    cp deps/fast_float/*.o deps/fast_float/libfast_float.a
fi

# 4. 编译Redis主程序
make -j$(nproc) \
    CC="$CC" \
    CXX="$CXX" \
    CFLAGS="$CFLAGS" \
    CXXFLAGS="$CXXFLAGS" \
    LDFLAGS="$LDFLAGS" \
    MALLOC=libc \
    USE_SYSTEMD=no

# 5. 验证结果
if [ -f "src/redis-server" ]; then
    echo "编译成功！"
    file src/redis-server
else
    echo "编译失败，请检查日志"
    exit 1
fi