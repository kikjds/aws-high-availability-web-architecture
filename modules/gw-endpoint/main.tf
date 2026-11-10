// Dynamodb service name
data "aws_vpc_endpoint_service" "dynamodb" {
  service      = "dynamodb"
  service_type = "Gateway"
}

// Gateway endpoint
resource "aws_vpc_endpoint" "gateway_edndpoint" {
  vpc_id            = var.vpc_id
  service_name      = data.aws_vpc_endpoint_service.dynamodb.service_name
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [var.private_route_table_id]
}



