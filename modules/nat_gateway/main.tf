resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.public_subnet_ids[0]
}

output "nat_gateway_id" {
  value = aws_nat_gateway.main.id
}