# Bears 4WD System
![bears-4wd](https://github.com/YourGitHubUsername/your-repo-name/path/to/your/image.png)

The Bears 4WD System is a script for Grand Theft Auto V (GTA V) that enables players to switch between 4WD mode and 2WD (rear-wheel drive) mode in compatible vehicles. This system enhances the off-road and all-terrain capabilities of SUVs, vans, and off-road vehicles by adjusting vehicle handling parameters.

## Usage
To use the Bears 4WD System in GTA V, follow these instructions:

In the game, open the chat or console.

Enter the following command to toggle 4WD mode on/off: `/2wd`

## Configuration
The script provides configuration parameters in the `config.lua` file. Adjust these parameters to fine-tune the behavior of the 4WD system.

### config.lua
```lua
-- config.lua

Config = {}

Config.default2WDEffects = {
    fDriveBiasFront = 0.500000,
    fInitialDriveForce = 0.0, -- Replace with the default value for fInitialDriveForce
    fInitialDriveMaxFlatVel = 0.0, -- Replace with the default value for fInitialDriveMaxFlatVel
    fEnginePowerMultiplier = 0.0 -- Replace with the default value for fEnginePowerMultiplier
}

Config.default4x4Effects = {
    fDriveBiasFront = 0.400000,
    fInitialDriveForce = 0.0, -- Replace with the default value for fInitialDriveForce
    fInitialDriveMaxFlatVel = 0.0, -- Replace with the default value for fInitialDriveMaxFlatVel
}

Config.updateInterval = 1000

Config.command2WD = "2wd"
Config.chatMessagePrefix = "^2[Info]^7"

Config.messages = {
    errorVehicleType = "^1[Error]^7 This vehicle is not an SUV, van, or off-road vehicle",
    info2WDOn = Config.chatMessagePrefix .. " 2WD mode is ^2ON^7",
    info2WDOff = Config.chatMessagePrefix .. " 2WD mode is ^1OFF^7"
}

return Config

fourwheelsc: Determines whether 4x4 mode is initially turned on (true) or off (false) when you start the game.

Vehicle class identifiers: These are used to specify which types of vehicles are compatible with the 4x4 system. By default, it includes SUVs, off-road vehicles, vans, and Class 8 vehicles. You can modify these class identifiers to include or exclude specific vehicle types.

## Features
The script automatically adjusts the handling parameters of compatible vehicles when you enter them.

In 4x4 mode, it increases the front-wheel drive bias, acceleration, and top speed, providing better off-road performance.

In 2WD mode, it shifts the power to the rear wheels, returning the vehicle to its default handling characteristics.

## Notes
If you are not in a compatible vehicle, attempting to toggle 4x4 mode will display an error message.

The script includes an automatic mode that periodically checks if you are in a compatible vehicle and applies the appropriate mode (4x4 or 2WD) based on the current setting.
