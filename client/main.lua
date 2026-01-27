local QBCore = exports['qb-core']:GetCoreObject()
local starterPed = nil

-- Function untuk spawn ped
local function SpawnStarterPed()
    -- Load model
    local model = GetHashKey(Config.PedModel)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(100)
    end

    -- Create ped
    starterPed = CreatePed(4, model, Config.PedCoords.x, Config.PedCoords.y, Config.PedCoords.z - 1.0, Config.PedCoords.w, false, true)
    
    -- Set ped properties
    SetEntityAsMissionEntity(starterPed, true, true)
    FreezeEntityPosition(starterPed, true)
    SetEntityInvincible(starterPed, true)
    SetBlockingOfNonTemporaryEvents(starterPed, true)
    SetPedCanRagdoll(starterPed, false)
    
    -- Set scenario
    TaskStartScenarioInPlace(starterPed, Config.PedScenario, 0, true)
    
    -- Release model
    SetModelAsNoLongerNeeded(model)
    
    -- Setup ox_target
    exports.ox_target:addLocalEntity(starterPed, {
        {
            name = 'nk_starterpack',
            icon = 'fas fa-gift',
            label = 'Claim Starter Pack',
            onSelect = function()
                TriggerServerEvent('nk-starterpack:server:claimPack')
            end,
            canInteract = function(entity, distance, coords, name)
                return true
            end
        }
    })
end

-- Function untuk create blip
local function CreateStarterBlip()
    if not Config.UseBlip then return end
    
    local blip = AddBlipForCoord(Config.Blip.coords.x, Config.Blip.coords.y, Config.Blip.coords.z)
    SetBlipSprite(blip, Config.Blip.sprite)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, Config.Blip.scale)
    SetBlipColour(blip, Config.Blip.color)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.Blip.label)
    EndTextCommandSetBlipName(blip)
end

-- Event untuk spawn kereta
RegisterNetEvent('nk-starterpack:client:spawnVehicle', function(plate)
    local coords = Config.VehicleSpawnCoords
    
    -- Check if spawn location is clear
    if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
        exports['RxNotify']:Notify('Error', Config.Notifications.spawnLocationBlocked, 'error')
        return
    end
    
    -- Request model
    local model = GetHashKey(Config.VehicleModel)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(100)
    end
    
    -- Create vehicle
    local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, coords.w, true, false)
    
    -- Wait for vehicle to exist
    while not DoesEntityExist(vehicle) do
        Wait(50)
    end
    
    SetVehicleNumberPlateText(vehicle, plate)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
    SetVehicleNeedsToBeHotwired(vehicle, false)
    SetVehRadioStation(vehicle, 'OFF')
    SetVehicleEngineOn(vehicle, true, true, false)
    SetVehicleOnGroundProperly(vehicle)
    SetModelAsNoLongerNeeded(model)
    
    -- Give keys using qb-vehiclekeys
    TriggerEvent("vehiclekeys:client:SetOwner", plate)
    
    -- Notify vehicle spawned
    exports['RxNotify']:Notify('Success', Config.Notifications.vehicleSpawned, 'success')
end)

-- Initialize when resource starts
CreateThread(function()
    Wait(1000)
    SpawnStarterPed()
    CreateStarterBlip()
end)

-- Cleanup when resource stops
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    if DoesEntityExist(starterPed) then
        DeleteEntity(starterPed)
    end
end)
