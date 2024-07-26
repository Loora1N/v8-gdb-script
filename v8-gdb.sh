#!/bin/bash
#   created by Loora1N (https://loora1n.github.io/)
usage() {
    echo "Usage: $0 <v8-version> <js-file>"
    echo "Launch GDB to debug the specified version of the V8 engine and execute the given JavaScript file."
    echo
    echo "Options:"
    echo "  -h, --help    Display this help message"
    exit 0
}

# 检查是否有-h或--help选项
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    usage
fi

# 检查参数个数
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <v8-version> <js-file>"
    exit 1
fi

V8_VERSION=$1
JS_FILE=$2

# 设置V8路径，假设不同版本的V8安装在 /path/to/v8/versions/<version>
V8_PATH="../v8/out/x64_$V8_VERSION.release"

# 检查V8路径是否存在
if [ ! -d "$V8_PATH" ]; then
    echo "Error: V8 version $V8_VERSION not found at $V8_PATH"
    exit 1
fi

# 设置V8可执行文件路径
V8_EXEC="$V8_PATH/d8"

# 检查V8可执行文件是否存在
if [ ! -f "$V8_EXEC" ]; then
    echo "Error: V8 executable not found at $V8_EXEC"
    exit 1
fi

# 检查JS文件是否存在
if [ ! -f "$JS_FILE" ]; then
    echo "Error: JavaScript file $JS_FILE not found"
    exit 1
fi

# 启动GDB调试
gdb --args "$V8_EXEC" "$JS_FILE" --allow-natives-syntax
