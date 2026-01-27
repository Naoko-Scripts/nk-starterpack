[![Ko-Fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/naokoscripts)

# Naoko Simple Mechanic

Beginner-friendly FiveM script for roleplay servers.

## ✨ Features
- Basic mechanic interaction
- Simple configuration
- Lightweight

## ☕ Support
If you find this project useful, your support on Ko-Fi helps me improve and continue developing more scripts.


# NK-StarterPack 🎁

**FREE RELEASE** - Starter pack script for QBCore Framework

## 📝 Description
A script that allows new players to claim a free starter pack vehicle. The vehicle will automatically spawn with a custom plate.

## ✨ Features
- ✅ Ped with scenario at configurable location
- ✅ Uses ox_target for interaction
- ✅ Auto adds vehicle to garage database
- ✅ Custom plate format (MC XXXX)
- ✅ Automatic qb-vehiclekeys integration
- ✅ Check system to prevent double claims
- ✅ Admin command to reset starter pack
- ✅ Fully configurable
- ✅ Support ox_lib
- ✅ Map blip (optional)

## 📦 Dependencies
- [qb-core](https://github.com/qbcore-framework/qb-core)
- [ox_lib](https://github.com/overextended/ox_lib)
- [ox_target](https://github.com/overextended/ox_target)
- [qb-vehiclekeys](https://github.com/qbcore-framework/qb-vehiclekeys)
- [oxmysql](https://github.com/overextended/oxmysql)

## 🔧 Installation

1. Download and extract the `nk-starterpack` folder to `resources/[standalone]/`

2. Make sure all dependencies are installed

3. Add this to your `server.cfg`:
```cfg
ensure nk-starterpack
```

4. Restart your server

## ⚙️ Configuration

Edit the `config.lua` file to customize settings:

```lua
-- Ped Settings
Config.PedModel = "a_m_m_business_01" -- Ped model
Config.PedCoords = vector4(-269.46, -955.33, 30.22, 206.93) -- Ped coordinates
Config.PedScenario = "WORLD_HUMAN_CLIPBOARD" -- Ped scenario

-- Vehicle Settings
Config.VehicleModel = "futo" -- Vehicle model
Config.VehicleSpawnCoords = vector4(-276.12, -948.96, 31.22, 248.45) -- Spawn location
Config.PlatePrefix = "MC" -- Plate prefix

-- Blip Settings
Config.UseBlip = true -- Enable/disable blip
```

## 🎮 Usage

### For Players:
1. Go to the location marked on the map
2. Interact with the ped using ox_target (Third Eye)
3. Click "Claim Starter Pack"
4. Your vehicle will spawn and keys will be given automatically
5. The vehicle will also be saved in your garage

### Admin Commands:
```
/resetstarterpack [player_id] - Reset starter pack for a specific player
```

## 📍 Default Location
- **Ped Location:** Legion Square (-269.46, -955.33, 30.22)
- **Vehicle Spawn:** Near Legion Square (-276.12, -948.96, 31.22)

## 🚗 Default Vehicle
- **Model:** Futo
- **Plate Format:** MC XXXX (example: MC 1234)

## 🔒 Security Features
- ✅ Prevent double claim - Each player can only claim once
- ✅ Plate duplicate check - Ensures each plate is unique
- ✅ Server-side validation
- ✅ Admin-only reset command

## 📝 Notes
- Vehicle will be stored in "pillboxgarage" by default
- Plate prefix "MC" can be changed in config
- Player can only claim once per character
- Admin can reset if needed using the command

## 🐛 Support
For bug reports or suggestions, please contact:
- **Author:** Naoko Scripts
- **Version:** 1.0.0

## 📜 License
FREE RELEASE - Can be used for personal or server use.

## Support & Donations
If you like this script, consider supporting me on Ko-fi!  
☕ Support me on Ko-Fi: https://ko-fi.com/naokoscripts


---
**Enjoy! Don't forget to give credit if you share! 🚀**
