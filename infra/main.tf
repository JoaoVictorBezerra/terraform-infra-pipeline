resource "aws_s3_bucket" "pipeline_s3_bucket" {
  bucket = var.bucket_name
  bucket_prefix = "tf_"
  tags = {
    FromTerraform = true
    Environment = terraform.workspace
    Project = var.project
  }
}