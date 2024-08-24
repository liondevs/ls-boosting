# INSTALLATION

## Dependancies
- This script requires `LegacyFuel/ps-fuel` or other fuel scirpt
- This script requires `qb-target` or any other target
- This script requires `qb-menu/esx` esx is deault menu that comes with ESX Legacy
- This script requires `qb-input` for the menus to work any server can use this its standalone it will work on ESX aswell (qb-input:https://github.com/qbcore-framework/qb-input)

## Installation [QBCore]
- Add the image files from the image folder to your `qb-inventory > html > images` folder
- Add these lines to your qb-core > shared lua under the Items section
```lua
	["nitroradio"] = {
		["name"] = "nitroradio", 			  	
		["label"] = "Nitro Radio ", 		
		["weight"] = 1000, 		
		["type"] = "item", 		
		["image"] = "nitroradio.png", 	
		["unique"] = false,
		["useable"] = true, 	
		["shouldClose"] = true,	   
		["combinable"] = nil,   
		["description"] = "You can use this in Contracts"
	},
	["nitrocash"] = {
		["name"] = "nitrocash", 			  	
		["label"] = "Nitro Cash ", 		
		["weight"] = 0, 		
		["type"] = "item", 		
		["image"] = "nitrocash.png", 	
		["unique"] = false,
		["useable"] = false, 	
		["shouldClose"] = false,	   
		["combinable"] = nil,   
		["description"] = "You can buy some cool stuff with this"
	},
```
- Execute installQB.sql into database
- Configure shared.lua according to your needs
- start ls-boosting

## Installation [OxInventory]
- Add the image files from the image folder to your `ox_inventory > web > images` folder
- Add these lines to your `ox_inventory > data > items.lua`
```lua
	['nitroradio'] = {
		label = 'Nitro Radio ',
		weight = 1000,
		stack = false
	},

	['nitrocash'] = {
		label = 'Nitro Cash ',
		weight = 0,
		stack = true
	},
```

## Installation [ESX]
- Add the image files from the image folder to your `inventory` folder
- Execute installESX.sql into database for items and level system
- Configure shared.lua according to your needs
- start ls-boosting