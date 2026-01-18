#!/bin/bash

set -euxo pipefail

echo "### INSTALL PACKAGES"

yum update -y
yum install -y amazon-efs-utils awscli || true

echo "### INSTALL/START SSM AGENT"

# On newer ECS-optimized Amazon Linux 2 AMIs, SSM agent is typically preinstalled.
# Keep this logic tolerant for older AMIs.
if ! rpm -q amazon-ssm-agent >/dev/null 2>&1; then
  yum install -y amazon-ssm-agent || \
    yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm || true
fi

if command -v systemctl >/dev/null 2>&1; then
  systemctl enable --now amazon-ssm-agent || true
else
  service amazon-ssm-agent restart || true
fi

echo "### SETUP EFS"

EFS_DIR=/mnt/efs
EFS_ID=${tf_efs_id}

mkdir -p $${EFS_DIR}
echo "$${EFS_ID}:/ $${EFS_DIR} efs tls,_netdev" >> /etc/fstab
mount -a -t efs defaults

echo "### SETUP ECS AGENT"

echo "ECS_CLUSTER=${tf_cluster_name}" >> /etc/ecs/ecs.config

echo "### EXTRA USERDATA"

${userdata_extra}
