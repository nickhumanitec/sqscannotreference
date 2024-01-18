resource "humanitec_resource_definition" "s3_policy" {
  driver_type = "humanitec/terraform"
  id          = "${local.app}-s3-policy"
  name        = "${local.app}-s3-policy"
  type        = "aws-policy"

  driver_inputs = {
    secrets_string = jsonencode({
      variables = {
      }
    }),
    values_string = jsonencode({
      "script" = file("${path.module}/source/test/s3-policy.tf")
      "variables" = {
        arn  = "$${resources['aws-policy>s3'].outputs.arn}"
        name = "$${context.app.id}-$${context.env.id}-$${context.res.id}"
        app  = "$${context.app.id}"
        env  = "$${context.env.id}"
        res  = "$${context.res.id}"
      }
    })
  }
  lifecycle {
    ignore_changes = [
      criteria
    ]
  }


}


resource "humanitec_resource_definition_criteria" "s3_policy" {
  resource_definition_id = humanitec_resource_definition.s3_policy.id
  app_id                 = humanitec_application.app.id
  #   res_id                 = "${local.app}-ddb-non-prod-policy"
  class = "s3"
}
