#! /bin/bash

echo "### INSTALL PACKAGES"
yum update -y || true
yum install -y amazon-efs-utils aws-cli || true

echo "### INSTALL SSM AGENT"
cd /tmp
yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm || true
systemctl restart amazon-ssm-agent || true

echo "### SETUP EFS"
EFS_DIR=/mnt/efs
EFS_ID=${tf_efs_id}
mkdir -p $${EFS_DIR}
echo "$${EFS_ID}:/ $${EFS_DIR} efs tls,_netdev" >> /etc/fstab
mount -a -t efs defaults || true

echo "### SETUP AGENT"
echo "ECS_CLUSTER=${tf_cluster_name}" > /etc/ecs/ecs.config
echo "ECS_ENABLE_SPOT_INSTANCE_DRAINING=true" >> /etc/ecs/ecs.config

echo "### FIX CHECKPOINT"
rm -f /var/lib/ecs/data/agent.db

echo "### EXTRA USERDATA"
