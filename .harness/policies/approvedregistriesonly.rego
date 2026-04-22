package pipeline

import future.keywords.if
import future.keywords.in

approved_registries := {"cristianlajos", "docker.io/cristianlajos"}

approved_bases := {"python:", "ubuntu:", "alpine:", "node:", "debian:", "golang:", "maven:", "gradle:"}

deny[msg] if {
    stage := input.pipeline.stages[_].stage
    stage.type == "CI"
    step := stage.spec.execution.steps[_].step
    image := step.spec.image
    not approved_image(image)
    msg := sprintf(
        "Step '%v' uses unapproved image '%v'. Use cristianlajos/* or an approved base image.",
        [step.name, image]
    )
}

approved_image(image) if {
    registry := approved_registries[_]
    startswith(image, registry)
}

approved_image(image) if {
    base := approved_bases[_]
    startswith(image, base)
}

# Allow empty/null images (template steps with runtime inputs)
approved_image(image) if {
    image == null
}

approved_image(image) if {
    image == ""
}