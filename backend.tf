terraform {
  backend "azurerm" {
    resource_group_name  = "ScSc-DSAI-Terraform-rg"
    storage_account_name = "scsccsadsaiterraformdls3"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}