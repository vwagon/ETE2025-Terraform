output "instance_id" {
    value = aws_instance.ec2_java.id
}

output "ec2_public_ip" {
  value = aws_instance.ec2_java.public_ip
}