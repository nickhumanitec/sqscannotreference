resource "humanitec_resource_definition" "role" {
  id          = "${local.app}-role"
  name        = "${local.app}-role"
  type        = "aws-role"
  driver_type = "humanitec/terraform"


  driver_inputs = {
    secrets_string = jsonencode({
      variables = {
      }
    }),

    values_string = jsonencode({
      "script" = file("${path.module}/source/test/role.tf")
      "variables" = {



        policies = "$${resources.workload>aws-policy.outputs.arn}"
        name     = "$${context.app.id}-$${context.env.id}-$${context.res.id}"

        app = "$${context.app.id}"
        env = "$${context.env.id}"
        res = "$${context.res.id}"

      }

    })
  }
  lifecycle {
    ignore_changes = [
      criteria
    ]
  }
}


resource "humanitec_resource_definition_criteria" "role" {
  resource_definition_id = humanitec_resource_definition.role.id
  app_id                 = humanitec_application.app.id
  env_id                 = "development"
}
