#!/bin/bash

# 检查参数数量
if [ "$#" -ne 3 ]; then
    echo "使用方法: $0 <AKS_CLUSTER_NAME> <ACTION> <NAMESPACE>"
    exit 1
fi

# 位置变量
AKS_CLUSTER_NAME=$1
ACTION=$2
NAMESPACE=$3

# 构建 URL
URL="https://${AKS_CLUSTER_NAME}-api.ap.test.com/int/rcs-test/${ACTION}"

# 输出变量值
echo "构建的 URL: $URL"

# 使用 curl 进行 POST 请求
RESPONSE=$(curl -s -X POST "$URL")

# 输出结果到 txt 文件
OUTPUT_FILE="${NAMESPACE}_response.txt"
echo "$RESPONSE" > "$OUTPUT_FILE"

# 输出结果文件的名称
echo "返回结果已输出至: $OUTPUT_FILE"

