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

variable "context" {
  description = "Global naming and tagging context"
  type        = map(string)
}