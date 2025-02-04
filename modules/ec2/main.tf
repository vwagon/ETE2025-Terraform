resource "aws_instance" "ec2_java" {
    ami = lookup(var.AWS_AMIS, var.AWS_REGION)
    instance_type = var.AWS_INSTANCE_TYPE
    vpc_security_group_ids = [var.security_group_id]
    tags = {
        Name = "ecf_ec2"
    }
    user_data = <<-EOF
		#!/bin/bash
        sudo yum update -y
		sudo yum install -y java
        sudo java -version
	EOF

}