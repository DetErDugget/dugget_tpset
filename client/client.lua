

-- Config
local autorepair = true -- Auto repair vehicles


-- Don't Touch
local LocIsSet = false
local loc = nil
AddTextEntry("notificationSomething", "[TP Set] You have set the location.")
AddTextEntry("notificationSomething2", "[TP Set] You have no location set!")
RegisterCommand("tpset", function(source, args, rawCommand)

	BeginTextCommandThefeedPost("notificationSomething")
	EndTextCommandThefeedPostTicker(true, true)
	LocIsSet = true
	local ped = PlayerPedId()
	loc = GetEntityCoords(ped)
end, false)


RegisterCommand("tptoset", function(source, args, rawCommand)
   TpGo()
end, false)

RegisterKeyMapping('tpset', 'Set TP location', 'keyboard', 'F11')
RegisterKeyMapping('tptoset', 'TP to location set with F11', 'keyboard', 'K')






function TpGo()
	if LocIsSet then
		if IsPedInAnyVehicle(PlayerPedId()) then
			local vehicle = GetVehiclePedIsUsing(PlayerPedId())
			Citizen.Wait(200)
			SetEntityCoords(vehicle,loc)
			if autorepair then
				SetVehicleEngineHealth(vehicle, 1000)
				SetVehicleDirtLevel(vehicle, 0)
				SetVehicleEngineOn(vehicle, true, true )
				SetVehicleFixed(vehicle)
			end
		else
			Citizen.Wait(200)
			SetEntityCoords(PlayerPedId(),loc)
		end
		
	else
		BeginTextCommandThefeedPost("notificationSomething2")
		EndTextCommandThefeedPostTicker(true, true)
	end
end

