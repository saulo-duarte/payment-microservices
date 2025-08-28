variable "aws_region" {
  description = "AWS Region"
  default     = "sa-east-1"
}

variable "project_name" {
  description = "Nome do projeto"
  default     = "digital_bank"
}

variable "db_username" {
  type        = string
  description = "Username do banco"
  sensitive   = true
}

variable "db_password" {
  type        = string
  description = "Senha do banco"
  sensitive   = true
}