variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "vm_name" {
  type = string
}
variable "vm_size" {
  type    = string
  default = "Standard_B1s"
}
variable "admin_username" {
  type = string
}
variable "admin_password" {
  type      = string
  sensitive = true
}
variable "subnet_id" {
  type = string
}