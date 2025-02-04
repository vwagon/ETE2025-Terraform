resource "aws_security_group" "ecf_sg" {
    name = "ecf_sg"
    description = "Allow TLS inbound traffic and all outbound traffic"
    tags = {
        Name = "ecf_sg"
    }
}
resource "aws_security_group_rule" "ecf_sg_rule" {
    for_each = var.map_list
    type = each.value[0]
    from_port = each.value[1]
    to_port = each.value[2]
    protocol = each.value[3]
    cidr_blocks = [ each.value[4] ]
    security_group_id = aws_security_group.ecf_sg.id
}