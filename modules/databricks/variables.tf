variable "cluster_name" {
  description = "Variable used to name the Databricks Cluster"
  type        = string
  default     = "Cheapest"
}

variable "cluster_autotermination_minutes" {
  description = "Variable used to set the autotermination minutes"
  type        = number
  default     = 20
}

variable "cluster_min_workers" {
  description = "Variable used to set the minimum number of workers"
  type        = number
  default     = 1
}
  
variable "cluster_max_workers" {
  description = "Variable used to set the maximum number of workers"
  type        = number
  default     = 2
}

variable "databricks_workspace_name" {
  description = "Specifies the name of the Databricks Workspace"
  type        = string
  default     = ""
}
variable "databricks_secret_scope_name" {
  description = "Specifies the name of the Databricks Secret Scope"
  type        = string
  default = "key-vault-secrets"
}

variable "sql_endpoint_name" {
  description = "Specifies the name of the Databricks SQL Endpoint"
  type        = string
  default     = "Cheapest"
}

variable "sql_endpoint_cluster_size" {
  description = "Specifies the size of the Databricks SQL Endpoint Cluster. Valid options are 2X-Small, Small, Medium, Large, X-Large, 2X-Large, 3X-Large, and 4X-Large"
  type        = string
  default     = "2X-Small"
}

variable "sql_endpoint_cluster_auto_stop_mins" {
  description = "Specifies the number of minutes before the Databricks SQL Endpoint Cluster is automatically stopped"
  type        = number
  default     = 15
}

variable "sql_endpoint_cluster_autoscale_min_workers" {
  description = "Specifies the minimum number of workers for the Databricks SQL Endpoint Cluster"
  type        = number
  default     = 1
}
  
variable "sql_endpoint_cluster_autoscale_max_workers" {
  description = "Specifies the maximum number of workers for the Databricks SQL Endpoint Cluster"
  type        = number
  default     = 2
}

variable "key_vault_id" {
  description = "The ID of the Key Vault where the access policy should be created"
  type        = string
  default     = ""
}

variable "key_vault_uri" {
  description = "The URI of the Key Vault where the access policy should be created"
  type        = string
  default     = ""
}
variable "location" {
  description = "Specifies the supported Azure location where the resource exists"
  type        = string
  default     = "canada central"
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create"
  type        = string
  default     = ""
}

variable "sku" {
  description = "The sku to use for the Databricks Workspace. Possible values are standard, premium, or trial"
  type        = string
  default     = "premium"
}

variable "secure_cluster_connectivity" {
  description = "Specifies whether to use secure cluster connectivty"
  type        = bool
  default     = false
}

variable "storage_account_name" {
  description = "The name of the storage account to use for the Databricks Workspace"
  type        = string
  default     = ""
}

variable "storage_account_access_key_name" {
  description = "The name of the storage account access key to use for the Databricks Workspace"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add"
  type        = map(string)
  default     = {}
}