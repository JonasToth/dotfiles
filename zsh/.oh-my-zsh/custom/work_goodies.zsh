alias txst="docker run --rm --net=host -it ghcr.io/shopify/toxiproxy"
alias tx="docker run --rm --entrypoint="/toxiproxy-cli" -it --net=host ghcr.io/shopify/toxiproxy"
alias txl="docker run --rm --entrypoint="/toxiproxy-cli" -it --net=host ghcr.io/shopify/toxiproxy list"
alias txt="docker run --rm --entrypoint="/toxiproxy-cli" -it --net=host ghcr.io/shopify/toxiproxy toggle"
alias txcr="docker run --rm --entrypoint="/toxiproxy-cli" -it --net=host ghcr.io/shopify/toxiproxy create"
alias txde="docker run --rm --entrypoint="/toxiproxy-cli" -it --net=host ghcr.io/shopify/toxiproxy delete"


# invvs: inventory verify single
# 
# Verify a single devices and only print its name if it was successfull.
# @pre Requires '${WORKDIR}' to be exported!
# @pre Current working directory must be '<inventory>/devices'
# @example 'invvs U-MRXBGBIELE002'
function invvs() {
    inv --devices "${1}" --repo .. verify --fail-dir ${WORKDIR} 2>/dev/null
}

# invupg: inventory upgrade
#
# Upgrade a package for a single device.
# @pre Current working directory must be '<inventory>/devices'
# @example 'invupg U-MRXBGBIELE002 pandora-core-0.40.0 pandora-core-0.42.0'
function invupg() {
    local device="${1}"
    shift
    inv --devices "${device}" --repo .. upgrade "$@"
}

# invdc: inventory download config
#
# Download the config file of a device into the inventory.
# @pre Current working directory must be '<inventory>/devices'
# @example 'invdc U-MRXBGBIELE002'
function invdc() {
    local device="${1}"
    download_command "${device}" /e2m/config.ini "${device}/config.ini"
}
