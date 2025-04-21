resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix_name}-rg"
  location = var.region
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix_name}-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.prefix_name}-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_container_group" "redis" {
  name                = "${var.prefix_name}-redis-container"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"

  container {
    name   = "redis"
    image  = "redis:7.0"
    cpu    = "0.5"
    memory = "1.5"

  }

  subnet_ids = [azurerm_subnet.subnet.id]
}

resource "azurerm_container_group" "log_processor" {
  name                = "${var.prefix_name}-log-processor-container"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"

  container {
    name   = "log-processor"
    image  = "your-dockerhub-user/log-message-processor:latest"
    cpu    = "0.5"
    memory = "1.5"

  }

  subnet_ids = [azurerm_subnet.subnet.id]
}

resource "azurerm_container_group" "todos_api" {
  name                = "${var.prefix_name}-todos-api-container"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"

  container {
    name   = "todos-api"
    image  = "your-dockerhub-user/todos-api:latest"
    cpu    = "0.5"
    memory = "1.5"

  }

  subnet_ids = [azurerm_subnet.subnet.id]
}

resource "azurerm_container_group" "auth_api" {
  name                = "${var.prefix_name}-auth-api-container"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"

  container {
    name   = "auth-api"
    image  = "your-dockerhub-user/auth-api:latest"
    cpu    = "0.5"
    memory = "1.5"
  }

  subnet_ids = [azurerm_subnet.subnet.id]
}

resource "azurerm_container_group" "user_api" {
  name                = "${var.prefix_name}-user-api-container"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"

  container {
    name   = "user-api"
    image  = "your-dockerhub-user/users-api:latest"
    cpu    = "0.5"
    memory = "1.5"

  }

  subnet_ids = [azurerm_subnet.subnet.id]
}

resource "azurerm_container_group" "frontend" {
  name                = "${var.prefix_name}-frontend-container"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"

  container {
    name   = "frontend"
    image  = "your-dockerhub-user/frontend:latest"
    cpu    = "0.5"
    memory = "1.5"

  }

  subnet_ids = [azurerm_subnet.subnet.id]
}
