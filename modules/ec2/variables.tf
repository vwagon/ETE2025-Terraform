variable "map_list" {
    type = map(list(any))
        #type = string
        #from_port = string
        #to_port = string
        #protocol = string
        #cidr_block = string
    #)))  
}

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
    type = string
}
