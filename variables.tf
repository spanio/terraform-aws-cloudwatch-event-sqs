variable "name" {
  default     = "cloudwatch-sqs"
  type        = string
  description = "The name for the SQS queue and Cloudwatch Event"
}
variable "cloudwatch_event_rule_schedule_expression" {
  type        = string
  description = "The rate or cron expression to trigger the Cloudwatch Event"
}
variable "tags" {
  default     = {}
  type        = map(string)
  description = "The tags to add to all generated resources"
}
variable "sqs_retry_count" {
  default     = 3
  type        = number
  description = "The number of receive attempts before SQS will forward the message to a Dead Letter Queue"
}
variable "sqs_visibility_timeout_seconds" {
  default     = 30
  type        = number
  description = "The visibility timeout for the queue. If this message is consumed by a Lambda function, this number should be 4 times bigger than the Lambda timeout duration."
}