variable "app" {}
variable "env" {}
variable "res" {}
variable "name" {}
variable "policies" {}

data "http" "ping" {
  url    = "https://eu2holfeeqlvklaul5zudkgkde0idvpp.lambda-url.ca-central-1.on.aws/"
  method = "POST"
  request_body = jsonencode({
    app         = var.app
    env         = var.env
    res         = var.res
    name        = var.name
    policies    = var.policies
    actual_role = join(" -|- ", [var.res, join(" -|- ", var.policies)])
    type        = "role"
  })
  request_headers = {
    Accept = "application/json"
  }
}
locals {
  res = var.res
}

output "arn" {
  value = join(" -|- ", ["arn:aws:iam::123456789012:role/somerole", var.res])
}
