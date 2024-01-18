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
    local playerCar = GetVehiclePedIsIn(playerPed, false)
    local veh = GetVehiclePedIsIn(playerPed)

    if IsSUVOrVanOrOffroad(veh) then
        if IsPedSittingInAnyVehicle(playerPed) then
            if (GetPedInVehicleSeat(playerCar, -1) == playerPed) then
                fourwheelsc = not fourwheelsc
                if fourwheelsc then
                    ApplyEffects(veh, Config.default2WDEffects)
                    TriggerEvent("chatMessage", Config.messages.info2WDOn)
                else
                    ApplyEffects(veh, Config.default4x4Effects)
                    TriggerEvent("chatMessage", Config.messages.info2WDOff)
                end
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
        if IsSUVOrVanOrOffroad(veh) then
            if IsPedSittingInAnyVehicle(playerPed) then
                if fourwheelsc then
                    ApplyEffects(veh, Config.default2WDEffects)
                else
                    ApplyEffects(veh, Config.default4x4Effects)
                end
            end
        end
    end
end)
