variable "client_id" {
  description = "The Client ID of the Service Principal."
  type        = string
}

variable "client_secret" {
  description = "The Client Secret of the Service Principal."
  type        = string
  sensitive   = true
}

variable "subscription_id" {
  description = "ID of the Azure Subscription."
  type        = string
}

variable "tenant_id" {
  description = "Azure tenant ID."
  type        = string
}
