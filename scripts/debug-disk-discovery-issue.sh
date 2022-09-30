#!/usr/bin/env bash

######################
## Prereq:
## - ibmcloud:
##   curl -fsSL https://clis.cloud.ibm.com/install/linux | sh
##   ibmcloud plugin install pi
## - jq
##   dnf install jq
## - Modify the REGION, ZONE, CLOUD_INSTANCE_NAME, pvm_instance_name
## Usage:
## IBMCLOUD_API_KEY=<API_KEY> debug-disk-discovery-issue.sh
set -o errexit
set -o nounset
set -o pipefail
set -o xtrace

IBMCLOUD_API_KEY=${IBMCLOUD_API_KEY:-}
REGION=${REGION:-osa}
ZONE=${ZONE:-osa21}
CLOUD_INSTANCE_NAME=${CLOUD_INSTANCE_NAME:-"rdr-upstream-osa21"}
pvm_instance_name=${pvm_instance_name:-"mkumatag-debug-disk-issue"}

ibmcloud login -a cloud.ibm.com -r us-east --apikey "${IBMCLOUD_API_KEY}"

TOKEN=$(ibmcloud iam oauth-tokens --output JSON | jq -r ".iam_token")

CRN=$(ibmcloud pi sl --json | jq -r ".[]|select(.Name == \"${CLOUD_INSTANCE_NAME}\")|.CRN")

CLOUD_INSTANCE_ID=$(echo "${CRN}"|  cut -d ":" -f 8)
BASE_URL="https://${REGION}.power-iaas.cloud.ibm.com/pcloud/v1/cloud-instances/${CLOUD_INSTANCE_ID}"


function ibmcloud_api() {
  body=${3:-}
  curl -v -f -X "$1" "${BASE_URL}/$2" -H "Authorization: ${TOKEN}" -H "CRN: ${CRN}" -H 'Content-Type: application/json' $([[ -n "$body" ]] && echo "-d $body")
}

pvm_instance_id=$(ibmcloud_api "GET" "pvm-instances" | jq -r ".pvmInstances[]|select(.serverName == \"${pvm_instance_name}\")|.pvmInstanceID")

# '{"diskType":"tier3","name":"volume-name-1","shareable":true,"size":1}'
for ((i=1;i<=100;i++));
do
   bb="{\"diskType\":\"tier3\",\"name\":\"volume-name-${i}\",\"shareable\":true,\"size\":1}"

   volume_id=$(ibmcloud_api "POST" "volumes" $bb | jq -r ".volumeID")

   sleep 10
   ibmcloud_api "POST" "/pvm-instances/${pvm_instance_id}/volumes/${volume_id}" | jq

   sleep 10

   for host in /sys/class/scsi_host/*
   do
       echo "- - -" > "$host/scan"
   done

   wwn_id=$(ibmcloud_api "GET" "volumes/${volume_id}" | jq -r ".wwn" | tr '[:upper:]' '[:lower:]')

   ls -l "/dev/disk/by-id/wwn-0x${wwn_id}"
done
