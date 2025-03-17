if Config.Framework == 'qb' or Config.Framework == 'qbx' then QBCore = exports['qb-core']:GetCoreObject() end 
if Config.Framework == 'esx' then ESX = exports["es_extended"]:getSharedObject() end 
local cfg = Config

function GetPlayerCid(src)
    local cid = nil 

    if cfg.Framework == 'qb' then 
        local player = QBCore.Functions.GetPlayer(src)
        if player then  -- Check if player exists
            cid = player.PlayerData.citizenid
        end
    elseif cfg.Framwork == 'qbx' then 
        local player = qbx.GetPlayer(src) 
        if player then 
            cid = player.PlayerData.citizenid 
        end 
    end 

    --print("Player CID: " .. tostring(cid)) -- Convert to string to avoid nil errors
    return cid
end

function RemoveItem(source, itemName, itemAmount)
    if cfg.Inventory == 'codem' then 
        exports['codem-inventory']:RemoveItem(source, itemName, itemAmount)
    elseif cfg.Inventory == 'qb' then 
        exports['qb-inventory']:RemoveItem(source, itemName, itemAmount, false, 'gx_fooddelivery:RemoveBags') 
    elseif cfg.Inventory == 'ox' then 
        exports.ox_inventory:RemoveItem(source, itemName, itemAmount)
    else
        exports['qs-inventory']:RemoveItem(source, itemName, itemAmount)
    end
end

function AddItem(source, itemName, itemAmount) 
    if cfg.Inventory == 'codem' then 
        exports['codem-inventory']:AddItem(source, itemName, itemAmount)
    elseif cfg.Inventory == 'qb' then 
        exports['qb-inventory']:AddItem(source, itemName, itemAmount) 
    elseif cfg.Inventory == 'ox' then 
        exports.ox_inventory:AddItem(source, itemName, itemAmount) 
    else 
        exports['qs-inventory']:AddItem(source, itemName, itemAmount)
    end
end

function GetItemCount(source, itemName) 
    local itemCount = 0

    if cfg.Inventory == 'codem' then 
        itemCount = exports['codem-inventory']:GetItemsTotalAmount(source, itemName)
    elseif cfg.Inventory == 'qb' then 
        itemCount = exports['qb-inventory']:GetItemCount(source, itemName)
    elseif cfg.Inventory == 'ox' then 
        itemCount = exports.ox_inventory:GetItemCount(source, itemName)
    else 
        itemCount = exports['qs-inventory']:GetItemTotalAmount(source, itemName)
    end

    return itemCount 
end