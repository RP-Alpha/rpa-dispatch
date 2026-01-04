local function GetStreet(coords)
    local street1, street2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local street1Name = GetStreetNameFromHashKey(street1)
    local street2Name = GetStreetNameFromHashKey(street2)
    
    if street2 ~= 0 then
        return street1Name .. " & " .. street2Name
    else
        return street1Name
    end
end

-- Get player job using rpa-lib bridge
local function GetPlayerJob()
    local fwName = exports['rpa-lib']:GetFrameworkName()
    
    if fwName == 'qb-core' or fwName == 'qbox' then
        local PlayerData = exports['rpa-lib']:GetFramework().Functions.GetPlayerData()
        if PlayerData and PlayerData.job then
            return PlayerData.job
        end
    elseif fwName == 'ox_core' then
        -- ox_core uses different structure
        local player = exports.ox_core:GetPlayer()
        if player then
            return player.getGroup()
        end
    end
    
    return nil
end

-- Check if player should receive this alert
local function ShouldReceiveAlert(alertJob)
    local playerJob = GetPlayerJob()
    if not playerJob then return false end
    
    -- If no job specified on alert, everyone sees it (testing mode)
    if not alertJob or alertJob == '' then
        return true
    end
    
    -- Check job match
    if playerJob.name == alertJob then
        return true
    end
    
    -- Check job type (for LEO alerts that any police job should see)
    if alertJob == 'police' and playerJob.type == 'leo' then
        return true
    end
    
    -- Check for EMS alerts
    if alertJob == 'ambulance' and (playerJob.name == 'ambulance' or playerJob.name == 'ems') then
        return true
    end
    
    return false
end

RegisterNetEvent('rpa-dispatch:client:SendAlert', function(data)
    -- Check if player should receive this alert based on job
    if not ShouldReceiveAlert(data.job) then
        return
    end

    SendNUIMessage({
        action = 'alert',
        data = data
    })
    
    -- Blip Logic
    if data.coords then
        local blip = AddBlipForCoord(data.coords.x, data.coords.y, data.coords.z)
        SetBlipSprite(blip, 161)
        SetBlipScale(blip, 1.0)
        SetBlipColour(blip, 1) -- Red
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(data.code .. " - " .. data.title)
        EndTextCommandSetBlipName(blip)
        
        SetTimeout(60000, function() -- 60 seconds instead of 10
            if DoesBlipExist(blip) then
                RemoveBlip(blip)
            end
        end)
    end
    
    -- Play alert sound
    PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Default", true)
end)

-- Export to be used by other resources to trigger alerts
-- exports['rpa-dispatch']:SendAlert({code = '10-31', title = 'Shop Robbery', coords = vector3(...), job = 'police'})
-- Actually, client export should trigger server event
local function SendAlert(data)
    -- Enrich data with coords/street if missing
    if not data.coords then
        data.coords = GetEntityCoords(PlayerPedId())
    end
    if not data.location then
        data.location = GetStreet(data.coords)
    end
    TriggerServerEvent('rpa-dispatch:server:SendAlert', data)
end

exports('SendAlert', SendAlert)
