data "aws_iam_policy_document" "sqs_from_cloudwatch_event" {
  statement {
    sid     = "AllowQueueFromCloudwatchEvent"
    actions = ["sqs:SendMessage"]
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
    resources = [aws_sqs_queue.cron_sqs.arn]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"

      values = [aws_cloudwatch_event_rule.cron_sqs.arn]
    }
  }
}

resource "aws_sqs_queue" "cron_sqs_dlq" {
  name = "${var.name}-dlq"
  tags = var.tags
}

resource "aws_sqs_queue" "cron_sqs" {
  name = var.name
  tags = var.tags
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.cron_sqs_dlq.arn
    maxReceiveCount     = var.sqs_retry_count
  })
}

resource "aws_cloudwatch_event_rule" "cron_sqs" {
  name                = var.name
  description         = "Triggers SQS"
  schedule_expression = var.cloudwatch_event_rule_schedule_expression
  tags                = var.tags
}

resource "aws_cloudwatch_event_target" "cron_sqs" {
  rule = aws_cloudwatch_event_rule.cron_sqs.name
  arn  = aws_sqs_queue.cron_sqs.arn
}

resource "aws_sqs_queue_policy" "cron_sqs" {
  queue_url = aws_sqs_queue.cron_sqs.id
  policy    = data.aws_iam_policy_document.sqs_from_cloudwatch_event.json
}