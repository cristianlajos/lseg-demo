package pipeline

import future.keywords.if
import future.keywords.in

deny[msg] if {
    # Find any stage that deploys to production
    stage := input.pipeline.stages[_].stage
    stage.type == "Deployment"
    stage.spec.environment.environmentRef == "production"
    
    # Check no approval stage exists anywhere in the pipeline
    not has_approval_stage
    msg := "Pipeline must have an Approval stage before deploying to production."
}

deny[msg] if {
    # Also check via template inputs for template-based stages
    stage := input.pipeline.stages[_].stage
    stage.type == "Deployment"
    template_env := stage.template.templateInputs.spec.environment.environmentRef
    template_env == "production"
    not has_approval_stage
    msg := "Pipeline must have an Approval stage before deploying to production."
}

has_approval_stage if {
    stage := input.pipeline.stages[_].stage
    stage.type == "Approval"
}