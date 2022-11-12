resource "azurerm_virtual_machine_extension" "customscript" {
  name                       = "BootstrapVM"
  virtual_machine_id         = azurerm_linux_virtual_machine.this.id
  publisher                  = "Microsoft.Azure.Extensions"
  type                       = "CustomScript"
  type_handler_version       = 2.1
  auto_upgrade_minor_version = false
  protected_settings         = <<PROTECTED_SETTINGS
  {
    "script": "${base64encode(templatefile("${path.module}/provision/bootstrap.sh", { domain = "${var.vm_domain_name}" }))}"
  }
  PROTECTED_SETTINGS

  tags = local.tags
}
