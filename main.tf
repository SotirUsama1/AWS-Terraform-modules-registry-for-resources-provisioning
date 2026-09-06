module "s3" {
  source = "./modules/S3"
  context = local.context

  # Naming convention used is: <bucket_name> || <owner>-<org>-<project>-<env>-<suffix>
  bucket_name = var.bucket_name
  bucket_name_suffix = var.bucket_name_suffix
  
  bucket_tags = var.bucket_tags
  
  
}