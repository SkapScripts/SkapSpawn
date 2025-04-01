RegisterNetEvent("skapsell:sellItem", function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = Player.Functions.GetItemByName(data.name)

    if item and item.amount >= 1 then
        Player.Functions.RemoveItem(data.name, 1)
        Player.Functions.AddMoney(Config.BankType, data.price)
        TriggerClientEvent("QBCore:Notify", src, "You sold " .. data.name .. " for $" .. data.price, "success")
    else
        TriggerClientEvent("QBCore:Notify", src, "You do not have enough of this item!", "error")
    end
end)

RegisterServerEvent("skapshop:purchaseItem", function(shopName, itemName, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.Functions.RemoveMoney("cash", price) then
        Player.Functions.AddItem(itemName, 1)
        TriggerClientEvent('QBCore:Notify', src, "You bought 1st " .. itemName .. " for $" .. price, "success")
    else
        TriggerClientEvent('QBCore:Notify', src, "You can't afford it!", "error")
    end
end)

RegisterCommand("givecash", function(source, args, rawCommand)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local amount = tonumber(args[1])
    
    if not amount or amount <= 0 then
        TriggerClientEvent('QBCore:Notify', src, "Invalid amount", "error")
        return
    end
    
    if Player.PlayerData.money.cash < amount then
        TriggerClientEvent('QBCore:Notify', src, "You don't have enough cash", "error")
        return
    end
    
    local nearestPlayer = GetNearestPlayer(src, 2.0)
    if not nearestPlayer then
        TriggerClientEvent('QBCore:Notify', src, "No player nearby", "error")
        return
    end
    
    local TargetPlayer = QBCore.Functions.GetPlayer(nearestPlayer)
    if TargetPlayer then
        Player.Functions.RemoveMoney("cash", amount)
        TargetPlayer.Functions.AddMoney("cash", amount)
        
        TriggerClientEvent('QBCore:Notify', src, "You gave $" .. amount .. " to " .. TargetPlayer.PlayerData.charinfo.firstname, "success")
        TriggerClientEvent('QBCore:Notify', nearestPlayer, "You got $" .. amount .. " from " .. Player.PlayerData.charinfo.firstname, "success")
    else
        TriggerClientEvent('QBCore:Notify', src, "Could not find the player", "error")
    end
end, false)

function GetNearestPlayer(playerId, radius)
    local players = QBCore.Functions.GetPlayers()
    local closestPlayer = nil
    local closestDistance = radius
    local playerPed = GetPlayerPed(playerId)
    local playerCoords = GetEntityCoords(playerPed)
    
    for _, otherPlayerId in pairs(players) do
        if otherPlayerId ~= playerId then
            local otherPed = GetPlayerPed(otherPlayerId)
            local otherCoords = GetEntityCoords(otherPed)
            local distance = #(playerCoords - otherCoords)
            
            if distance < closestDistance then
                closestPlayer = otherPlayerId
                closestDistance = distance
            end
        end
    end
    return closestPlayer
end

RegisterNetEvent("SkapBoost:CheckAdmin", function(boostLevel)
    local src = source

    if Config.OnlyAdmins and not QBCore.Functions.HasPermission(src, "admin") then
        TriggerClientEvent("QBCore:Notify", src, "You are not authorized to use this command!", "error")
        return
    end

    TriggerClientEvent("SkapBoost:ApplyBoost", src, boostLevel)
end)
