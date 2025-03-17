if Config.Framework == 'qb' or Config.Framework == 'qbx' then QBCore = exports['qb-core']:GetCoreObject() end 
if Config.Framework == 'esx' then ESX = exports["es_extended"]:getSharedObject() end 
local cfg = Config

-- Displays Notification
--- @param message string
--- @param type string
function ShowNotification(type, message) 
    if cfg.Notify == 'ox' then 
        lib.notify({ description = message, type = type, position = 'top', icon = 'fa-solid fa-burger' })
    elseif cfg.Notify == 'qb' then 
        QBCore.Functions.Notify(message, type)
    elseif cfg.Notify == 'okok' then
        exports['okoknotify']:Alert(cfg.JobName, message, 5000, type, false)
    elseif cfg.Notify == 'sd' then 
        exports['sd-notify']:Notify(cfg.JobName, message, type)
    elseif cfg.Notify == 'wasabi_notify' then
        exports.wasabi_notify:notify(cfg.JobName, message, 5000, type, false, 'fa-solid fa-burger')
    elseif cfg.Notify == 'esx' then 
        ESX.ShowNotification(title .. ": " .. desc, type, duration )
    elseif cfg.Notify == 'custom' then 
        -- Add custom notification export/event here 
    end
end

-- Display a progress bar
--- @param data table
function ProgressBar(data)
    if cfg.Progress == 'ox' then
        if lib.progressBar({
            duration = data.duration,
            label = data.label,
            position = data.position or 'bottom',
            useWhileDead = data.useWhileDead,
            canCancel = data.canCancel,
            disable = data.disable or {},
            anim = data.anim or {
                dict = data.anim.dict or nil,
                clip = data.anim.clip or nil,
                flag = data.anim.flag or nil
            },
            prop = data.prop or {
                model = data.prop.model or nil,
                bone = data.prop.bone or nil,
                pos = data.prop.pos or nil,
                rot = data.prop.rot or nil
            }
        }) then
            return true
        end
        return false
    elseif cfg.Progress == 'qbcore' then
        local p = promise.new()
        QBCore.Functions.Progressbar(data.label, data.label, data.duration, data.useWhileDead, data.canCancel, {
            disableMovement = data.disable and data.disable.move,
            disableCarMovement = data.disable and data.disable.car,
            disableMouse = false,
            disableCombat = data.disable and data.disable.combat
        }, {
            animDict = data.anim and data.anim.dict,
            anim = data.anim and data.anim.clip,
            flags = data.anim and data.anim.flag
        }, {
            model = data.prop and data.prop.model,
            bone = data.prop and data.prop.bone,
            coords = data.prop and data.prop.pos,
            rotation = data.prop and data.prop.rot
        }, {}, function()
            p:resolve(true)
        end, function()
            p:resolve(false)
        end)
        return Citizen.Await(p)
    elseif cfg.Progress == 'esx' then
        ESX.Progressbar(data.label, data.duration, {
          FreezePlayer = data.disable and data.disable.move,
          animation = {
            type = "anim",
            dict = data.anim and data.anim.dict,
            lib = data.anim and data.anim.clip
          },
          onFinish = function()
            return true
          end,
          onCancel = function()
            return false
          end
        })
    end
end