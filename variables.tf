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
    create_nsg       = optional(bool, false)
    nsg_rules = optional(list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    })), [])
  }))
  default = {}


}
variable "spoke_dev_subnets" {
  type = map(object({
    address_prefixes = list(string)
    create_nsg       = optional(bool, false)
    nsg_rules = optional(list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    })), [])
  }))
  default = {}


}
variable "name_prefix" {
  type = string
}