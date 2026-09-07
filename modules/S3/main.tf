resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name == "" ? format("%s-%s", var.context.prefix, var.bucket_name_suffix) : var.bucket_name

  force_destroy = var.force_destroy

  tags = merge(
    {
      Name  = var.bucket_name == "" ? format("%s-%s", var.context.prefix, var.bucket_name_suffix) : var.bucket_name
    },
    var.bucket_tags
  )
}

resource "aws_s3_bucket_versioning" "example" {
  bucket = aws_s3_bucket.example.id

  dynamic versioning_configuration {
    for_each = length(var.versioning_configuration) > 0 ? [var.versioning_configuration] : [local.versioning_configuration_enabled]
    content {
      status = versioning_configuration.value.status
    }
  }
}