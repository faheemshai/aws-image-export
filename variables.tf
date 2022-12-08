variable "src_provider_region" {
  type = string
  description = "The deployment region"
  default = "us-west-2"
}

variable "instance_ID" {
  type = string
  description = "EC2 instance id which we want to export"
  default = "i-0c8d0b258e47275c4"
}

variable "src_bucket" {
  type = string
  description = "s3 bucket name to export image"
  default = "backupec2iam"
}