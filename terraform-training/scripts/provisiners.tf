# ---- Provisioner example (LAST RESORT) ----
# Runs an external health check after containers are created/updated.

resource "null_resource" "app_healthcheck" {
  # Triggers tell Terraform *when* this should re-run.
  # Any change to these values causes the null_resource to be replaced.
  triggers = {
    workspace = terraform.workspace

    # Re-run healthcheck if app container names change (rolling change / new instances)
    app_containers = join(",", module.python_app.container_names)

    # Re-run if ports change
    app_ports = join(",", [for p in module.python_app.host_ports : tostring(p)])
  }

  provisioner "local-exec" {
    # Pick the first exposed port (adjust if you want to check nginx instead)
    command = "bash ${path.module}/scripts/healthcheck.sh http://localhost:${element(module.python_app.host_ports, 0)}/"

  }

  depends_on = [
    module.python_app
  ]
}
