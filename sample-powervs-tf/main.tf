data "ibm_pi_network" "network" {
    pi_network_name      = var.network
    pi_cloud_instance_id = var.power_instance_id
}

data "ibm_pi_image" "power_images" {
    pi_image_name        = var.image_name
    pi_cloud_instance_id = var.power_instance_id
}

resource "ibm_pi_instance" "pvminstance" {
    pi_memory             = var.memory
    pi_processors         = var.processors
    pi_instance_name      = var.vm_name
    pi_proc_type          = var.proc_type
    pi_image_id           = data.ibm_pi_image.power_images.id
    pi_network {
      network_id = data.ibm_pi_network.network.id
    }
    pi_key_pair_name      = var.ssh_key_name
    pi_sys_type           = var.system_type
    pi_cloud_instance_id  = var.power_instance_id
    pi_user_data          = base64encode(file("user.ign"))
    pi_health_status      = "WARNING"
}

