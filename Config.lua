-- config.lua

Config = {}

-- Vehicle class identifiers
Config.SUVClass = 2
Config.OffRoadClass = 9
Config.VanClass = 12
Config.Class8 = 18

-- Default to 2WD off
Config.default2WDEffects = {
    fDriveBiasFront = 0.500000,
    fInitialDriveForce = 0.0, -- Replace with the default value for fInitialDriveForce
    fInitialDriveMaxFlatVel = 0.0, -- Replace with the default value for fInitialDriveMaxFlatVel
    fEnginePowerMultiplier = 0.0 -- Replace with the default value for fEnginePowerMultiplier
}

-- Default to 4x4 off
Config.default4x4Effects = {
    fDriveBiasFront = 0.400000,
    fInitialDriveForce = 0.0, -- Replace with the default value for fInitialDriveForce
    fInitialDriveMaxFlatVel = 0.0, -- Replace with the default value for fInitialDriveMaxFlatVel
}

-- Adjust the interval as needed
Config.updateInterval = 1000

-- Command Configurations
Config.command2WD = "2wd"
Config.chatMessagePrefix = "^2[Info]^7"

-- Chat Messages
Config.messages = {
    errorVehicleType = "^1[Error]^7 This vehicle is not an SUV, van, or off-road vehicle",
    info2WDOn = Config.chatMessagePrefix .. " 2WD mode is ^2ON^7",
    info2WDOff = Config.chatMessagePrefix .. " 2WD mode is ^1OFF^7"
}

return Config
