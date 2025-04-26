RegisterNetEvent("skapsell:sellItem", function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = Player.Functions.GetItemByName(data.name)
    local seller
    for _, s in pairs(Config.Sellers) do
        if s.name == data.sellerName then
            seller = s
            break
        end
    end
    
    if not seller then
        print("Ogiltig säljare:", data.sellerName)
        return
    end
    

    local itemData = nil
    for _, v in pairs(seller.itemsForSale) do
        if v.name == data.name then
            itemData = v
            break
        end
    end

    if not itemData then
        TriggerClientEvent("QBCore:Notify", src, "Denna vara kan inte säljas här.", "error")
        return
    end

    local price = math.random(itemData.minPrice, itemData.maxPrice)

    if item and item.amount >= 1 then
        Player.Functions.RemoveItem(data.name, 1)
        Player.Functions.AddMoney(Config.BankType, price)
        TriggerClientEvent("QBCore:Notify", src, "Du sålde " .. data.name .. " för $" .. price, "success")
    else
        TriggerClientEvent("QBCore:Notify", src, "Du har inte tillräckligt av denna vara!", "error")
    end
end)


RegisterServerEvent("skapshop:purchaseItem", function(shopName, itemName, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.Functions.RemoveMoney("cash", price) then
        Player.Functions.AddItem(itemName, 1)
        TriggerClientEvent('QBCore:Notify', src, "Du köpte 1st " .. itemName .. " för $" .. price, "success")
    else
        TriggerClientEvent('QBCore:Notify', src, "Du har inte råd!", "error")
    end
end)

RegisterCommand("givecash", function(source, args, rawCommand)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local amount = tonumber(args[1])
    
    if not amount or amount <= 0 then
        TriggerClientEvent('QBCore:Notify', src, "Ogiltigt belopp", "error")
        return
    end
    
    if Player.PlayerData.money.cash < amount then
        TriggerClientEvent('QBCore:Notify', src, "Du har inte tillräckligt med kontanter", "error")
        return
    end
    
    local nearestPlayer = GetNearestPlayer(src, 2.0)
    if not nearestPlayer then
        TriggerClientEvent('QBCore:Notify', src, "Ingen spelare i närheten", "error")
        return
    end
    
    local TargetPlayer = QBCore.Functions.GetPlayer(nearestPlayer)
    if TargetPlayer then
        Player.Functions.RemoveMoney("cash", amount)
        TargetPlayer.Functions.AddMoney("cash", amount)
        
        TriggerClientEvent('QBCore:Notify', src, "Du gav $" .. amount .. " till " .. TargetPlayer.PlayerData.charinfo.firstname, "success")
        TriggerClientEvent('QBCore:Notify', nearestPlayer, "Du fick $" .. amount .. " från " .. Player.PlayerData.charinfo.firstname, "success")
    else
        TriggerClientEvent('QBCore:Notify', src, "Kunde inte hitta spelaren", "error")
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
        TriggerClientEvent("QBCore:Notify", src, "Du har inte behörighet att använda detta kommando!", "error")
        return
    end

    TriggerClientEvent("SkapBoost:ApplyBoost", src, boostLevel)
end)