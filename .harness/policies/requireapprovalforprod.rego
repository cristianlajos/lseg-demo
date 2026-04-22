package pipeline

import future.keywords.if
import future.keywords.in

# Deny if any deployment stage targets a Production environment
# without a preceding Approval stage
deny[msg] if {
    stage := input.pipeline.stages[_].stage
    stage.type == "Deployment"
    stage.spec.environment.environmentRef == "production"
    not has_approval_before_prod
    msg := "Pipeline must have an Approval stage before deploying to production."
}

has_approval_before_prod if {
    stage := input.pipeline.stages[_].stage
    stage.type == "Approval"
}