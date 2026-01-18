# terraform-aws-ecs (v0.0.3 - Terraform 1.x upgrade)

This is an upgraded/refactored version of the original `terraform-aws-ecs` module to run cleanly on **Terraform 1.x** and modern AWS provider versions.

## Key upgrades / aging fixes

- Works with **Terraform >= 1.3** (HCL2 syntax, no legacy interpolation-only expressions).
- Uses **AWS provider ~> 5.0** (`versions.tf`).
- Removes the legacy **template provider** by replacing `template_file` with the builtin `templatefile()`.
- Uses the **recommended ECS-optimized Amazon Linux 2 AMI** via SSM Parameter Store (overrideable via `ami_id`).
- EC2 role now attaches **AmazonSSMManagedInstanceCore** (the old `AmazonEC2RoleforSSM` policy is deprecated).
- Optional IMDSv2 enforcement via `imds_http_tokens` (default `required`).
- Root volume encryption via `alias/aws/ebs`.

## New/updated variables (non-breaking)

- `ami_id` (optional): override AMI ID.
- `ami_ssm_parameter`: SSM parameter used when `ami_id` is null.
- `root_volume_size`, `root_volume_type`: root EBS settings.
- `imds_http_tokens`: IMDSv2 token requirement (`required` or `optional`).

Existing inputs like `security_group_ids` and `userdata` are preserved.
