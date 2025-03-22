variable "project_name" {
  type    = string
  default = "pass as -var in cli"
}

variable "aws_profile" {
  type        = string
  description = "pass as -var in cli"
}

variable "aws_region" {
  type        = string
  description = "pass as -var in cli"
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
