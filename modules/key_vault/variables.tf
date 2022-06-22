variable "create_current_user_access_policy" {
  description = "Set to True to create an access policy for the current logged in user"
  type        = bool
  default     = false
}

variable "create_resource_group" {
  description = "Whether to create resource group or not"
  type        = bool
  default     = false
}

variable "location" {
  description = "The location of the Key Vault (and/or Resource Group) to create in"
  type        = string
  default     = "Canada Central"
}

variable "name" {
  description = "The name of the Key Vault to created"
  type        = string
  default     = ""
}

variable "resource_group_name" {
  description = "The name of the Resource Group in which to create the Key Vault"
  type        = string
  default     = ""
}

variable "sku_name" {
  description = "The Name of the SKU used for this Key Vault. Possible values are standard and premium."
  type        = string
  default     = "standard"
}

variable "storage_account_access_key" {
  description = "The access key for the storage account used to store the keys in the Key Vault"
  type        = string
  default     = ""
}

variable "storage_account_access_key_name" {
  description = "The access key name for the storage account used to store the keys in the Key Vault"
  type        = string
  default     = ""
}   

variable "tags" {
  description = "A map of tags to add"
  type        = map(string)
  default     = {}
}
