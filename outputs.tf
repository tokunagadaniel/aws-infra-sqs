# Output value definitions

output "function_name" {
  description = "ARN of the SQS."

  value = aws_sqs_queue.myqueue.arn
}