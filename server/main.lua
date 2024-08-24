local QBCore = exports['qb-core']:GetCoreObject()

local plate = nil

QBCore.Functions.CreateCallback('ls-carboosting:boost:checklevel', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    MySQL.single('SELECT * FROM players WHERE citizenid = ?', {Ply.PlayerData.citizenid}, function(result)
        if result then
            cb(result.level, result.lvlpro, Ply.PlayerData.charinfo.firstname..' '..Ply.PlayerData.charinfo.lastname)
        end
    end)
end)

RegisterNetEvent("ls-carboosting:tracker:carthief", function(hackplate)
    local src = source
    plate = hackplate
    if src then
        local coords = GetEntityCoords(GetPlayerPed(src))
        local location = {x=coords.x,y=coords.y,z=coords.z,w=heading}
        TriggerClientEvent('ls-carboosting:tracker:carthief:client', -1, location)     
    end
end)

RegisterNetEvent("ls-carboosting:stopeve:carthief", function(value)
    plate = nil
    TriggerClientEvent('ls-carboosting:stopeve:carthief:client', -1, value)  
end)

RegisterNetEvent("ls-carboosting:carthief:server:cooldown", function(value)
    TriggerClientEvent('ls-carboosting:carthief:client:cooldown', -1, value)  
end)

QBCore.Functions.CreateUseableItem(Config.HackDevice, function(source, item)
	TriggerClientEvent('ls-carboosting:hack:carthief', source, plate)
end)

RegisterNetEvent("ls-carboosting:carthief:server:reward", function(xp, nitro)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    Ply.Functions.AddItem(Config.DealerCurrency, nitro)
    MySQL.single('SELECT * FROM players WHERE citizenid = ?', {Ply.PlayerData.citizenid}, function(result)
        if result then
            local updateXP = MySQL.update.await('UPDATE players SET lvlpro = ? WHERE citizenid = ?', {result.lvlpro+xp, Ply.PlayerData.citizenid})
            if updateXP >= 100 then
                MySQL.update.await('UPDATE players SET level = ? WHERE citizenid = ?', {result.level+1, Ply.PlayerData.citizenid})
                MySQL.update.await('UPDATE players SET lvlpro = ? WHERE citizenid = ?', {0, Ply.PlayerData.citizenid})
                TriggerClientEvent('cs:carthief:notify', src, "You Earned a Level, Current Level: "..result.level+1, 'success')
            end
        end
    end)
    TriggerClientEvent('cs:carthief:notify', src, "Earned XP: "..xp..", Lionel: "..nitro, 'success')
end)

RegisterServerEvent("ls-carboosting:carthief:shop:buy", function(itemName, amount, price, label)
    local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
    local amount = tonumber(amount)
    local item
    item = xPlayer.Functions.GetItemByName(Config.DealerCurrency)
    if item and item.amount >= price * amount then
        if xPlayer.Functions.RemoveItem(Config.DealerCurrency, price * amount) then
            xPlayer.Functions.AddItem(itemName, amount, "lionel-items")
            TriggerClientEvent("cs:carthief:notify", source, "Purchased! "..label..' for Lionel '..price * amount, "success", 5000)
            TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[itemName], "add")
        end
    else
        TriggerClientEvent("cs:carthief:notify", source, "Not much Lionels!", "error", 5000)
    end
end)