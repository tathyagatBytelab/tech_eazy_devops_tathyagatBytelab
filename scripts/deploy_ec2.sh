#!/bin/bash

# Usage: ./scripts/deploy_ec2.sh dev
STAGE=$1

if [[ -z "$STAGE" ]]; then
  echo "Usage: $0 [dev|prod]"
  exit 1
fi

CONFIG_FILE="config/${STAGE}_config.json"

if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "Config file not found: $CONFIG_FILE"
  exit 1
fi

# Load values from config
INSTANCE_TYPE=$(jq -r '.instance_type' "$CONFIG_FILE")
REGION=$(jq -r '.region' "$CONFIG_FILE")
REPO_URL=$(jq -r '.repo_url' "$CONFIG_FILE")

# Generate unique key name
KEY_NAME="devops-key-${STAGE}-$(date +%s)"

# Read and encode public key
PUB_KEY_BASE64=$(base64 -w 0 ~/.ssh/devops-key.pub)

# Import the key into AWS
aws ec2 import-key-pair \
  --key-name "$KEY_NAME" \
  --public-key-material "$PUB_KEY_BASE64" \
  --region "$REGION"

# ✅ YOUR Subnet and Security Group (corrected)
SUBNET_ID="subnet-0ada851cd0b420171"
SG_ID="sg-0212fb5dec7913bd9"

# Launch EC2
echo "Launching EC2..."
INSTANCE_ID=$(aws ec2 run-instances \
  --image-id ami-0f5ee92e2d63afc18 \
  --instance-type "$INSTANCE_TYPE" \
  --key-name "$KEY_NAME" \
  --region "$REGION" \
  --network-interfaces "DeviceIndex=0,SubnetId=$SUBNET_ID,AssociatePublicIpAddress=true,Groups=$SG_ID" \
  --query 'Instances[0].InstanceId' \
  --output text)
  
echo "Instance ID: $INSTANCE_ID"

# Wait for EC2 to be running
echo "Waiting for EC2 to start..."
aws ec2 wait instance-running --instance-ids "$INSTANCE_ID" --region "$REGION"

# Get Public IP
PUBLIC_IP=$(aws ec2 describe-instances \
  --instance-ids "$INSTANCE_ID" \
  --region "$REGION" \
  --query 'Reservations[0].Instances[0].PublicIpAddress' \
  --output text)

echo "EC2 is running at: $PUBLIC_IP"

# Wait for SSH to be ready
echo "Waiting for SSH to be available..."
sleep 60

# Commands to install and start the app
REMOTE_COMMANDS=$(cat <<EOF
sudo apt update
sudo apt install -y openjdk-21-jdk maven git
git clone $REPO_URL
cd test-repo-for-devops
mvn clean package
nohup java -jar target/hellomvc-0.0.1-SNAPSHOT.jar > app.log 2>&1 &
EOF
)

# Connect and run commands remotely
echo "Connecting to EC2 and setting up app..."
ssh -o StrictHostKeyChecking=no -i ~/.ssh/devops-key ubuntu@$PUBLIC_IP "$REMOTE_COMMANDS"

echo "✅ App should be live at: http://$PUBLIC_IP/hello"
