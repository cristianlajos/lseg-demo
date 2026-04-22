package pipeline

# Approved base images and registries
approved_registries = {"cristianlajos", "docker.io/cristianlajos"}
approved_bases = {"python:", "ubuntu:", "alpine:", "node:", "debian:", "golang:"}

deny[msg] {
    stage := input.pipeline.stages[_].stage
    stage.type == "CI"
    step := stage.spec.execution.steps[_].step
    step.type == "Run"
    image := step.spec.image
    image != null
    image != ""
    not approved_image(image)
    msg := sprintf(
        "Step '%v' uses unapproved image '%v'. Only cristianlajos/* or official base images are permitted.",
        [step.name, image]
    )
}

deny[msg] {
    stage := input.pipeline.stages[_].stage
    stage.type == "CI"
    parallel := stage.spec.execution.steps[_].parallel
    step := parallel[_].step
    step.type == "Run"
    image := step.spec.image
    image != null
    image != ""
    not approved_image(image)
    msg := sprintf(
        "Parallel step '%v' uses unapproved image '%v'. Only cristianlajos/* or official base images are permitted.",
        [step.name, image]
    )
}

approved_image(image) {
    registry := approved_registries[_]
    startswith(image, registry)
}

approved_image(image) {
    base := approved_bases[_]
    startswith(image, base)
}