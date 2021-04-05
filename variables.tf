variable "public_key" {
  description = "Public key info"
}

variable "private_key" {
  description = "Private key info"
}

variable "key_name" {
  description = "Desired name of AWS key pair"
  default     = "terraform"
}

variable "aws_region" {
  description = "AWS region to launch servers"
  default     = "us-east-2"
}

variable "aws_amis" {
  description = "AWS AMI ID used for machine deployments"
  default     = ""
}

# Chef global vars
variable "chef_environment" {
  description = "Chef Environment the machine will join"
  default     = "_default"
}

variable "server_runlist" {
  description = "Chef Runlist items"
  default     = "chef-linux-base-recipe::default"
}

variable "chef_server_url" {
  description = "Chef Server URL"
}

variable "chef_username" {
  description = "Chef Username that will be used to auth to Chef"
}

variable "chef_pem" {
  description = "Chef PEM that is the match to the above defined Chef username"
}
