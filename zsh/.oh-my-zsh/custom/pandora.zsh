# Utilities and helpers for the pandora repository.

export PANDORA_DIR="${HOME}/software/e2m.hydra.pandora.core"
alias cdpandora='cd "${PANDORA_DIR}"'

reformat() {
    pushd ~/software/Embedded/PandoraCore/ > /dev/null
    CLANG_FORMAT="clang-format-12" ./Scripts/reformat_everything.bash
    popd > /dev/null
}

deploy_single() {
    pushd "${PANDORA_DIR}" > /dev/null
    helm upgrade \
        --namespace vpp-agregio \
        "${1}" \
        ./deployment \
        -f deployment/common.yaml \
        -f deployment/_dev/values.yaml \
        --install
    popd > /dev/null
}
