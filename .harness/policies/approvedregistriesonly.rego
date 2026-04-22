package pipeline

import future.keywords.if
import future.keywords.in

# Approved registries whitelist
approved_registries := {"cristianlajos", "docker.io/cristianlajos"}

deny[msg] if {
    stage := input.pipeline.stages[_].stage
    stage.type == "CI"
    step := stage.spec.execution.steps[_].step
    image := step.spec.image
    not approved_image(image)
    msg := sprintf(
        "Step '%v' uses image '%v' from an unapproved registry. Approved: %v",
        [step.name, image, approved_registries]
    )
}

approved_image(image) if {
    registry := approved_registries[_]
    startswith(image, registry)
}

# Always allow official slim/alpine base images
approved_image(image) if {
    allowed_bases := {"python:", "ubuntu:", "alpine:", "node:", "debian:"}
    base := allowed_bases[_]
    startswith(image, base)
}