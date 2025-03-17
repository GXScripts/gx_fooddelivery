if Config.Framework == 'qb' or Config.Framework == 'qbx' then QBCore = exports['qb-core']:GetCoreObject() end 
if Config.Framework == 'esx' then ESX = exports["es_extended"]:getSharedObject() end 
local cfg = Config


-- Display a notification from server
RegisterNetEvent('gx_fooddelivery:client:Notify', function(type, message)
    ShowNotification(type, message)
end)

-- Makes the boss ped spawn
local bossPedModel = cfg.BossPed.model
local bossPed 

local function SpawnBoss() 
    RequestModel(bossPedModel)
    while not HasModelLoaded(bossPedModel) do 
        Wait(10)
    end 
    bossPed = CreatePed(1, bossPedModel, cfg.BossPed.coords.x, cfg.BossPed.coords.y, cfg.BossPed.coords.z - 1, cfg.BossPed.coords.w, false, false)
    FreezeEntityPosition(bossPed, true) 
    SetEntityInvincible(bossPed, true) 
    SetBlockingOfNonTemporaryEvents(bossPed, true)
end

-- Adds a blip for the boss ped
function addBossBlip()
    local blipName = cfg.JobName
    local blipCoords = cfg.BossPed.coords 

    blip = AddBlipForCoord(blipCoords.x, blipCoords.y, blipCoords.z)
    SetBlipScale(blip, 0.8)
    SetBlipSprite(blip, 889)
    SetBlipColour(blip, 24)
    SetBlipAlpha(blip, 255)
    SetBlipDisplay(blip, 3)
    AddTextEntry("UHEREATS", blipName)
    BeginTextCommandSetBlipName("UHEREATS")
    EndTextCommandSetBlipName(blip)
end

Citizen.CreateThread(addBossBlip)

jobStatus = nil

-- Function to update ped interaction dynamically
function UpdateBossTarget()
    if cfg.Debug then print("Debug: Updating Boss Target") end

    -- Remove previous target to avoid duplication
    if cfg.Target == 'ox' then
        exports.ox_target:removeLocalEntity(bossPed)
    elseif cfg.Target == 'qb' then
        exports['qb-target']:RemoveTargetEntity(bossPed)
    end

    -- Add new target options based on jobStatus
    if jobStatus == nil then 
        if cfg.Target == 'ox' then
            exports.ox_target:addLocalEntity(bossPed, {
                name = 'boss_target',
                label = 'Food Delivery Boss',
                icon = 'fa-solid fa-burger',
                onSelect = function ()
                    TriggerEvent('gx_fooddelivery:client:interactWithBoss')
                end
            })
        elseif cfg.Target == 'qb' then
            exports['qb-target']:AddTargetEntity(bossPed, {
                options = {
                    {
                        num = 1,
                        event = 'gx_fooddelivery:client:interactWithBoss',
                        icon = 'fa-solid fa-burger',
                        label = 'Start Job',
                    },
                },
                distance = 2.5,
            })
        end
    else 
        if cfg.Target == 'ox' then
            exports.ox_target:addLocalEntity(bossPed, {
                name = 'boss_target',
                label = 'Food Delivery Boss',
                icon = 'fa-solid fa-burger',
                onSelect = function ()
                    TriggerEvent('gx_fooddelivery:client:endJob')
                end
            })
        elseif cfg.Target == 'qb' then
            exports['qb-target']:AddTargetEntity(bossPed, {
                options = {
                    {
                        num = 1,
                        event = 'gx_fooddelivery:client:endJob',
                        icon = 'fa-solid fa-burger',
                        label = 'End Job',
                    },
                },
                distance = 2.5,
            })
        end
    end
end

-- Thread to spawn boss and set interaction
Citizen.CreateThread(function()
    SpawnBoss()
    UpdateBossTarget() -- Set initial interaction
end)

-- Event to start the job
RegisterNetEvent('gx_fooddelivery:client:interactWithBoss', function ()
    jobStatus = "active"  -- Set job status
    UpdateBossTarget() -- Update the target options dynamically

    ProgressBar(cfg.Anims.Boss)
    ShowNotification('success', locale("notify.job-started"))
    
    TriggerEvent('gx_fooddelivery:client:waitForOrder')
end)

