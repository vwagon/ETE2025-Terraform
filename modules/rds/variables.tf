variable "security_group_id" {
  description = "The security group ID for the RDS instance"
  type        = string
}

variable "dbpassword" {
    type = string
}

variable "dbusername" {
    type = string
}

variable "vpc_id" {
    description = "VPC ID"
    type = string
}

variable "subnet_ids" {
  description = "Liste des subnets privés pour le RDS"
  type        = list(string)
}
