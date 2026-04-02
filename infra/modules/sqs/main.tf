resource "aws_sqs_queue" "dlq" {
  name = "${var.queue_name}_${terraform.workspace}_dlq"
  message_retention_seconds = 1209600
  sqs_managed_sse_enabled   = true

  tags = {
    FromTerraform = true
    Environment = terraform.workspace
    Project = var.project
  }
}

resource "aws_sqs_queue" "sqs" {
  name = "${var.queue_name}_${terraform.workspace}"
  message_retention_seconds = 345600

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = 3 # Moves to DLQ after 3 failures
  })


  tags = {
    FromTerraform = true
    Environment = terraform.workspace
    Project = var.project
  }
}

resource "aws_sqs_queue_redrive_allow_policy" "example" {
  queue_url = aws_sqs_queue.dlq.id

  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.sqs.arn]
  })
}
