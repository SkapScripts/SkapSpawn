local spawnedPeds = {}
local spawnedProps = {}
local Zones = {}
local Blips = {}
local blockedSellers = {}
local originalHandling = {}

function SpawnBlips()
    for _, blipData in pairs(Config.Blips) do
        local blip = AddBlipForCoord(blipData.coords.x, blipData.coords.y, blipData.coords.z)
        SetBlipSprite(blip, blipData.sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, blipData.scale)
        SetBlipColour(blip, blipData.color)
        SetBlipAsShortRange(blip, true)
        
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(blipData.name)
        EndTextCommandSetBlipName(blip)

        table.insert(Blips, blip)
    end
end

CreateThread(function()
    SpawnBlips()
    for _, pedData in pairs(Config.Peds) do
    end
    for _, propData in pairs(Config.Props) do
        SpawnProp(propData)
    end
end)

function SetPedArmed(ped, weapon)
    GiveWeaponToPed(ped, GetHashKey(weapon), 999, false, true)
    SetCurrentPedWeapon(ped, GetHashKey(weapon), true) 
    SetPedCanSwitchWeapon(ped, true)
    SetPedDropsWeaponsWhenDead(ped, false) 
end


function SetPedAggressive(ped, weapon)
    GiveWeaponToPed(ped, GetHashKey(weapon), 999, false, true)
    SetPedCombatAttributes(ped, 46, true)
    TaskCombatPed(ped, PlayerPedId(), 0, 16)
end

