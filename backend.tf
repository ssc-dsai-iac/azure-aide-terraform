terraform {
  backend "azurerm" {
    subscription_id      = "ef37636a-de30-4451-89a9-e261af46efbf"
    resource_group_name  = "ScSc-DSAI-Terraform-rg"
    storage_account_name = "scsccsadsaiterraformdls2"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}