package pipeline

import future.keywords.if
import future.keywords.in

deny[msg] if {
    stage := input.pipeline.stages[_].stage
    stage.type == "Deployment"
    # Check for production env - handle both hardcoded and runtime input refs
    env := stage.spec.environment.environmentRef
    env == "production"
    not has_approval_stage
    msg := "Pipeline must have an Approval stage before deploying to production."
}

has_approval_stage if {
    stage := input.pipeline.stages[_].stage
    stage.type == "Approval"
}