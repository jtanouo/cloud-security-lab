variable "resource_group_name" {
  type        = string
  default     = "rg-securitylab-dev"
  description = "Nom du Resource Group existant où déployer"
}

variable "location" {
  type        = string
  default     = "westeurope"
  description = "Région Azure"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment (dev, staging, prod)"
}

variable "owner" {
  type        = string
  default     = "japhet.tanouo"
  description = "Propriétaire (pour tagging)"
}

variable "project" {
  type        = string
  default     = "cloud-security-lab"
  description = "Propriétaire (pour tagging)"
}