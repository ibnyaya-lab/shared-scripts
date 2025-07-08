variable "location" {
  description = "Région Azure où déployer les ressources"
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "Nom du groupe de ressources"
  type        = string
  default     = "rg-test-example"
}

variable "vm_admin_username" {
  description = "Nom d'utilisateur administrateur pour les machines virtuelles"
  type        = string
  default     = "azureuser"
}

variable "pg_admin_username" {
  description = "Nom d'utilisateur admin pour PostgreSQL"
  type        = string
  default     = "pgadmin"
}

variable "pg_password" {
  description = "Mot de passe administrateur de la base PostgreSQL"
  type        = string
  sensitive   = true
}

variable "vm_size" {
  description = "Taille des VMs"
  type        = string
  default     = "Standard_B1s"
}

variable "frontend_vm_name" {
  description = "Nom de la VM frontend"
  type        = string
  default     = "vm-frontend"
}

variable "backend_vm_name" {
  description = "Nom de la VM backend"
  type        = string
  default     = "vm-backend"
}

variable "environment" {
  description = "Nom de l'environnement (dev, staging, prod...)"
  type        = string
  default     = "dev"
}
