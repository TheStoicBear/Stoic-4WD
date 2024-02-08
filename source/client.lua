local fourwheelsc = false -- Default to 2WD off
local blackList = {} -- Initialize blacklist

RegisterCommand(Config.command2WD, function(source, args, rawCommand)
    Toggle2WDMode()
end)

function IsSUVOrVanOrOffroad(vehicle)
    local vehicleClass = GetVehicleClass(vehicle)
    return vehicleClass == Config.SUVClass or vehicleClass == Config.OffRoadClass or vehicleClass == Config.VanClass or vehicleClass == Config.Class8
end

function Toggle2WDMode()
    local playerPed = PlayerPedId()
    local veh = GetVehiclePedIsIn(playerPed, false)

    if IsSUVOrVanOrOffroad(veh) then
        local model = GetEntityModel(veh)
        if IsPedSittingInAnyVehicle(playerPed) then
            if not IsVehicleWhiteListed(veh) then
                fourwheelsc = not fourwheelsc
                if fourwheelsc then
                    ApplyEffects(veh, Config.defaultAWDEffects) -- All four wheels have power (AWD/4X4)
                    TriggerEvent("chatMessage", Config.messages.info2WDOn)
                else
                    ApplyEffects(veh, Config.default2WDEffects) -- Rear-wheel 2WD when off
                    TriggerEvent("chatMessage", Config.messages.info2WDOff)
                end
            else
                TriggerEvent("chatMessage", "This vehicle is exempt from 2WD mode.")
            end
        end
    else
        TriggerEvent("chatMessage", Config.messages.errorVehicleType)
    end
end


function IsVehicleBlackListed(vehicle)
    local model = GetEntityModel(vehicle)
    return blackList[model] or false
end

function ApplyEffects(vehicle, effects)
    for key, value in pairs(effects) do
        SetVehicleHandlingField(vehicle, 'CHandlingData', key, value)
    end
end

-- Automatically apply 2WD mode effects when entering a suitable vehicle
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.updateInterval)
        local playerPed = PlayerPedId()
        local veh = GetVehiclePedIsIn(playerPed, false)
        if IsSUVOrVanOrOffroad(veh) and IsPedSittingInAnyVehicle(playerPed) and not IsVehicleBlackListed(veh) then
            if fourwheelsc then
                ApplyEffects(veh, Config.defaultAWDEffects)
            else
                ApplyEffects(veh, Config.default2WDEffects)
            end
        end
    end
end)

-- Damage vehicle based on speed if 4x4 and < specified speed
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local playerPed = PlayerPedId()
        local veh = GetVehiclePedIsIn(playerPed, false)
        local speed = GetEntitySpeed(veh) * 2.23694 -- Convert m/s to mph

        if IsSUVOrVanOrOffroad(veh) and fourwheelsc and speed > Config.damageSpeed and not IsVehicleWhiteListed(veh) then
            local damage = math.floor((speed - Config.damageSpeed) / 10) -- Calculate damage
            SetVehicleEngineHealth(veh, GetVehicleEngineHealth(veh) - damage)
        end
    end
end)


function IsVehicleWhiteListed(vehicle)
    local model = GetEntityModel(vehicle)
    for _, modelName in ipairs(Config.whiteList) do
        if GetHashKey(modelName) == model then
            return true
        end
    end
    return false
end
