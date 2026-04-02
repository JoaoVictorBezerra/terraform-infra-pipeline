resource "aws_s3_bucket" "pipeline_s3_bucket" {
  bucket = var.bucket_name

  tags = {
    FromTerraform = true
    Environment = terraform.workspace
    Project = var.project
  }
}