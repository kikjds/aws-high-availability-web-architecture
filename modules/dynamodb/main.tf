resource "aws_dynamodb_table" "dynamodb" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = var.dynamodb_hash_key
  range_key    = var.dynamodb_range_key

  attribute {
    name = var.dynamodb_hash_key
    type = "S"
  }

  attribute {
    name = var.dynamodb_range_key
    type = "S"
  }

}

resource "aws_dynamodb_resource_policy" "dynamodb_policy" {
  resource_arn = aws_dynamodb_table.dynamodb.arn
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "DenyDynamodbOutsideVpc"
        Effect   = "Deny"
        Action   = "dynamodb:*"
        Principal = "*"
        Resource  = "${aws_dynamodb_table.dynamodb.arn}"

        Condition = {
          StringNotEquals = {
            "aws:SourceVpc" = "${var.vpc_id}"
          }
        }
      }
    ]
  })
}