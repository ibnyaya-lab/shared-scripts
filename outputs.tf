# IP publique de la VM frontend
output "frontend_public_ip" {
  description = "Adresse IP publique de la VM frontend"
  value       = azurerm_public_ip.frontend_public_ip.ip_address
}

# IP publique de la VM backend (si elle en a une)
output "backend_public_ip" {
  description = "Adresse IP publique de la VM backend"
  value       = azurerm_public_ip.backend_ip.ip_address
}

# IP privée de la VM frontend
output "frontend_private_ip" {
  description = "Adresse IP privée de la VM frontend"
  value       = azurerm_network_interface.nic_frontend.private_ip_address
}

# IP privée de la VM backend
output "backend_private_ip" {
  description = "Adresse IP privée de la VM backend"
  value       = azurerm_network_interface.nic_backend.private_ip_address
}

output "database_hostname" {
  description = "Nom d’hôte de la base PostgreSQL Flexible Server"
  value       = azurerm_postgresql_flexible_server.db_flexible_server.fqdn
}
