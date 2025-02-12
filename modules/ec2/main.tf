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
		    sudo yum install -y java mariadb105 git maven
        sudo yum install -y docker
        sudo docker --version
        sudo java -version
        sudo usermod -aG docker ec2-user
        sudo systemctl enable --now docker
        sudo systemctl status docker
        sudo docker ps
        sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
        docker-compose version
        sudo docker plugin install grafana/loki-docker-driver:latest --alias loki --grant-all-permissions
	EOF

}

resource "aws_key_pair" "ecfkey" {
  key_name   = "ecfkey"
  public_key = file("ecfkey.pub")
}
