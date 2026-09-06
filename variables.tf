variable "aws_region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "eu-west-3" # Paris
}

variable "aws_profile" {
  description = "The AWS profile to use for authentication"
  type        = string
  default     = "default"
}

#########################
### Context Variables ###
#########################

variable "owner_name" {
  description = "The name of the owner"
  type        = string
  default     = "sotir"
}

variable "org_name" {
  description = "The name of the organization"
  type        = string
  default     = "org"
}

variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "project"
}

variable "env_name" {
  description = "The name of the environment"
  type        = string
  default     = "test"
}

locals {
  context = {
    owner   = var.owner_name
    org     = var.org_name
    project = var.project_name
    env     = var.env_name
    prefix = format("%s-%s-%s", var.org_name, var.project_name, var.env_name)
  }
}


####################
### S3 Variables ###
####################

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = ""
}

variable "bucket_name_suffix" {
  description = "The suffix to append to the S3 bucket name"
  type        = string
  default     = "bucket"
}

variable "bucket_tags" {
  description = "A map of tags to assign to the S3 bucket"
  type        = map(string)
  default     = {}
}