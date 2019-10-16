output "registry_id" {
  value       = aws_ecr_repository.ecr_repository.registry_id
  description = "Registry ID"
}

output "registry_url" {
  value       = aws_ecr_repository.ecr_repository.repository_url
  description = "Registry URL"
}

output "repository_name" {
  value       = aws_ecr_repository.ecr_repository.name
  description = "Registry name"
}