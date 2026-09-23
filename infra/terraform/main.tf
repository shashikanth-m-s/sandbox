terraform {
  required_version = "1.16.3"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 4.75.00"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
}

