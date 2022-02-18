# terraform-aws-cloudwatch-event-sqs

Terraform module to provision an AWS Cloudwatch Event which posts directly to an AWS SQS queue.

## Usage

```hcl
module "cloudwatch-event-sqs" {
  source                                    = "spanio/cloudwatch-event-sqs/aws"
  version                                   = "1.2"
  cloudwatch_event_rule_schedule_expression = "<cron expression>"
  # specify other inputs here, as required
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| aws | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.0 |

## Resources

| Name |
|------|
| [aws_sqs_queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) |
| [aws_sqs_queue_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy) |
| [aws_cloudwatch_event_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) |
| [aws_cloudwatch_event_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name |The name for the SQS queue and Cloudwatch Event | `string` | `cloudwatch-sqs` | no |
| cloudwatch_event_rule_schedule_expression |The rate or cron expression to trigger the Cloudwatch Event | `string` | `null` | yes |
| tags |The tags to add to all generated resources | `map(string)` | `{}` | no |
| sqs_retry_count |The number of receive attempts before SQS will forward the message to a Dead Letter Queue | `number` | `3` | no |
| sqs_visibility_timeout_seconds |The visibility timeout for the queue. If this message is consumed by a Lambda function, this number should be 4 times bigger than the Lambda timeout duration. | `number` | `30` | no |

## Outputs

| Name | Description |
|------|-------------|
| sqs_arn | The ARN of the generated SQS queue |
| queue_url | The URL for the generated SQS queue |
| sqs_dlq_arn | The ARN of the generated SQS DLQ queue |
