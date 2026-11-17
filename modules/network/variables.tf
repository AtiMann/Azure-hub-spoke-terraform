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
    }))
    default = {}

}
  
