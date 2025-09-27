package main

deny contains msg if {
  input.kind == "Deployment"
  not input.spec.template.spec.containers[0].securityContext.runAsNonRoot
  msg := "Containers in Deployment must set securityContext.runAsNonRoot = true"
}
