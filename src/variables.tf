// AUthor: Jake G
// Date: 2024
// Filename: variables.tf 

variable "instance_name" {
  description = "Terraform setup minecraft server"
  type        = string
  default     = "minecraft-server"
}

variable "instance_type" {
  description = "Type of EC2 Instance"
  type        = string
  default     = "t3.small"
}

variable "ami" {
  description = "Type of AMI"
  type        = string
  default     = "ami-00beae93a2d981137" // Amazon Linux AMI(2023)
}

variable "key_name" {
  description = "Name of the ssh key for the e2c"
  type        = string
  default     = "minecraft-key.pem"
}
