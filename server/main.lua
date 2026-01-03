RegisterNetEvent('rpa-dispatch:server:SendAlert', function(data)
    -- Relay to all clients (Client side filters by job)
    TriggerClientEvent('rpa-dispatch:client:SendAlert', -1, data)
end)

-- Server export
local function SendAlert(data)
    TriggerClientEvent('rpa-dispatch:client:SendAlert', -1, data)
end

exports('SendAlert', SendAlert)
