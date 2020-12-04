# Elixir-FinalProject
En la raiz del proyecto se debe crear un archivo llamado variables.tf
adicinar la siguiente información:

variable "my_access_key" {
  description = "Access-key-for-AWS"
  default = "Access key ID"
}

variable "my_secret_key" {
  description = "Secret-key-for-AWS"
  default = "Secret access key"
}

variable "my_region" {
  default = "us-east-2"
}

variable "my_ami" {
  default = "ami-09558250a3419e7d0"
}

variable "my_instance_type"{
  default = "t2.small"
}
