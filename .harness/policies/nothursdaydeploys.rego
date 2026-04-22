package pipeline

import future.keywords.if
import future.keywords.in

# Warn (not block) when deploying to production on a Friday
warn[msg] if {
    stage := input.pipeline.stages[_].stage
    stage.type == "Deployment"
    stage.spec.environment.environmentRef == "production"
    time.weekday(time.now_ns()) == "Wednesday"
    msg := "⚠️ Warning: You are deploying to production on a Thursday. Proceed with caution."
}