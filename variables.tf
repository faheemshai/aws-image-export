variable "region" {
  type = string
  description = "The deployment region"
  default = ""
}

variable "access_key_id" {
  type        = string
  description = "Access key of the Storage Provider "
  default     = ""
  
}

variable "secret_access_key" {
  type        = string
  description = "Secret key of the Storage Provider"
    default     = ""
}

variable "instance_ID" {
  type = string
  description = "EC2 instance id which we want to export"
  default = ""
}

variable "src_bucket" {
  type = string
  description = "s3 bucket name to export image"
  default = "backupec2iam"
}