variable "AWS_REGION" {
    default = "eu-west-3"
    description = "Région de notre instance ec2"
}

variable "AWS_AMIS" {
    type = map
    default = {
        "eu-west-3" = "ami-08461dc8cd9e834e0"
    }
}

variable "AWS_INSTANCE_TYPE" {
    default = "t2.micro"
}

variable "security_group_id" {
    description = "The security group ID for the RDS instance"
    type = string
}

variable "subnet_id" {
    type = string
}

variable "vpc_id" {
    description = "VPC ID"
    type = string
}