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
		    sudo yum install -y java mariadb105 git maven curl docker
        docker --version
        sudo java -version
        sudo usermod -aG docker ec2-user
        systemctl enable --now docker
        DOCKER_CONFIG=$${DOCKER_CONFIG:-/usr/local/lib/docker}
        mkdir -p $DOCKER_CONFIG/cli-plugins
        curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
        chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
        ln -s $DOCKER_CONFIG/cli-plugins/docker-compose /usr/bin/docker-compose
	EOF

}

resource "aws_key_pair" "ecfkey" {
  key_name   = "ecfkey"
  public_key = file("ecfkey.pub")
}
