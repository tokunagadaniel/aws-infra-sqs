terraform {
  backend "s3" {
    region = "sa-east-1"
    bucket = "ecs-infra-bucket"
    key    = "infrasqs/terraform.tfstate"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.63.0"
    }
  }
}

provider "aws" {
    region = "sa-east-1"
}

resource "aws_sqs_queue" "myqueue" {
  name = var.sqs_name
}

resource "aws_sqs_queue_policy" "my_sqs_policy" {
  queue_url = aws_sqs_queue.myqueue.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.myqueue.arn}"
    }
  ]
}
POLICY
}
