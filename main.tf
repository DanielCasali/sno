locals {
  chrony_config = <<-EOT
    # Add your chrony configuration here
    server ${var.internal_vpc_dns1} iburst
    server ${var.internal_vpc_dns2} iburst
    driftfile /var/lib/chrony/drift
    makestep 1.0 3
    rtcsync
    logdir /var/log/chrony
  EOT
}

data "ignition_file" "chrony_config" {
  filesystem = "root"
  path       = "/etc/chrony.conf"
  mode       = "0644"
  content {
    content = base64encode(local.chrony_config)
  }
}
