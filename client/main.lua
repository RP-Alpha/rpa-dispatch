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

RegisterNetEvent('rpa-dispatch:client:SendAlert', function(data)
    -- Check if player is on duty and matches job
    local PlayerJob = exports['rpa-lib']:GetFramework().Functions.GetPlayerData().job -- QB Specific, abstract later
    
    -- For now assume everyone sees it for testing, or filter by 'police'/'ambulance'
    -- In production: if PlayerJob.name ~= data.job and PlayerJob.type ~= 'leo' then return end

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
        
        SetTimeout(10000, function()
            RemoveBlip(blip)
        end)
    end
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
