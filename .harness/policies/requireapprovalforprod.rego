package pipeline

deny[msg] {
    # Find deployment stages targeting production
    stage := input.pipeline.stages[_].stage
    stage.type == "Deployment"
    stage.spec.environment.environmentRef == "production"
    
    # Fail if no Approval stage exists anywhere in the pipeline
    not has_approval_stage
    msg := "Pipeline must have a Harness Approval stage before deploying to production."
}

has_approval_stage {
    input.pipeline.stages[_].stage.type == "Approval"
}