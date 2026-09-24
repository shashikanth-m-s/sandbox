terraform {
  required_version = "1.16.3"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 4.21.36"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}