-- Configuration
Config = {}

-- Vehicle class identifiers
Config.SUVClass = 2
Config.OffRoadClass = 9
Config.VanClass = 12
Config.Class8 = 18

-- Default to AWD/4X4 off
Config.defaultAWDEffects = {
    fDriveBiasFront = 0.5, -- Perfect 4WD
}

-- Default to 2WD on (Rear Wheel Drive)
Config.default2WDEffects = {
    fDriveBiasFront = 0.0, -- Rear Wheel Drive
}

-- Adjust the interval as needed
Config.updateInterval = 1000

-- Command Configurations
Config.command2WD = "4wd" -- Change the command to "4wd"
Config.chatMessagePrefix = "^2[Info]^7"

-- Chat Messages
Config.messages = {
    errorVehicleType = "^1[Error]^7 This vehicle is not an SUV, van, or off-road vehicle",
    info2WDOn = Config.chatMessagePrefix .. " 4WD mode is ^2ON^7",
    info2WDOff = Config.chatMessagePrefix .. " 4WD mode is ^1OFF^7"
}

-- Damage configuration
Config.damageSpeed = 35 -- Speed threshold for vehicle damage
Config.whiteList = { -- Initialize whitelist
    "f250r",
    -- Add more vehicle models here as needed
}
