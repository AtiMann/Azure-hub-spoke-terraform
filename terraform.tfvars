rg_name = "rg-enterprise-hubspoke"
location = "northeurope"

hub_address_space = ["10.0.0.0/16"]
spoke_dev_address_space = ["10.5.0.0/16"]


hub_subnets = {
    "AzureFirewallSubnet" = {address_prefixes = ["10.0.1.0/26"]}
    "BastionSubnet" = {address_prefixes = ["10.0.2.0/27"]}
}
spoke_dev_subnets = {
    "snet-app" = {address_prefixes = ["10.5.1.0/24"]}
    "snet-db" = {address_prefixes = ["10.5.2.0/24"]}
}