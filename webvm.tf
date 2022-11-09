resource "azurerm_linux_virtual_machine" "webvm" {
  resource_group_name = var.resourcegroup_details.name
  location            = var.resourcegroup_details.location
  name                = format("webvm-%s", terraform.workspace)
  size                = "Standard_B1s"
  admin_username      = "qtdevops"
  admin_password      = "qttesting@1234"
  network_interface_ids = [
    azurerm_network_interface.web_nic.id
  ]
  disable_password_authentication = false
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

}

resource "null_resource" "cluster" {
  # 
  triggers = {
    version = var.runningversion
  }




  provisioner "remote-exec" {

    inline = [
      "sudo apt update",
      "sudo apt install nginx -y"
    ]

    connection {
      host     = azurerm_linux_virtual_machine.webvm.public_ip_address
      user     = "qtdevops"
      password = "qttesting@1234"

    }
  }

  provisioner "local-exec" {
    command = "sudo ansible-playbook -i ${azurerm_network_interface.web_nic.publicip} playbook.yaml"
  }

  depends_on = [
    azurerm_linux_virtual_machine.webvm
  ]



}



