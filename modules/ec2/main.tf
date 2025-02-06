resource "aws_instance" "ec2_java" {
    ami = lookup(var.AWS_AMIS, var.AWS_REGION)
    instance_type = var.AWS_INSTANCE_TYPE
    vpc_security_group_ids = [var.security_group_id]
    subnet_id = var.subnet_id
    key_name = aws_key_pair.ecfkey.key_name
    tags = {
        Name = "ecf_ec2"
    }
    user_data = <<-EOF
		#!/bin/bash
        sudo yum update -y
        sudo amazon-linux-extras install epel -y 
		    sudo yum install -y java
        sudo yum install -y mariadb105-server-utils
        sudo java -version
        sudo yum install -y tomcat8
        sudo service tomcat8 start
	EOF

}

resource "aws_key_pair" "ecfkey" {
  key_name   = "ecfkey"
  public_key = file("ecfkey.pub")
}
