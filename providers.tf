terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "storage"
    storage_account_name = "bhavish"
    container_name       = "terraform"
    key                  = "terraform.tfstate"

  }
}

provider "azurerm" {
  # Configuration options
  features {

  }
  subscription_id = "00000000-0000-0000-0000-000000000000."
}