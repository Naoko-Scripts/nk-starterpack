Config = {}

-- Version Check Settings
Config.VersionCheck = true -- Enable/disable version check
Config.ResourceName = "nk-starterpack" -- Nama resource
Config.CurrentVersion = "1.0.0" -- Current version
Config.GithubRepo = "Naoko-Scripts/nk-starterpack" -- Github repository (owner/repo)

-- Ped Settings
Config.PedModel = "a_m_m_tourist_01" -- Model ped
Config.PedCoords = vector4(-1040.53, -2731.88, 20.17, 240.80) -- Koordinat ped (x, y, z, heading)
Config.PedScenario = "WORLD_HUMAN_CLIPBOARD" -- Scenario ped

-- Vehicle Settings
Config.VehicleModel = "futo" -- Model kereta yang akan diberi
Config.VehicleSpawnCoords = vector4(-1033.46, -2730.69, 19.46, 239.32) -- Koordinat spawn kereta
Config.PlatePrefix = "MC" -- Prefix untuk plate (MC XXXX)

-- Item Settings
Config.GiveItems = true -- Set false jika tidak mahu beri items
Config.StarterItems = {
    { item = "water", amount = 10 },
    { item = "burger", amount = 10 },
    { item = "bandage", amount = 20 },
    { item = "panadol", amount = 20 },
    { item = "phone", amount = 1 },
    { item = "id_card", amount = 1 },
}

-- Money Settings
Config.GiveMoney = true -- Set false jika tidak mahu beri duit
Config.StarterMoney = {
    cash = 100,    -- Duit cash
    bank = 200    -- Duit bank
}

-- Notification Settings
Config.Notifications = {
    alreadyClaimed = "Anda sudah claim starter pack!",
    claimSuccess = "Anda telah menerima starter pack!",
    vehicleSpawned = "Kereta anda telah spawn!",
    spawnLocationBlocked = "Lokasi spawn kereta terhalang!"
}

-- Blip Settings (Optional)
Config.UseBlip = false
Config.Blip = {
    coords = vector4(-1040.53, -2731.88, 20.17, 240.80),
    sprite = 280,
    color = 2,
    scale = 0.7,
    label = "Starter Pack"
}

