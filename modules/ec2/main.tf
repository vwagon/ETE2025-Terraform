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
        set -e
        sudo yum update -y
        sudo amazon-linux-extras install epel -y 
		    sudo yum install -y java mariadb105 git maven curl
        sudo yum install -y docker
        sudo docker --version
        sudo java -version
        sudo usermod -aG docker ec2-user
        docker ps
        systemctl enable --now docker
        sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
        docker-compose version
	EOF

}

resource "aws_key_pair" "ecfkey" {
  key_name   = "ecfkey"
  public_key = file("ecfkey.pub")
}
