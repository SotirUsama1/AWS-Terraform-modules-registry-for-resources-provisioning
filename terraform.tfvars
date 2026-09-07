# Provider configuration
aws_region = "eu-west-3"    # Paris
aws_profile = "terraform"

# Global Context variables (To avoid issues, only lowercase alphanumeric characters and hyphens allowed)
owner_name = "sotir"
org_name = "depi"
project_name = "module-registry"
env_name = "dev"

## S3 variables
# s3_bucket_name = "depi-task-bucket"
# s3_bucket_name_suffix = "bucket"

# s3_force_destroy = false
# s3_versioning = false
s3_versioning_configuration = {
  status = "Disabled"
}

# bucket_tags = {}

