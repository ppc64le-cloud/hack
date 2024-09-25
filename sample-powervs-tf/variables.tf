
variable "ibmcloud_api_key" {
    description = "Denotes the IBM Cloud API key to use"
}

variable "ibmcloud_region" {
    description = "Denotes which IBM Cloud region to connect to"
    default     = "dal"
}

#INSERTED FOR MULTI-ZONE REGION SUCH AS FRANKFURT
variable "ibmcloud_zone" {
    description = "Denotes which IBM Cloud zone to connect to - .i.e: eu-de-1 eu-de-2  us-south etc."
    default     = "dal10"
}

variable "vm_name" {
    description = "Name of the VM"
    default     = "cluster10-node-ppc64le-1"
}

# Got the ID from `ibmcloud resource service-instances --long field` command, refer GUID for the instance
variable "power_instance_id" {
    description = "Power Virtual Server instance ID associated with your IBM Cloud account (note that this is NOT the API key)"
    default = "88951d2f-cd55-4157-8d5d-74ada2d7c6c3"
}

variable "memory" {
    description = "Amount of memory (GB) to be allocated to the VM"
    default     = "16"
}

variable "processors" {
    description = "Number of virtual processors to allocate to the VM"
    default     = "0.5"
}

variable "proc_type" {
    description = "Processor type for the LPAR - shared/dedicated"
    default     = "shared"
}

variable "ssh_key_name" {
    description = "SSH key name in IBM Cloud to be used for SSH logins"
    default     = "mkumatag"
}

variable "shareable" {
    description = "Should the data volume be shared or not - true/false"
    default     = "true"
}

variable "network" {
    description = "List of networks that should be attached to the VM - Create this network before running terraform"
    default     = "public-192_168_232_176-29-VLAN_2086"
}

variable "system_type" {
    description = "Type of system on which the VM should be created - s922/e880"
    default     = "s1022"
}

variable "image_name" {
    description = "Name of the image from which the VM should be deployed - IBM i image name"
    default     = "5f67f0fe-3873-4410-824e-b6781b023dfd"
}

variable "replication_policy" {
    description = "Replication policy of the VM"
    default     = "none"
}

variable "replication_scheme" {
    description = "Replication scheme for the VM"
    default     = "suffix"
}

variable "replicants" {
    description = "Number of VM instances to deploy"
    default     = "1"
}
