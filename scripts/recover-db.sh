#!/bin/bash

# Set your AWS credentials
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"

# Set the S3 path from your config
S3_PATH="s3://246770851643-eu-central-1-homelab-cluster-storage/backups/paperless-ngx/paperless-ngx/"
ENDPOINT="https://s3.eu-central-1.amazonaws.com"

# Create data directory
mkdir -p ./pgdata

# Restore the backup
docker run --rm \
  -v $(pwd)/pgdata:/pgdata \
  -e AWS_ACCESS_KEY_ID \
  -e AWS_SECRET_ACCESS_KEY \
  -e AWS_ENDPOINT_URL=$ENDPOINT \
  ghcr.io/cloudnative-pg/postgresql:16 \
  barman-cloud-restore \
  --endpoint-url $ENDPOINT \
  $S3_PATH \
  latest \
  /pgdata