-- Function to get a random pickup location from config
function getRandomPickup()
    local coords = cfg.PickupLocations 
    if #coords > 0 then 
        return coords[math.random(1, #coords)]
    else 
        return nil
    end
end

function getRandomDropOff()
    local coords = cfg.DeliveryPeds.coords 
    if #coords > 0 then 
        return coords[math.random(1, #coords)] 
    else 
        return nil 
    end 
end

function getRandomDropOffPed()
    local model = cfg.DeliveryPeds.models
    if #model > 0 then 
        return model[math.random(1, #model)] 
    else 
        return nil 
    end 
end

RegisterNetEvent('gx_fooddelivery:client:waitForOrder')
AddEventHandler('gx_fooddelivery:client:waitForOrder', function ()
    local x = cfg.OrderWait.minWait
    local y = cfg.OrderWait.maxWait
    local waitTime = math.random(x, y)
    if cfg.Debug then print("A random number between ".. x .. " and " .. y .. " = " .. waitTime) end
    

    Wait(waitTime)
    if jobStatus == nil then 
        return 
    else
        local orderRecievedMessage = locale("notify.order-recieved")
        ShowNotification('success', orderRecievedMessage)

        local randomCoords = getRandomPickup()
        if randomCoords then 
            SetNewWaypoint(randomCoords.x, randomCoords.y)
        end

        local pickupPedModel = cfg.PickupPed
        RequestModel(pickupPedModel)
        while not HasModelLoaded(pickupPedModel) do 
            Wait(10)
        end 
        pickupPed = CreatePed(1, pickupPedModel, randomCoords.x, randomCoords.y, randomCoords.z - 1, randomCoords.w, false, false)
        FreezeEntityPosition(pickupPed, true) 
        SetEntityInvincible(pickupPed, true) 
        SetBlockingOfNonTemporaryEvents(pickupPed, true)

        if cfg.Target == 'ox' then 
            if cfg.Debug then print("Debug: ox_target") end
            exports.ox_target:addLocalEntity(pickupPed, {
                name = 'boss_target',
                label = 'Food Delivery Boss',
                icon = 'fa-solid fa-burger',
                onSelect = function ()
                    TriggerEvent('gx_fooddelivery:client:pickupOrder')
                end
            })
        elseif cfg.Target == 'qb' then 
            if cfg.Debug then print("Debug: qb-target") end
            exports['qb-target']:AddTargetEntity(pickupPed, {
                options = {
                    {
                        num = 1,
                        event = 'gx_fooddelivery:client:pickupOrder',
                        icon = 'fa-solid fa-burger',
                        label = 'Pickup Order',
                    },
                },
                distance = 2.5,
            })
        end
    end
    CancelEvent('gx_fooddelivery:client:waitForOrder')
end)

RegisterNetEvent('gx_fooddelivery:client:pickupOrder', function()
    local pickupMessage = locale("notify.pickup-order")
    ProgressBar(cfg.Anims.Pickup)
    ShowNotification('success', pickupMessage)

    local rep = lib.callback.await('gx_fooddelivery:server:getRep')
    if rep < cfg.Levels[2].minRep then 
        TriggerServerEvent('gx_fooddelivery:server:givePackage1')
    elseif rep < cfg.Levels[3].minRep then 
        TriggerServerEvent('gx_fooddelivery:server:givePackage2')
    elseif rep < cfg.Levels[4].minRep then 
        TriggerServerEvent('gx_fooddelivery:server:givePackage3')
    elseif rep < cfg.Levels[5].minRep then 
        TriggerServerEvent('gx_fooddelivery:server:givePackage4')
    else 
        TriggerServerEvent('gx_fooddelivery:server:givePackage5')
    end
    Wait(0)
    DeleteEntity(pickupPed)

    local randomCoords = getRandomDropOff()
    if randomCoords then 
        SetNewWaypoint(randomCoords.x, randomCoords.y)
    end

    local randomDeliveryPedModel = getRandomDropOffPed()
    RequestModel(randomDeliveryPedModel)
    while not HasModelLoaded(randomDeliveryPedModel) do 
        Wait(10)
    end 
    deliveryPed = CreatePed(1, randomDeliveryPedModel, randomCoords.x, randomCoords.y, randomCoords.z - 1, randomCoords.w, false, false)
    FreezeEntityPosition(deliveryPed, true) 
    SetEntityInvincible(deliveryPed, true) 
    SetBlockingOfNonTemporaryEvents(deliveryPed, true)

    if cfg.Target == 'ox' then 
        if Config.Debug then print("Debug: ox_target") end
        exports.ox_target:addLocalEntity(deliveryPed, {
            name = 'boss_target',
            label = 'Food Delivery Boss',
            icon = 'fa-solid fa-burger',
            onSelect = function ()
                TriggerEvent('gx_fooddelivery:client:dropoffOrder')
            end
        })
    elseif cfg.Target == 'qb' then 
        if Config.Debug then print("Debug: qb-target") end
        exports['qb-target']:AddTargetEntity(deliveryPed, {
            options = {
                {
                    num = 1,
                    event = 'gx_fooddelivery:client:dropoffOrder',
                    icon = 'fa-solid fa-burger',
                    label = 'Deliver Order',
                },
            },
            distance = 2.5,
        })
    end
end)

RegisterNetEvent('gx_fooddelivery:client:dropoffOrder', function ()
    local dropoffMessage = locale("notify.dropoff")
    ProgressBar(cfg.Anims.Dropoff)
    ShowNotification('success', dropoffMessage)
    
    TriggerServerEvent('gx_fooddelivery:server:dropoffOrder')
    local rep = lib.callback.await('gx_fooddelivery:server:getRep') 
    local newRep = rep + 5 

    TriggerServerEvent('gx_fooddelivery:server:setRep', newRep)

    Wait(0)
    DeleteEntity(deliveryPed)

    TriggerEvent('gx_fooddelivery:client:waitForOrder')
end)

RegisterNetEvent('gx_fooddelivery:client:endJob', function()
    if 
        DoesEntityExist(deliveryPed) then
        DeleteEntity(deliveryPed) 
    end
    if 
        DoesEntityExist(pickupPed) then 
        DeleteEntity(pickupPed)
    end 
    TriggerServerEvent('gx_fooddelivery:server:endJob')
    jobStatus = nil
    print(jobStatus)
    UpdateBossTarget()

    local endJobMessage = locale("notify.endjob")
    ProgressBar(cfg.Anims.Endjob)
    ShowNotification('success', endJobMessage)
end)

RegisterCommand('getfoodrep', function()
    local rep = lib.callback.await('gx_fooddelivery:server:getRep')

    local repMessage = locale("notify.rep")
    ShowNotification('success', repMessage .. rep)
end, false)

--Can be used to test rep system etc, would not leave it uncommented as anyone can use it!

-- RegisterCommand('setrep', function(_, args)
--     local rep = tonumber(args[1])

--     if rep then 
--         TriggerServerEvent('gx_fooddelivery:server:setRep', rep)
--     else 
--         print("ERROR: Input Invalid")
--     end
-- end)

AddEventHandler('onResourceStart', function (resourceName)
    if GetCurrentResourceName() ~= resourceName then 
        return  
    end 
    DeleteEntity(bossPed) -- Deletes peds when script restarts
    DeleteEntity(pickupPed)
end)

AddEventHandler('onResourceStop', function (resourceName)
    if GetCurrentResourceName() ~= resourceName then 
        return  
    end 
    DeleteEntity(bossPed) -- Deletes peds when script restarts
    DeleteEntity(pickupPed)
end)

-- Load locale file
local json = json or {} -- Ensure json is defined
local localeData = {}

function LoadLocales()
    local file = LoadResourceFile(GetCurrentResourceName(), "locales/en.json")

    if file then
        print("^2[DEBUG] JSON File Loaded Successfully!^0")
        local success, data = pcall(json.decode, file)
        if success and data then
            localeData = data
            print("^3[DEBUG] Loaded locale data: " .. json.encode(localeData))
        else
            print("^1[ERROR] Failed to decode JSON!^0")
        end
    else
        print("^1[ERROR] Failed to load locales/en.json!^0")
    end
end

LoadLocales()

function locale(key)
    local result = localeData
    for part in key:gmatch("[^%.]+") do
        result = result and result[part] or nil
    end

    if result then
        return result
    else
        print("^1[ERROR] Locale key not found: " .. key .. "^0") -- Debug message
        return key
    end
end
