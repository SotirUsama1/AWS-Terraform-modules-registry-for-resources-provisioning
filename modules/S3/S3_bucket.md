# S3 bucket module

This module creates an Amazon S3 bucket and its bucket-versioning configuration.

## Example use

Declare the module in `main.tf`:

```hcl
module "s3_bucket" {
  source  = "./modules/S3"
  context = local.context

  # Uses this exact name when it is not an empty string.
  bucket_name = var.s3_bucket_name

  # Used only when bucket_name is an empty string.
  bucket_name_suffix = var.s3_bucket_name_suffix

  force_destroy            = var.s3_force_destroy
  versioning               = var.s3_versioning
  versioning_configuration = var.s3_versioning_configuration
  bucket_tags              = var.s3_bucket_tags
}
```

Declare the corresponding inputs in `variables.tf`:

```hcl
variable "s3_bucket_name" {
  description = "Exact name for the S3 bucket; use an empty string to generate a name from context."
  type        = string
  default     = ""
}

variable "s3_bucket_name_suffix" {
  description = "Final name segment when s3_bucket_name is empty."
  type        = string
  default     = "bucket"
}

variable "s3_bucket_tags" {
  description = "Additional tags for the S3 bucket."
  type        = map(string)
  default     = {}
}

variable "s3_force_destroy" {
  description = "Whether Terraform deletes bucket objects when the bucket is destroyed."
  type        = bool
  default     = false
}

variable "s3_versioning" {
  description = "Whether to enable S3 bucket versioning when no explicit configuration is supplied."
  type        = bool
  default     = false
}

variable "s3_versioning_configuration" {
  description = "Explicit versioning configuration. Set to {} to use s3_versioning instead."
  type        = map(string)
  default     = {}
}
```

Set values in `terraform.tfvars`:

```hcl
s3_bucket_name        = "depi-task-bucket"
s3_bucket_name_suffix = "bucket"

s3_force_destroy = false
s3_versioning    = false

# An empty map lets s3_versioning determine the status.
s3_versioning_configuration = {}

s3_bucket_tags = {
  Environment = "dev"
  ManagedBy   = "Terraform"
}
```

## Arguments

| Argument | Type | What it does | Difference / interaction |
| --- | --- | --- | --- |
| `context` | `map(string)` | Supplies naming context. The module reads `context.prefix`. | Required when `bucket_name` is empty; it is not a tag map. |
| `bucket_name` | `string` | Sets the exact bucket name. | Takes precedence over `bucket_name_suffix`. An empty string generates `<context.prefix>-<bucket_name_suffix>`. |
| `bucket_name_suffix` | `string` | Provides the last part of an automatically generated bucket name. | It does not change an explicitly supplied `bucket_name`. |
| `bucket_tags` | `map(string)` | Adds tags to the bucket. | These are metadata only; they do not affect the bucket name or configuration. The module always adds a `Name` tag, and a `Name` key in this map overrides it. |
| `force_destroy` | `bool` | When `true`, Terraform removes objects in the bucket during bucket destruction. | This affects deletion only. It does not affect normal bucket use, naming, tags, or versioning. |
| `versioning` | `bool` | Controls versioning when `versioning_configuration` is `{}`. `true` enables versioning; `false` disables it. | This is the simple switch. It is ignored when a non-empty `versioning_configuration` is provided. |
| `versioning_configuration` | `map(string)` | Supplies an explicit versioning status through its `status` key. | This is the explicit alternative to `versioning` and takes precedence whenever the map is non-empty. Use `status = "Enabled"` or `status = "Disabled"`. |

## Versioning choices

Use the Boolean when a simple enable/disable choice is enough:

```hcl
s3_versioning               = true
s3_versioning_configuration = {}
```

Use the configuration map when the versioning status should be set explicitly:

```hcl
s3_versioning_configuration = {
  status = "Enabled"
}
```

Do not rely on `s3_versioning` when `s3_versioning_configuration` contains a `status` value; the explicit map controls the result.

## Outputs

```hcl
output "s3_bucket_id" {
  description = "The ID of the S3 bucket"
  value       = module.s3_bucket.bucket_id
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = module.s3_bucket.bucket_arn
}
```

`bucket_id` is the bucket identifier (its bucket name in this module). `bucket_arn` is the bucket's Amazon Resource Name.
