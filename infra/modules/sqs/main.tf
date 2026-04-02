resource "aws_sqs_queue" "sqs" {
  name = var.queue_name
  create_dlq = true

  redrive_policy = {
    maxReceiveCount = 5
  }

  tags = {
    FromTerraform = true
    Environment = terraform.workspace
    Project = var.project
  }
}