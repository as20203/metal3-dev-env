#!/bin/bash

#!/bin/bash
set -x

SCRIPT_DIR=$(dirname "$(readlink -f "${0}")")
ROOTPATH="${SCRIPT_DIR}/../../.."

# shellcheck disable=SC1091
source "${ROOTPATH}/lib/logging.sh"
# shellcheck disable=SC1091
source "${ROOTPATH}/lib/common.sh"

# TODO: Get first worker node from provisioned m3m deployment

# Patch the first BMH in the deployment with the live-iso disk format
kubectl patch m3m <worker> -n ${NAMESPACE} --patch-file ${SCRIPT_DIR}/live_iso_patch.yaml --type merge

# TODO: ^ the above command is currently broken because of the bug #500 in CAPM3. 
# You can try with the bmh resource directly instead:
#kubectl patch m3m node-0 -n ${NAMESPACE} --patch-file ${SCRIPT_DIR}/live_iso_patch.yaml --type merge

# Wait until bmh is provisioned

# Try ssh to the bmh (if the .iso actually booted into something which was running sshd)
