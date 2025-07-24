#!/bin/bash

# Constants
STAGE=$1
LOG_FILE="/home/ubuntu/test-repo-for-devops/app.log"
S3_BUCKET="devops-logs-tathyagatbytelab"

if [[ -z "$STAGE" ]]; then
  echo "Usage: $0 [dev|prod]"
  exit 1
fi

if [[ ! -f "$LOG_FILE" ]]; then
  echo "Log file not found: $LOG_FILE"
  exit 1
fi

# Upload to S3
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
DESTINATION="s3://${S3_BUCKET}/${STAGE}/app-${TIMESTAMP}.log"

aws s3 cp "$LOG_FILE" "$DESTINATION" --region ap-south-1

if [[ $? -eq 0 ]]; then
  echo "✅ Logs uploaded to: $DESTINATION"
else
  echo "❌ Failed to upload logs."
fi
