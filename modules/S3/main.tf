resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name == "" ? format("%s-%s", var.context.prefix, var.bucket_name_suffix) : var.bucket_name
  
  tags = merge(
    {
      Name  = var.bucket_name == "" ? format("%s-%s", var.context.prefix, var.bucket_name_suffix) : var.bucket_name
    },
    var.bucket_tags
  )
}