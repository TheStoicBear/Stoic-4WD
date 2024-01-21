local fourwheelsc = false -- Default to 2WD off

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
        if IsPedSittingInAnyVehicle(playerPed) then
            fourwheelsc = not fourwheelsc
            if fourwheelsc then
                ApplyEffects(veh, Config.defaultAWDEffects) -- All four wheels have power (AWD/4X4)
                TriggerEvent("chatMessage", Config.messages.info2WDOn)
            else
                ApplyEffects(veh, Config.default2WDEffects) -- Rear-wheel 2WD when off
                TriggerEvent("chatMessage", Config.messages.info2WDOff)
            end
        end
    else
        TriggerEvent("chatMessage", Config.messages.errorVehicleType)
    end
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
        if IsSUVOrVanOrOffroad(veh) and IsPedSittingInAnyVehicle(playerPed) then
            if fourwheelsc then
                ApplyEffects(veh, Config.defaultAWDEffects)
            else
                ApplyEffects(veh, Config.default2WDEffects)
            end
        end
    end
end)