function SpawnPed(pedData)
    local pedModel = pedData.peds[math.random(#pedData.peds)] 
    local scenario = Config.PedScenarios[math.random(#Config.PedScenarios)]

    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do
        Wait(100)
    end

    local ped = CreatePed(4, GetHashKey(pedModel), pedData.coords.x, pedData.coords.y, pedData.coords.z - 1.0, pedData.heading, false, true)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    if pedData.weapon then
        GiveWeaponToPed(ped, GetHashKey(pedData.weapon), 999, false, true)
        if pedData.holdWeapon then
            SetCurrentPedWeapon(ped, GetHashKey(pedData.weapon), true)
        end
    end

    if pedData.aggressive then
        TaskCombatHatedTargetsAroundPed(ped, 50.0, 0)
    elseif not pedData.holdWeapon then
        TaskStartScenarioInPlace(ped, scenario, 0, true)
    end

    table.insert(spawnedPeds, ped)
end


function SpawnProp(propData)
    RequestModel(propData.model)
    while not HasModelLoaded(propData.model) do
        Wait(100)
    end

    local prop = CreateObject(GetHashKey(propData.model), propData.coords.x, propData.coords.y, propData.coords.z, false, true, false)
    SetEntityHeading(prop, propData.heading)
    FreezeEntityPosition(prop, true)

    table.insert(spawnedProps, prop)
end

CreateThread(function()
    for _, pedData in pairs(Config.Peds) do
        SpawnPed(pedData) 
    end
    for _, propData in pairs(Config.Props) do
        SpawnProp(propData)
    end
end)

RegisterCommand("addprop", function(source, args)
    local model = args[1] or "prop_bench_01a"
    local coords = GetEntityCoords(PlayerPedId()) + vector3(0, 1, 0)
    local heading = GetEntityHeading(PlayerPedId())

    SpawnProp({ model = model, coords = coords, heading = heading })
end, false)

function SpawnVehicle(vehicleData)
    RequestModel(vehicleData.model)
    while not HasModelLoaded(vehicleData.model) do
        Wait(100)
    end

    local vehicle = CreateVehicle(vehicleData.model, vehicleData.coords.x, vehicleData.coords.y, vehicleData.coords.z, vehicleData.heading, true, false)
    SetVehicleOnGroundProperly(vehicle)
    SetEntityAsMissionEntity(vehicle, true, true)

end

CreateThread(function()
    for _, vehicleData in pairs(Config.Vehicles) do
        SpawnVehicle(vehicleData)
    end
end)

function SpawnAnimal(animalData)
    RequestModel(animalData.model)
    while not HasModelLoaded(animalData.model) do
        Wait(100)
    end

    local animal = CreatePed(28, animalData.model, animalData.coords.x, animalData.coords.y, animalData.coords.z - 1.0, animalData.heading, false, true)
    SetEntityAsMissionEntity(animal, true, true)

end

CreateThread(function()
    for _, animalData in pairs(Config.Animals) do
        SpawnAnimal(animalData)
    end
end)


function SpawnPatrolPed(pedData)
    RequestModel(pedData.model)
    while not HasModelLoaded(pedData.model) do
        Wait(100)
    end

    local ped = CreatePed(4, pedData.model, pedData.coords.x, pedData.coords.y, pedData.coords.z - 1.0, 0.0, true, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, false)
    if pedData.weapon then
        GiveWeaponToPed(ped, GetHashKey(pedData.weapon), 999, false, true)
        SetCurrentPedWeapon(ped, GetHashKey(pedData.weapon), true)
        TaskCombatHatedTargetsAroundPed(ped, 100.0, 0)
    end

    TaskPatrol(ped, pedData.waypoints)

    table.insert(spawnedPeds, ped)
end

function TaskPatrol(ped, waypoints)
    local sequence = OpenSequenceTask()
    for _, point in pairs(waypoints) do
        TaskGoStraightToCoord(0, point.x, point.y, point.z, 1.0, -1, 0.0, 0.0)
        TaskPause(0, 2000)
    end
    TaskGoStraightToCoord(0, waypoints[1].x, waypoints[1].y, waypoints[1].z, 1.0, -1, 0.0, 0.0)
    CloseSequenceTask(sequence)
    TaskPerformSequence(ped, sequence)
end

CreateThread(function()
    for _, pedData in pairs(Config.PatrolPeds) do
        SpawnPatrolPed(pedData)
    end
end)

CreateThread(function()
    while true do
        Wait(2000)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        for _, ped in pairs(spawnedPeds) do
            local pedCoords = GetEntityCoords(ped)
            if #(playerCoords - pedCoords) < 3.0 and math.random(1, 100) <= Config.TalkChance then
                local randomQuote = Config.PedDialogue[math.random(#Config.PedDialogue)]

                print("Selected NotifyType: " .. Config.NotifyType)

                if Config.NotifyType == 'qb' then
                    TriggerEvent('QBCore:Notify', randomQuote, 'success')
                    print("QBCore Notify sent: " .. randomQuote) 

                elseif Config.NotifyType == 'ox' then
                    exports.ox_lib:notify({
                        title = "NPC",
                        description = randomQuote,
                        type = "success"
                    })
                    print("ox_lib Notify sent: " .. randomQuote)  
                else
                    print("No valid NotifyType selected.")
                end
            end
        end
    end
end)

function TriggerRandomEvent()
    local eventChance = math.random(1, 100)
    
    if Config.Events.BrokenCar and eventChance <= 25 then
        SpawnBrokenCarEvent()
    elseif Config.Events.AggressivePed and eventChance <= 50 then
        SpawnAggressivePed()
    elseif Config.Events.RandomExplosion and eventChance <= 75 then
        TriggerExplosion()
    elseif Config.Events.DrunkPed and eventChance <= 100 then
        SpawnDrunkPed()
    end
end

function SpawnBrokenCarEvent()
    local carModels = { Config.Carmodels }
    local pedModels = { Config.CarPeds }
    
    local spawnCoords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), math.random(10, 20), math.random(10, 20), 0)
    local carModel = carModels[math.random(#carModels)]
    local pedModel = pedModels[math.random(#pedModels)]
    
    RequestModel(carModel)
    RequestModel(pedModel)
    while not HasModelLoaded(carModel) or not HasModelLoaded(pedModel) do
        Wait(100)
    end
    
    local vehicle = CreateVehicle(carModel, spawnCoords.x, spawnCoords.y, spawnCoords.z, 0.0, true, true)
    local ped = CreatePed(4, pedModel, spawnCoords.x + 2.0, spawnCoords.y, spawnCoords.z, 0.0, true, true)
    
    SetVehicleEngineHealth(vehicle, 0.0)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CAR_PARK_ATTENDANT", 0, true)
end

function SpawnAggressivePed()
    local pedModel = Config.AggressivePed
    local spawnCoords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), math.random(5, 10), math.random(5, 10), 0)
    
    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do
        Wait(100)
    end
    
    local ped = CreatePed(4, pedModel, spawnCoords.x, spawnCoords.y, spawnCoords.z, 0.0, true, true)
    TaskCombatPed(ped, PlayerPedId(), 0, 16)
end

function TriggerExplosion()
    local vehicles = GetGamePool("CVehicle")
    if #vehicles > 0 then
        local randomVehicle = vehicles[math.random(#vehicles)]
        AddExplosion(GetEntityCoords(randomVehicle), 2, 1.0, true, false, 1.0)
    end
end

function SpawnDrunkPed()
    if not Config.Events.DrunkPeds then
        return
    end

    local currentHour = GetClockHours()

    if currentHour >= Config.StartHour or currentHour < Config.EndHour then
        local pedModel = Config.Drunkped
        local spawnCoords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), math.random(5, 15), math.random(5, 15), 0)

        RequestModel(pedModel)
        while not HasModelLoaded(pedModel) do
            Wait(100)
        end

        local ped = CreatePed(4, pedModel, spawnCoords.x, spawnCoords.y, spawnCoords.z, 0.0, true, true)
        TaskStartScenarioInPlace(ped, Config.Drunkscenario, 0, true)
        TaskWanderStandard(ped, 10.0, 10)
    end
end

CreateThread(function()
    while true do
        Wait(math.random(30000, 60000))
        TriggerRandomEvent()
    end
end)


CreateThread(function()
    for _, seller in pairs(Config.Sellers) do
        for _, spawnPos in pairs(seller.positions) do
            local pedModel = seller.pedModel

            RequestModel(pedModel)
            while not HasModelLoaded(pedModel) do Wait(10) end

            local ped = CreatePed(4, pedModel, spawnPos.x, spawnPos.y, spawnPos.z - 1.0, spawnPos.w, false, true)
            SetEntityInvincible(ped, true)
            FreezeEntityPosition(ped, true)

            local scenario = seller.scenarios[math.random(#seller.scenarios)]
            TaskStartScenarioInPlace(ped, scenario, 0, true)

            if seller.blip then
                local blip = AddBlipForEntity(ped)
                SetBlipSprite(blip, 280)
                SetBlipDisplay(blip, 4)
                SetBlipScale(blip, 1.0)
                SetBlipColour(blip, 2)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(seller.name)
                EndTextCommandSetBlipName(blip)
            end

            exports['qb-target']:AddTargetEntity(ped, {
                options = {
                    {
                        icon = "fas fa-handshake",
                        label = "Sälj varor",
                        distance = 2.0,
                        action = function()
                            if blockedSellers[seller.name] then
                                QBCore.Functions.Notify("Den här säljaren vill inte göra affärer med dig just nu!", "error")
                                return
                            end
                            OpenSellMenu(seller)
                        end,
                    }
                },
                distance = 2.5,
            })
        end
    end
end)

function OpenSellMenu(seller)
    local PlayerData = QBCore.Functions.GetPlayerData()
    local inventory = PlayerData.items or {}
    local sellableItems = {}

    for _, item in pairs(seller.itemsForSale) do
        for _, invItem in pairs(inventory) do
            if invItem.name == item.name and invItem.amount > 0 then
                table.insert(sellableItems, {
                    name = item.name,
                    minPrice = item.minPrice,
                    maxPrice = item.maxPrice,
                    amount = invItem.amount
                })
            end
        end
    end

    if #sellableItems == 0 then
        QBCore.Functions.Notify("Du har inga varor att sälja!", "error")
        return
    end

    local sellMenu = {
        {
            header = "Sälj dina varor",
            isMenuHeader = true
        }
    }

    for _, item in pairs(sellableItems) do
        local randomPrice = math.random(item.minPrice, item.maxPrice)

        sellMenu[#sellMenu + 1] = {
            header = item.name .. " - $" .. randomPrice,
            txt = "Sälj en " .. item.name,
            params = {
                event = "skapsell:negotiatePrice",
                args = {
                    sellerName = seller.name,
                    name = item.name,
                    basePrice = randomPrice,
                    amount = item.amount
                }
            }
        }
    end

    exports['qb-menu']:openMenu(sellMenu)
end

RegisterNetEvent("skapsell:negotiatePrice", function(data)
    local price = data.basePrice
    local sellerName = data.sellerName

    local options = {
        {
            header = "Är du nöjd med $" .. price .. " för " .. data.name .. "?",
            isMenuHeader = true
        },
        {
            header = "Ja, sälj!",
            params = {
                event = "skapsell:finalizeSale",
                args = data
            }
        },
        {
            header = "Förhandla (+10%)",
            params = {
                event = "skapsell:negotiate",
                args = {
                    sellerName = sellerName,
                    name = data.name,
                    price = price,
                    direction = "up",
                    amount = data.amount
                }
            }
        },
        {
            header = "Förhandla (-10%)",
            params = {
                event = "skapsell:negotiate",
                args = {
                    sellerName = sellerName,
                    name = data.name,
                    price = price,
                    direction = "down",
                    amount = data.amount
                }
            }
        },
        {
            header = "Avbryt",
        }
    }

    exports['qb-menu']:openMenu(options)
end)

RegisterNetEvent("skapsell:negotiate", function(data)
    print("Försök att förhandla med säljare:", data.sellerName)

    local sellerConfig = nil
    for _, seller in pairs(Config.Sellers) do
        if seller.name == data.sellerName then
            sellerConfig = seller
            break
        end
    end

    if not sellerConfig then
        print("Error: Säljaren finns inte i Config!")
        return
    end

    local newPrice = data.price

    if data.direction == "up" then
        newPrice = math.floor(data.price * 1.1)
    else
        newPrice = math.floor(data.price * 0.9)
    end

    if math.random(1, 100) <= sellerConfig.negotiationChance then
        QBCore.Functions.Notify("Säljaren vägrar att förhandla vidare!", "error")
        blockedSellers[data.sellerName] = true
        return
    end

    TriggerEvent("skapsell:negotiatePrice", {
        sellerName = data.sellerName,
        name = data.name,
        basePrice = newPrice,
        amount = data.amount
    })
end)

RegisterNetEvent("skapsell:finalizeSale", function(data)
    TriggerServerEvent("skapsell:sellItem", data)
end)

CreateThread(function()
    for _, shop in pairs(Config.Shops) do
        local modelHash = GetHashKey(shop.model)
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do Wait(10) end

        local entity
        if shop.type == "ped" then
            entity = CreatePed(4, modelHash, shop.coords.x, shop.coords.y, shop.coords.z - 1.0, shop.coords.w, false, true)
            SetEntityInvincible(entity, true)
            SetBlockingOfNonTemporaryEvents(entity, true)
            FreezeEntityPosition(entity, true)
            TaskStartScenarioInPlace(entity, shop.emote, 0, true)
        else
            entity = CreateObject(modelHash, shop.coords.x, shop.coords.y, shop.coords.z - 1.0, false, false, true)
            SetEntityHeading(entity, shop.coords.w)
            FreezeEntityPosition(entity, true)
        end

        exports['qb-target']:AddTargetEntity(entity, {
            options = {
                {
                    icon = "fas fa-shopping-basket",
                    label = "Handla",
                    action = function()
                        OpenShopMenu(shop)
                    end
                }
            },
            distance = 2.0
        })
    end
end)

function OpenShopMenu(shop)
    local PlayerData = QBCore.Functions.GetPlayerData()

    if shop.job and (PlayerData.job.name ~= shop.job or PlayerData.job.grade.level < shop.grade) then
        QBCore.Functions.Notify("Du har inte tillgång till denna butik.", "error")
        return
    end

    if shop.gang and PlayerData.gang.name ~= shop.gang then
        QBCore.Functions.Notify("Endast medlemmar i " .. shop.gang .. " kan handla här.", "error")
        return
    end

    local menu = {
        {
            header = shop.name,
            isMenuHeader = true
        }
    }

    for _, item in pairs(shop.items) do
        menu[#menu + 1] = {
            header = item.label .. " - $" .. item.price,
            txt = "Köp detta föremål",
            params = {
                event = "skapshop:buyItem",
                args = {
                    shopName = shop.name,
                    item = item.name,
                    price = item.price
                }
            }
        }
    end

    exports['qb-menu']:openMenu(menu)
end

RegisterNetEvent("skapshop:buyItem", function(data)
    TriggerServerEvent("skapshop:purchaseItem", data.shopName, data.item, data.price)
end)


local spawnedEntities = {}
local activeVehicles = {}

CreateThread(function()
    for _, spawnPoint in pairs(Config.VehicleSpawns) do
        local modelHash = GetHashKey(spawnPoint.model)
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do Wait(10) end

        local entity
        if spawnPoint.type == "ped" then
            entity = CreatePed(4, modelHash, spawnPoint.coords.x, spawnPoint.coords.y, spawnPoint.coords.z - 1.0, spawnPoint.coords.w, false, true)
            SetEntityInvincible(entity, true)
            SetBlockingOfNonTemporaryEvents(entity, true)
            FreezeEntityPosition(entity, true)
            TaskStartScenarioInPlace(entity, spawnPoint.scenario, 0, true)

            exports['qb-target']:AddTargetEntity(entity, {
                options = {
                    {
                        label = 'Öppna Fordonsmeny',
                        icon = 'fas fa-car',
                        action = function(entity, distance, data)
                            OpenVehicleMenu(spawnPoint)
                        end,
                    },
                    {
                        label = 'Lämna tillbaka fordon',
                        icon = 'fas fa-undo',
                        action = function(entity, distance, data)
                            OpenActiveVehiclesMenu(spawnPoint)
                        end,
                    },
                },
                distance = 2.0
            })
        else
            entity = CreateObject(modelHash, spawnPoint.coords.x, spawnPoint.coords.y, spawnPoint.coords.z - 1.0, false, false, true)
            SetEntityHeading(entity, spawnPoint.coords.w)
            FreezeEntityPosition(entity, true)
        end


        table.insert(spawnedEntities, entity)

        if spawnPoint.blip then
            local blip = AddBlipForEntity(entity)
            SetBlipSprite(blip, 225)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.8)
            SetBlipColour(blip, 3)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(spawnPoint.name)
            EndTextCommandSetBlipName(blip)
        end
    end
end)


function OpenActiveVehiclesMenu(spawnPoint)
    local activeMenu = {
        { header = "Framtagna fordon", isMenuHeader = true }
    }

    for _, veh in pairs(activeVehicles) do
        local vehCoords = GetEntityCoords(veh)
        local pedCoords = spawnPoint.coords
        local distance = #(vehCoords - vec3(pedCoords.x, pedCoords.y, pedCoords.z))
        
        activeMenu[#activeMenu + 1] = {
            header = GetVehicleNumberPlateText(veh),
            params = {
                event = "skapsell:returnVehicle",
                args = { vehicle = veh, spawnPoint = spawnPoint, withinRange = distance <= 20 }
            }
        }
    end

    exports['qb-menu']:openMenu(activeMenu)
end

RegisterNetEvent("skapsell:returnVehicle", function(data)
    local veh = data.vehicle
    if data.withinRange then
        QBCore.Functions.DeleteVehicle(veh)
        for i, v in ipairs(activeVehicles) do
            if v == veh then
                table.remove(activeVehicles, i)
                break
            end
        end
        QBCore.Functions.Notify("Fordonet har parkerats tillbaka.", "success")
    else
        QBCore.Functions.Notify("Fordonet är inte inom 20 meter.", "error")
    end
    Wait(500) 
    OpenActiveVehiclesMenu(data.spawnPoint)
end)

function OpenVehicleMenu(spawnPoint)
    local PlayerData = QBCore.Functions.GetPlayerData()

    if spawnPoint.job and (PlayerData.job.name ~= spawnPoint.job or PlayerData.job.grade.level < (spawnPoint.jobGrade or 0)) then
        QBCore.Functions.Notify("Du har inte behörighet att använda dessa fordon.", "error")
        return
    end

    local vehicleMenu = {
        {
            header = "Välj fordon",
            isMenuHeader = true
        }
    }

    for _, vehicle in pairs(spawnPoint.vehicles) do
        vehicleMenu[#vehicleMenu + 1] = {
            header = vehicle.label,
            params = {
                event = "skapsell:spawnVehicle",
                args = { vehicle = vehicle, spawnPoint = spawnPoint }
            }
        }
    end

    exports['qb-menu']:openMenu(vehicleMenu)
end

local ownedVehicles = {} 

function GiveVehicleKeys(vehicle)
    local playerId = PlayerPedId()
    local vehiclePlate = GetVehicleNumberPlateText(vehicle)

    if ownedVehicles[vehiclePlate] ~= playerId then
        if Config.VehicleKey == "qb" then
            TriggerEvent("vehiclekeys:client:SetOwner", vehiclePlate)
        elseif Config.VehicleKey == "qs" then
            local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
            local plate = vehiclePlate
            exports['qs-vehiclekeys']:GiveKeys(plate, model, true)
        end

        ownedVehicles[vehiclePlate] = playerId
        QBCore.Functions.Notify("Du har fått nycklarna till fordonet!", "success")
    else
        QBCore.Functions.Notify("Du har redan nycklar till detta fordon.", "error")
    end
end

function RemoveVehicleKeys(vehicle)
    local vehiclePlate = GetVehicleNumberPlateText(vehicle)

    if not vehiclePlate or vehiclePlate == "" then
        print("Fordonet har inget giltigt registreringsnummer.")
        QBCore.Functions.Notify("Fordonet har inget giltigt registreringsnummer.", "error")
        return
    end
    print("ownedVehicles innehåll: ")
    for plate, owner in pairs(ownedVehicles) do
        print("Plates: " .. plate .. " | Owner: " .. owner)
    end

    if ownedVehicles[vehiclePlate] then
        print("Försöker ta bort nycklar för fordon med regnr: " .. vehiclePlate)
        
        if ownedVehicles[vehiclePlate] == PlayerPedId() then
            ownedVehicles[vehiclePlate] = nil
            print("Nyckel borttagen för fordon: " .. vehiclePlate)
            if Config.VehicleKey == "qb" then
                TriggerEvent("vehiclekeys:client:RemoveOwner", vehiclePlate)
            elseif Config.VehicleKey == "qs" then
                local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
                local plate = vehiclePlate
                exports['qs-vehiclekeys']:RemoveKeys(plate, model)
            end

            QBCore.Functions.Notify("Nycklarna har tagits bort från fordonet.", "success")
        else
            QBCore.Functions.Notify("Du äger inte nycklarna till detta fordon.", "error")
        end
    else
        print("Fordonet " .. vehiclePlate .. " finns inte i nyckelregistret.")
        QBCore.Functions.Notify("Fordonet finns inte i nyckelregistret.", "error")
    end
end


RegisterNetEvent("skapsell:spawnVehicle", function(data)
    local vehicle = data.vehicle
    local spawnPoint = data.spawnPoint

    local model = vehicle.model
    local vehicleHash = GetHashKey(model)

    RequestModel(vehicleHash)
    while not HasModelLoaded(vehicleHash) do
        Wait(500)
    end

    local veh = CreateVehicle(vehicleHash, spawnPoint.spawnCoords.x, spawnPoint.spawnCoords.y, spawnPoint.spawnCoords.z, spawnPoint.spawnCoords.w, true, false)
    SetEntityAsMissionEntity(veh, true, true)
    SetVehicleNumberPlateText(veh, "Hyr-" .. math.random(1000, 9999))
    table.insert(activeVehicles, veh)
    TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
    SetVehicleEngineOn(veh, true, true)

    GiveVehicleKeys(veh)

    QBCore.Functions.Notify("Du har fått ett fordon!", "success")
end)

RegisterNetEvent("skapsell:returnVehicle", function(data)
    local veh = data.vehicle
    if data.withinRange then
        QBCore.Functions.DeleteVehicle(veh)
        for i, v in ipairs(activeVehicles) do
            if v == veh then
                table.remove(activeVehicles, i)
                break
            end
        end
        RemoveVehicleKeys(veh)
        QBCore.Functions.Notify("Fordonet har parkerats tillbaka.", "success")
    else
        QBCore.Functions.Notify("Fordonet är inte inom 20 meter.", "error")
    end
    Wait(500) 
    OpenActiveVehiclesMenu(data.spawnPoint)
end)


CreateThread(function()
    while true do
        Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        local isInVehicle = vehicle ~= 0
        
        for _, teleport in pairs(Config.Teleports) do
            local distance = #(playerCoords - vector3(teleport.from.x, teleport.from.y, teleport.from.z))
            
            if distance < 2.0 then
                DrawText3D(teleport.from.x, teleport.from.y, teleport.from.z, "Tryck [E] för att teleportera")
                if IsControlJustReleased(0, 38) then 
                    if isInVehicle then
                        SetEntityCoords(vehicle, teleport.to.x, teleport.to.y, teleport.to.z)
                        SetEntityHeading(vehicle, teleport.to.w)
                    else
                        SetEntityCoords(playerPed, teleport.to.x, teleport.to.y, teleport.to.z)
                        SetEntityHeading(playerPed, teleport.to.w)
                    end
                end
            end
        end
    end
end)

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end


RegisterCommand("boost", function(source, args)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)

    if vehicle ~= 0 and args[1] then
        local boostLevel = tonumber(args[1])
        if boostLevel and boostLevel >= 1 and boostLevel <= 10 then
            TriggerServerEvent("SkapBoost:CheckAdmin", boostLevel)
        else
            QBCore.Functions.Notify("Ange en boost-nivå mellan 1-10", "error")
        end
    else
        QBCore.Functions.Notify("Du måste sitta i ett fordon!", "error")
    end
end, false)

RegisterNetEvent("SkapBoost:ApplyBoost", function(boostLevel)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)

    if vehicle ~= 0 then
        local plate = GetVehicleNumberPlateText(vehicle)

        if not originalHandling[plate] then
            originalHandling[plate] = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveForce")
        end

        local newBoost = originalHandling[plate] + (boostLevel * 0.05)
        SetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveForce", newBoost)
        SetVehicleEnginePowerMultiplier(vehicle, boostLevel * 10) 
        SetVehicleEngineTorqueMultiplier(vehicle, 1.0 + (boostLevel * 0.2)) 

        QBCore.Functions.Notify("Fordonet har boostats till nivå " .. boostLevel, "success")
    end
end)

RegisterCommand("setnormal", function(source, args)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)

    if vehicle ~= 0 then
        local plate = GetVehicleNumberPlateText(vehicle)

        if originalHandling[plate] then
            SetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveForce", originalHandling[plate])
            SetVehicleEnginePowerMultiplier(vehicle, 1.0)
            SetVehicleEngineTorqueMultiplier(vehicle, 1.0)

            QBCore.Functions.Notify("Fordonet har återställts till normal prestanda!", "success")
            originalHandling[plate] = nil
        else
            QBCore.Functions.Notify("Ingen boost har applicerats på detta fordon.", "error")
        end
    else
        QBCore.Functions.Notify("Du måste sitta i ett fordon!", "error")
    end
end, false)



local maxSpeedDefault = Config.MaxSpeed / 3.6 

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped, false) then
            local vehicle = GetVehiclePedIsIn(ped, false)
            if GetPedInVehicleSeat(vehicle, -1) == ped then 
                local model = GetEntityModel(vehicle)
                local modelName = GetDisplayNameFromVehicleModel(model):lower()

                local maxSpeed = Config.SpecialVehicles[modelName] and (Config.SpecialVehicles[modelName] / 3.6) or maxSpeedDefault
                local speed = GetEntitySpeed(vehicle)

                if speed > maxSpeed then
                    local excessSpeed = speed - maxSpeed
                    local brakeForce = math.min(excessSpeed / maxSpeed, 0.1) 

                    local forwardVector = GetEntityForwardVector(vehicle)
                    ApplyForceToEntity(vehicle, 0, -brakeForce * forwardVector.x, -brakeForce * forwardVector.y, 0, 0, 0, 0, false, true, true, false, true, true)
                end
                SetEntityMaxSpeed(vehicle, maxSpeed * 1.05) 
            end
        end
        Wait(100) 
    end
end)

