#!/bin/bash
az group create --name jenkinsfromcli --location eastus
az network vnet create --resource-group jenkinsfromcli --name vnet1 --address-prefixes 10.0.0.0/16q
az network vnet subnet create -g jenkinsfromcli --vnet-name vnet1 --name app --address-prefixes 10.0.0.0/24
az network vnet subnet create -g jenkinsfromcli --vnet-name vnet1 --name web --address-prefixes 10.0.1.0/24
 az network nsg create --name webnsg --resource-group jenkinsfromcli --location eastus 
az network nsg rule create --name allowall --nsg-name webnsg --priority 409 --resource-group jenkinsfromcli --access Allow --direction Inbound --protocol Tcp --source-port-ranges *
az vm create --resource-group jenkinsfromcli --location eastus  --name forweb   --admin-username murali --admin-password Devps@123456   --public-ip-sku Standard --size Standard_B1s --image UbuntuLTS