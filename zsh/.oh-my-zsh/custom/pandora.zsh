# Utilities and helpers for the pandora repository.

reformat() {
    pushd ~/software/Embedded/PandoraCore/ > /dev/null
    CLANG_FORMAT="clang-format-12" ./Scripts/reformat_everything.bash
    popd > /dev/null
}
