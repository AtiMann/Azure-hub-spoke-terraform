variable "rg_name" {
    type = string
  
}
variable "location" {
  type = string
}
variable "hub_address_space" {
  type = list(string)
}
variable "spoke_dev_address_space" {
  type = list(string)
}
variable "hub_subnets" {
  type = map(object({
    address_prefixes = list(string)
  }))
}
variable "spoke_dev_subnets" {
  type = map(object({
    address_prefixes = list(string)
  }))
}