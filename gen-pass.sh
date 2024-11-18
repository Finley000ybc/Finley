#!/bin/bash

# 定义字符集
lowercase="abcdefghijklmnopqrstuvwxyz"
uppercase="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
numbers="0123456789"
special_chars="!@#$%^&*()-_=+[]{}|;:,.<>?"

# 合并所有字符集
all_chars="$lowercase$uppercase$numbers$special_chars"

# 随机生成8位密码
password=$(cat /dev/urandom | tr -dc "$all_chars" | fold -w 8 | head -n 1)

# 输出生成的密码
echo "生成的密码是: $password"
