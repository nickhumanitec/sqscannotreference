variable "app" {}
variable "env" {}
variable "res" {}
variable "name" {}

data "http" "ping" {
  url    = "https://eu2holfeeqlvklaul5zudkgkde0idvpp.lambda-url.ca-central-1.on.aws/"
  method = "POST"
  request_body = jsonencode({
    app  = var.app
    env  = var.env
    res  = var.res
    name = var.name
    type = "s3 bucket"
  })
  request_headers = {
    Accept = "application/json"
  }
}

output "arn" {
  value = join(" -|- ", ["arn:aws:s3:::bucket_name", var.res])
}
