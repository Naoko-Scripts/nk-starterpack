local QBCore = exports['qb-core']:GetCoreObject()

-- Version Check Function
local function CheckVersion()
    if not Config.VersionCheck then return end
    
    PerformHttpRequest('https://api.github.com/repos/' .. Config.GithubRepo .. '/releases/latest', function(statusCode, response, headers)
        if statusCode == 200 then
            local data = json.decode(response)
            if data and data.tag_name then
                local latestVersion = data.tag_name:gsub("v", "") -- Remove 'v' prefix if exists
                
                if latestVersion ~= Config.CurrentVersion then
                    print("^3========================================^7")
                    print("^3[" .. Config.ResourceName .. "] ^1UPDATE AVAILABLE!^7")
                    print("^3Current Version: ^7" .. Config.CurrentVersion)
                    print("^3Latest Version: ^2" .. latestVersion .. "^7")
                    print("^3Download: ^7" .. data.html_url)
                    print("^3========================================^7")
                else
                    print("^2[" .. Config.ResourceName .. "]^7 You are running the latest version (^2" .. Config.CurrentVersion .. "^7)")
                end
            end
        elseif statusCode == 404 then
            print("^1[" .. Config.ResourceName .. "]^7 Version check failed: Repository not found")
        else
            print("^1[" .. Config.ResourceName .. "]^7 Version check failed: HTTP " .. statusCode)
        end
    end, 'GET')
end

-- Run version check on resource start
CreateThread(function()
    Wait(2000) -- Wait 2 seconds after resource start
    CheckVersion()
end)

-- Function untuk generate plate number
local function GeneratePlate(cb)
    local plate = Config.PlatePrefix .. " " .. math.random(1000, 9999)
    exports.oxmysql:scalar('SELECT plate FROM player_vehicles WHERE plate = ?', {plate}, function(result)
        if result then
            GeneratePlate(cb)
        else
            cb(plate)
        end
    end)
end

-- Function untuk check jika player sudah claim
local function HasClaimedPack(citizenid, cb)
    exports.oxmysql:scalar('SELECT COUNT(*) FROM player_vehicles WHERE citizenid = ? AND plate LIKE ?', {
        citizenid,
        Config.PlatePrefix .. '%'
    }, function(result)
        cb(result and result > 0)
    end)
end

-- Event untuk claim pack
RegisterNetEvent('nk-starterpack:server:claimPack', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then 
        return 
    end
    
    local citizenid = Player.PlayerData.citizenid
    
    -- Check if already claimed
    HasClaimedPack(citizenid, function(hasClaimed)
        if hasClaimed then
            TriggerClientEvent('RxNotify:Notify', src, 'Starter Pack', Config.Notifications.alreadyClaimed, 'error')
            return
        end
        
        -- Generate plate
        GeneratePlate(function(plate)
            -- Add vehicle to garage
            exports.oxmysql:insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
            Player.PlayerData.license,
            citizenid,
            Config.VehicleModel,
            GetHashKey(Config.VehicleModel),
            '{}',
            plate,
            'pillboxgarage', -- Default garage
            0 -- State 0 = in garage
        }, function(id)
            if id then
                -- Give items if enabled
                if Config.GiveItems then
                    for _, itemData in pairs(Config.StarterItems) do
                        Player.Functions.AddItem(itemData.item, itemData.amount)
                    end
                end
                
                -- Give money if enabled
                if Config.GiveMoney then
                    if Config.StarterMoney.cash > 0 then
                        Player.Functions.AddMoney('cash', Config.StarterMoney.cash, "starter-pack")
                    end
                    if Config.StarterMoney.bank > 0 then
                        Player.Functions.AddMoney('bank', Config.StarterMoney.bank, "starter-pack")
                    end
                end
                
                -- Notify player
                TriggerClientEvent('RxNotify:Notify', src, 'Starter Pack', Config.Notifications.claimSuccess, 'success')
                
                -- Spawn vehicle
                TriggerClientEvent('nk-starterpack:client:spawnVehicle', src, plate)
            else
                -- If database insert failed
                TriggerClientEvent('RxNotify:Notify', src, 'Error', "Gagal claim starter pack! Hubungi admin.", 'error')
            end
        end)
        end)
    end)
end)

-- Command untuk reset (admin only)
QBCore.Commands.Add('resetstarterpack', 'Reset starter pack untuk player (Admin Only)', {{name = 'id', help = 'Player ID'}}, true, function(source, args)
    local targetId = tonumber(args[1])
    local TargetPlayer = QBCore.Functions.GetPlayer(targetId)
    
    if not TargetPlayer then
        TriggerClientEvent('RxNotify:Notify', source, 'Error', 'Player not found', 'error')
        return
    end
    
    exports.oxmysql:execute('DELETE FROM player_vehicles WHERE citizenid = ? AND plate LIKE ?', {
        TargetPlayer.PlayerData.citizenid,
        Config.PlatePrefix .. '%'
    }, function(affectedRows)
        if affectedRows > 0 then
            TriggerClientEvent('RxNotify:Notify', source, 'Success', 'Starter pack for player ' .. GetPlayerName(targetId) .. ' has been reset', 'success')
            TriggerClientEvent('RxNotify:Notify', targetId, 'Info', 'Your starter pack has been reset by an admin', 'info')
        else
            TriggerClientEvent('RxNotify:Notify', source, 'Error', 'Player does not have a starter pack', 'error')
        end
    end)
end, 'admin')
