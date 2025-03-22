variable "project_name" {
  type    = string
  default = "tf-labs"
}

variable "instance_type" {
  type = string
}

variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "aws_profile" {
  type = string
  default = "banana"
}

variable "aws_access_key" {
  type        = string
  default     = "aws-access-key"
  description = "AWS IAM Access Key"
}

variable "aws_secret_key" {
  type        = string
  default     = "aws-secret-key"
  description = "AWS IAM Secret Key"
}