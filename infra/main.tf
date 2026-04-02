# module "s3_bucket" {
#   source = "./modules/s3"
#
#   bucket_name = var.bucket_name
#   project     = var.project
# }

module "sqs" {
  source = "./modules/sqs"

  project    = var.project
  queue_name = var.sqs_name
}