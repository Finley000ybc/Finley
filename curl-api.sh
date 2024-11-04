#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "use method: $0 <AKS_CLUSTER_NAME> <ACTION> <NAMESPACE>"
    exit 1
fi

# vars
AKS_CLUSTER_NAME=$1
ACTION=$2
NAMESPACE=$3

# Build URL
URL="https://${AKS_CLUSTER_NAME}-api.ap.test.com/int/rcs-test/${ACTION}"

echo "The Builded URL is: $URL"

# Use curl POST
RESPONSE=$(curl -s -X POST "$URL")

# Out put result to a txt file
OUTPUT_FILE="${NAMESPACE}_response.txt"
echo "$RESPONSE" > "$OUTPUT_FILE"

#
echo "the result is in: $OUTPUT_FILE"

