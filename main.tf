module "s3_bucket" {
  source = "./modules/S3"
  context = local.context

  # Naming convention used is: <bucket_name> || <owner>-<org>-<project>-<env>-<suffix>
  bucket_name = var.s3_bucket_name
  bucket_name_suffix = var.s3_bucket_name_suffix
  
  force_destroy = var.s3_force_destroy
  versioning = var.s3_versioning
  versioning_configuration = var.s3_versioning_configuration

  bucket_tags = var.s3_bucket_tags
}