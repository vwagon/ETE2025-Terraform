resource "aws_security_group" "ec2_sg" {
    name = "ec2_sg"
    vpc_id = var.vpc_id
    description = "Autorise ssh et le traffic entrant"
    tags = {
        Name = "ec2_sg"
    }
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "rds_sg" {
    name = "rds_sg"
    vpc_id = var.vpc_id
    description = "Autorise les connexions MySQL depuis EC2"
    tags = {
      Name = "rds_sg"
    }
    ingress {
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        security_groups = [aws_security_group.ec2_sg.id]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["10.0.0.0/16"]
    }
}