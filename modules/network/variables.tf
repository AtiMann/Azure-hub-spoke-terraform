variable "resource_group_name" {
    type = string
    description = "A resource group neve."
}
variable "location"{
    type = string
    description = "Azure régió."
}  
variable "vnet_name" {
    type = string
  
}
variable "address_space" {
type = list(string)
  
}
variable "subnets" {
    type = map(object({
      address_prefixes =list(string) 
      create_nsg = optional(bool,false)
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
})),[])
}))
    default = {}


}
  
