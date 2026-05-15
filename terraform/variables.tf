variable "key_pair_name" {
  type        = string
  description = "Name of the kay pair"
  sensitive   = true
}

variable "vpc1_cidr" {
  type        = string
  description = "vpc1 CIDR Block"
}

variable "subnet_public_cidr" {
  type        = string
  description = "Public CIDR Block"
}

variable "subnet_private1_cidr" {
  type        = string
  description = "Private 1 CIDR Block"
}

variable "subnet_private2_cidr" {
  type        = string
  description = "Private 2 CIDR Block"
}

variable "my_public_ip" {
  type        = string
  description = "My public ip address"
  sensitive   = true
}

variable "pub28_priv_ip" {
  type        = string
  description = "EC2 public 28 private IP"
}

variable "priv28_priv_ip" {
  type        = string
  description = "EC2 Private 28 private IP"
}

variable "gl_db_username" {
  type = string
  description = "Username for Gitlab database"
}

variable "gl_db_passwd" {
  type = string
  description = "Password for Gitlab database"
}