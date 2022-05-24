alias txst="docker run --rm --net=host -it ghcr.io/shopify/toxiproxy"
alias tx="docker run --rm --entrypoint="/toxiproxy-cli" -it --net=host ghcr.io/shopify/toxiproxy"
alias txl="docker run --rm --entrypoint="/toxiproxy-cli" -it --net=host ghcr.io/shopify/toxiproxy list"
alias txt="docker run --rm --entrypoint="/toxiproxy-cli" -it --net=host ghcr.io/shopify/toxiproxy toggle"
alias txcr="docker run --rm --entrypoint="/toxiproxy-cli" -it --net=host ghcr.io/shopify/toxiproxy create"
alias txde="docker run --rm --entrypoint="/toxiproxy-cli" -it --net=host ghcr.io/shopify/toxiproxy delete"


# Create a new 'failed_devices' directory in the according structures.
# The directory path is printed and exported as '$WORKDIR'.
function new_failed() {
    local vpp="$1"
    local today="$(date '+%Y%m%d')"
    local dirname="failed_devices_${today}"
    if [ "${vpp}" = "ger" ] ; then
        local instance_dir="Deutschland"
    elif [ "${vpp}" = "agregio" ] ; then
        local instance_dir="Agregio"
    else
        echo "Unknown VPP instance!"
        return 1
    fi
    export WORKDIR="${HOME}/Dokumente/Inventar/${instance_dir}/${dirname}"
    mkdir -p "${WORKDIR}" || echo "Failed to create new directory!"
    echo "New workdir: ${WORKDIR}"
}

function open_ssh_jumpserver() {
    local vpp="$1"

    if [ "${vpp}" = "agregio" ] ; then
        echo "[*] Login into cluster via tkgi as 'jonas.toth' ..."
        tkgi get-kubeconfig vpp-agregio -a api-pks-prod.energy2market.de -u jonas.toth -k
        echo "[*] Switching to new k8s context ..."
        kubectl config use-context vpp-agregio
        echo "[*] Activating correct port-forward for SSH Jumpserver ..."
        kubectl -n vpp-agregio port-forward deployment/ssh-jumpserver 20023:22 2>&1 > /dev/null &
    fi
}

# invls: inventory list
# 
# Show all devices tracked in the inventory.
# @pre Current working directory must be '<inventory>'
# @example 'invls'
function invls() {
    inv --devices "${1}" --repo . list
}

# invctl: inventory is controlling
# 
# Show all devices that are currently performing any control operation.
# @pre Current working directory must be '<inventory>'
# @example 'invctl'
function invctl() {
    remove_existing dead.list \
    | parallel --jobs 50 \
      ssh_command devices/{} "if ! PandoraQuery is-controlling --timeout 2000 \; then echo {} \; fi"
}

# invctlafrrstandby: inventory is exclusive aFRR standby
# 
# Show all devices that are currently exclusively in aFRR standby.
# @pre Current working directory must be '<inventory>'
# @example 'invctlafrrstandby'
function invctlafrrstandby() {
    remove_existing dead.list \
    | parallel --jobs 50 \
      ssh_command devices/{} "if PandoraQuery is-controlling --only-afrr-standby --timeout 2000 \; then echo {} \; fi"
}

# invctlfcr: inventory is exclusive FCR
# 
# Show all devices that are currently exclusively in FCR.
# @pre Current working directory must be '<inventory>'
# @example 'invctlfcr'
function invctlfcr() {
    remove_existing dead.list \
    | parallel --jobs 50 \
      ssh_command devices/{} "if PandoraQuery is-controlling --only-fcr --timeout 2000 \; then echo {} \; fi"
}

# invctlsched: inventory is exclusive schedules
# 
# Show all devices that are currently exclusively in schedules.
# @pre Current working directory must be '<inventory>'
# @example 'invctlsched'
function invctlsched() {
    remove_existing dead.list \
    | parallel --jobs 50 \
      ssh_command devices/{} "if PandoraQuery is-controlling --only-schedules --timeout 2000 \; then echo {} \; fi"
}

# invctlcsv: inventory control show csv
# 
# Show all control bits for the list of devices.
# @pre Current working directory must be '<inventory>'
# @example 'invctlcsv'
function invctlcsv() {
    remove_existing dead.list \
    | parallel --jobs 50 \
      ssh_command devices/{} "echo -n {}\, \; PandoraQuery is-controlling --csv --timeout 2000" \
    | column -t -s,
}

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

# invuc: inventory upload command
#
# Upload a file to a device.
# @pre Current working directory must be '<inventory>/devices'
# @example 'invuc U-MRXBGBIELE002'
function invuc() {
    local device="${1}"
    local local_path="${2}"
    local remote_path="${3}"
    upload_command "${device}" "${local_path}" "${remote_path}"
}

# invpingdead: inventory ping dead
#
# Create a list file of currently dead connections.
# @pre Current working directory must be '<inventory>'
# @example 'invpingdead'
function invpingdead() {
    inv --repo . ping 2>dead.list >/dev/null
}

# invnotify: inventory notify
#
# Sends a notification that an operation is finished.
function invnotify() {
    notify-send -u normal -t 5000 -a "inventory" "Inventory Command Done"
}
