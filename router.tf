locals {
  router_name = "router-${replace(var.domain, ".", "_")}"
}

data "archive_file" "router" {
  type        = "zip"
  source_file = "${path.module}/router/index.js"
  output_path = "${path.module}/.tmp/router.zip"
}

resource "aws_iam_role" "router" {
  provider = aws.virgina

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["lambda.amazonaws.com", "edgelambda.amazonaws.com"]
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_lambda_function" "router" {
  provider = aws.virgina

  filename         = data.archive_file.router.output_path
  function_name    = local.router_name
  role             = aws_iam_role.router.arn
  handler          = "index.handler"
  source_code_hash = data.archive_file.router.output_base64sha256
  runtime          = "nodejs12.x"
  publish          = true
}
