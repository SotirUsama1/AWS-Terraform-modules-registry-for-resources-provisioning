variable "context" {
  description = "Global naming and tagging context"
  type        = map(string)
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "bucket_name_suffix" {
  description = "The suffix to append to the S3 bucket name"
  type        = string
  default     = ""
}

variable "bucket_tags" {
  description = "A map of tags to assign to the S3 bucket"
  type        = map(string)
  default     = {}
}

variable "force_destroy" {
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error"
  type        = bool
  default     = false
}

variable "versioning" {
  description = "A boolean that indicates whether versioning should be enabled for the bucket"
  type        = bool
  # default     = false
}

variable "versioning_configuration" {
  description = "A map that defines the versioning configuration for the bucket"
  type        = map(string)
  default     = {
    "status" = "Disabled"
  }
}

locals {
  versioning_configuration_enabled = {
    status = var.versioning ? "Enabled" : "Disabled"
  }
}