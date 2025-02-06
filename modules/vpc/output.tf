output "vpc_id" {
    description = "IP du vpc"
    value = aws_vpc.ecfvpc.id
}

output "private_subnet_ids" {
  description = "Liste des subnets privés"
  value       = [aws_subnet.private_subnet.id, aws_subnet.private_subnet_2.id]
}

output "public_subnet_id" {
    description = "ID du public subnet"
    value = aws_subnet.public_subnet.id
}