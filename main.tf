provider "azurerm" {
  
}

resource "azurerm_resource_group" "resourcegroup" {
    name        = "${var.resource_group_name}"
    location    = "${var.location}"
  
}

resource "random_integer" "ri" {
    min = 10000
    max = 99999
  
}

resource "azurerm_app_service_plan" "default" {
    name                       = "viraltest-appservice"
    location                   = "${azurerm_resource_group.resourcegroup.location}"
    resource_group_name        = "${azurerm_resource_group.resourcegroup.name}"

    sku {
    tier    = "${var.app_service_plan_sku_tier}"
    size    = "${var.app_service_plan_sku_size}" 
    
    }
  
}

resource "azurerm_app_service" "appservice" {
    name                    = "viraltest-appservice"
    location                = "${azurerm_resource_group.resourcegroup.location}"
    resource_group_name     = "${azurerm_resource_group.resourcegroup.name}"
    app_service_plan_id     = "${azurerm_app_service_plan.default.id}"
  
}

resource "azurerm_app_service_slot" "appservice" {
    name                    = "viraltest-slotOne"
    location                = "${azurerm_resource_group.resourcegroup.location}"
    resource_group_name     = "${azurerm_resource_group.resourcegroup.name}"
    app_service_plan_id     = "${azurerm_app_service_plan.default.id}"
    app_service_name        = "${azurerm_app_service.appservice.name}"
  
}


output "app_service_name" {
  value = "${azurerm_app_service.appservice.name}"
}

output "app_service_default_hostname" {
  value = "https://${azurerm_app_service.appservice.default_site_hostname}"
}



