variable "location" {
  description = "Specifies the supported Azure location where the resource exists."
  type        = string
  default = "Canada Central"
}

variable "name" {
  description = "Specifies the name of the Resource Group"
  type        = string
  default = ""
}

variable "tags" {
  description = "A map of tags to add"
  type        = map(string)
  default = {}
}