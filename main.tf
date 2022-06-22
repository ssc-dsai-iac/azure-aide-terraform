# ---------------------------------------------------------------------------------------------------------------------
# Azure Artifical Intelligence Development Environment - PBMM
# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------
# Resource group - Main
# ---------------------------------------------------------------------------------------------------------------------

module "resource_group" {
  source = "./modules/resource_group"

  name     = "${var.prefix}-${var.group}-${var.user_defined}-${var.env}-rg"
  location = var.location

  tags = {
    env        = var.env
    costcenter = var.costcenter
    ssn        = var.ssn
    subowner   = var.subowner
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# Key vault
# ---------------------------------------------------------------------------------------------------------------------

module "key_vault" {
  source = "./modules/key_vault"

  name                            = "${var.prefix}CSV-${var.group}-${var.user_defined}-kv"
  resource_group_name             = module.resource_group.resource_group_name
  location                        = module.resource_group.resource_group_location
  storage_account_access_key      = module.storage_account.storage_primary_access_key
  storage_account_access_key_name = var.storage_account_access_key_name


  tags = {
    env        = var.env
    costcenter = var.costcenter
    ssn        = var.ssn
    subowner   = var.subowner
  }

  depends_on = [module.resource_group, module.storage_account]
}

# ---------------------------------------------------------------------------------------------------------------------
# Databricks
# ---------------------------------------------------------------------------------------------------------------------

module "databricks" {
  source = "./modules/databricks"

  databricks_workspace_name       = "${var.prefix}CPS-${var.group}-${var.user_defined}-${var.env}-dbw"
  cluster_name                    = "Cheapest"
  resource_group_name             = module.resource_group.resource_group_name
  location                        = module.resource_group.resource_group_location
  key_vault_id                    = module.key_vault.key_vault_id
  key_vault_uri                   = module.key_vault.key_vault_uri
  secure_cluster_connectivity     = true
  storage_account_name            = module.storage_account.storage_account_name
  storage_account_access_key_name = var.storage_account_access_key_name

  tags = {
    env        = var.env
    costcenter = var.costcenter
    ssn        = var.ssn
    subowner   = var.subowner
  }

}

# ---------------------------------------------------------------------------------------------------------------------
# Storage Account
# ---------------------------------------------------------------------------------------------------------------------

module "storage_account" {
  source = "./modules/storage_account"

  storage_account_name      = "${var.prefix}csa${var.group}${var.user_defined}dls1"
  resource_group_name       = module.resource_group.resource_group_name
  location                  = module.resource_group.resource_group_location

  tags = {
    env        = var.env
    costcenter = var.costcenter
    ssn        = var.ssn
    subowner   = var.subowner
  }

  depends_on = [
    module.resource_group
  ]
}


# ---------------------------------------------------------------------------------------------------------------------
# Data Factory
# ---------------------------------------------------------------------------------------------------------------------

# module "datafactory" {
#   source = "git@github.com:SSC-DSAI/terraform-modules.git//azure/datafactory"

#   name                = "${var.prefix}CPS-${var.group}-${var.user_defined}-${var.env}-adf"
#   resource_group_name = module.resource_group.resource_group_name
#   location            = module.resource_group.resource_group_location

#   # Key vault link
#   key_vault_id = module.key_vault.key_vault_id

#   # Storage account link
#   storage_account_name  = module.datalake.name
#   csa_connection_string = module.datalake.primary_connection_string

#   tags = {
#     env        = var.env
#     costcenter = var.costcenter
#     ssn        = var.ssn
#     subowner   = var.subowner
#   }

#   depends_on = [module.resource_group, module.key_vault, module.datalake]

# }

# ---------------------------------------------------------------------------------------------------------------------
# Event Hubs
# ---------------------------------------------------------------------------------------------------------------------


# ---------------------------------------------------------------------------------------------------------------------
# Cognitive Services
# ---------------------------------------------------------------------------------------------------------------------