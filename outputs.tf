output "sqs_arn" {
  description = "The ARN of the generated SQS queue"
  value       = aws_sqs_queue.cron_sqs.arn
}
output "queue_url" {
  description = "The URL for the generated SQS queue"
  value       = aws_sqs_queue.cron_sqs.url
}
output "sqs_dlq_arn" {
  description = "The ARN of the generated SQS DLQ queue"
  value       = aws_sqs_queue.cron_sqs_dlq.arn
}