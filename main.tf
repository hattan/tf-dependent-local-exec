resource "azurerm_resource_group" "example" {
    name     = "gmhstest1"
    location = "West US"
    tags = {
        "test"        = "foo3"
        "test2"       = "bar2"
    }
}

resource "null_resource" "custom_script" {
    provisioner "local-exec" {
        command = "echo ${azurerm_resource_group.example.location} >> out.txt"
    }

    triggers = {
        rg_tags = azurerm_resource_group.example.tags.test
    }
    depends_on = [
        azurerm_resource_group.example
    ] 
}