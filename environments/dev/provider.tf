terraform {
    required_providers {
        azurerm = {
        source  = "hashicorp/azurerm"
        version = "4.57.0"
        }
    }
}
provider "azurerm" {
    features {}
    subscription_id = "6bd4dbd2-5b96-4db5-b492-0b8360c1116b"
}
#$resources.Count