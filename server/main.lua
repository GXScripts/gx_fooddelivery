if Config.Framework == 'qb' or Config.Framework == 'qbx' then QBCore = exports['qb-core']:GetCoreObject() end 
if Config.Framework == 'esx' then ESX = exports["es_extended"]:getSharedObject() end 
local cfg = Config

lib.callback.register('gx_fooddelivery:server:getRep', function(source)
    -- local identifier = GetPlayerCid(src)
    local src = source

    local repRow = MySQL.single.await('SELECT `rep` FROM `gx_foodrep` WHERE `citizen_id` = ?', { GetPlayerCid(src) })

    if repRow then 
        print(repRow)
        return repRow.rep
    else  
        print("DEBUG: getRep: repRow not found, Creating Rep Entry")
        TriggerEvent('gx_fooddelivery:server:createRepEntry', src)
        return 0
    end
end)

RegisterNetEvent('gx_fooddelivery:server:setRep', function(rep)
    local src = source 
    local identifier = GetPlayerCid(src)

    local repRow = MySQL.single.await('SELECT `rep` FROM `gx_foodrep` WHERE `citizen_id` = ?', { identifier })

    
    if repRow then 
        MySQL.update.await('UPDATE gx_foodrep SET rep = ? WHERE citizen_id = ?', { rep, identifier})
    else  
        print("DEBUG: setRep: repRow not found, Creating Rep Entry")
        TriggerEvent('gx_fooddelivery:server:createRepEntry', src)
        return 0
    end
end)

RegisterNetEvent('gx_fooddelivery:server:createRepEntry', function(src)
    -- local identifier = GetPlayerCid(src)
    local rep = 0
    MySQL.insert.await('INSERT INTO `gx_foodrep` (citizen_id, rep) VALUES (?, ?)', { GetPlayerCid(src), rep })
    print(cid)
end)

bags = nil
RegisterNetEvent('gx_fooddelivery:server:givePackage1', function()
    local x = cfg.Levels[1].minBags
    local y = cfg.Levels[1].maxBags
    local z = math.random(x, y) 

    AddItem(source, 'gx_foodbag', z)
    bags = z
end)

RegisterNetEvent('gx_fooddelivery:server:givePackage2', function()
    local x = cfg.Levels[2].minBags
    local y = cfg.Levels[2].maxBags
    local z = math.random(x, y) 

    AddItem(source, 'gx_foodbag', z)
    bags = z
end)

RegisterNetEvent('gx_fooddelivery:server:givePackage3', function()
    local x = cfg.Levels[3].minBags
    local y = cfg.Levels[3].maxBags
    local z = math.random(x, y)
    AddItem(source, 'gx_foodbag', z)
    bags = z
end)

RegisterNetEvent('gx_fooddelivery:server:givePackage4', function()
    local x = cfg.Levels[4].minBags
    local y = cfg.Levels[4].maxBags
    local z = math.random(x, y)
    AddItem(source, 'gx_foodbag', z)
    bags = z
end)

RegisterNetEvent('gx_fooddelivery:server:givePackage5', function()
    local x = cfg.Levels[5].minBags
    local y = cfg.Levels[5].maxBags
    local z = math.random(x, y)
    AddItem(source, 'gx_foodbag', z)
    bags = z
end)

RegisterNetEvent('gx_fooddelivery:server:dropoffOrder', function()
    local itemAmount = bags --exports['codem-inventory']:GetItemsTotalAmount(source, 'gx_foodbag')
    local x = cfg.Rewards.minReward 
    local y = cfg.Rewards.maxReward 
    local z = math.random(x, y) 
    if cfg.Debug then print(z) end
    local rewardAmount = z * itemAmount 
    if cfg.Debug then print(rewardAmount) end
    RemoveItem(source, 'gx_foodbag', itemAmount)
    AddItem(source, 'cash', rewardAmount)
    Wait(1000)
    bags = nil
    if cfg.Debug then 
        if bags == nil then print("bags check complete!") end
    end
end)

RegisterNetEvent('gx_fooddelivery:server:endJob', function()
    local itemName = 'gx_foodbag'
    local itemAmount = GetItemCount(source, itemName)
    print(itemAmount)
    RemoveItem(source, 'gx_foodbag', itemAmount)
end)
