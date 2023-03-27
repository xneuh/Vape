ESX = exports.es_extended:getSharedObject()


local gummyEatTimeLeft = 0

RegisterNetEvent('esx_basicneeds:onVape')
AddEventHandler('esx_basicneeds:onVape', function()
	local playerPed  = PlayerPedId()
	local coords     = GetEntityCoords(playerPed)
	local boneIndex  = GetPedBoneIndex(playerPed, 18905)
	local boneIndex2 = GetPedBoneIndex(playerPed, 57005)
	local ad = "mp_player_inteat@burger"
	local anim = "mp_player_int_eat_burger"
	local text = 'Wystarczył jeden buch'
	local losowanko = math.random(1,3)
	local losowanko1 = math.random(1,100)

	if losowanko1 < 1 then
		ESX.ShowNotification("Płuca ci jebły")
		SetEntityHealth(PlayerPedId(), 0)
	end

	if losowanko == 1 then
		text = 'Wystarczył jeden buch'
	elseif losowanko == 2 then
		text = 'Prawie już nie czuje płuc'
	elseif	losowanko == 3 then
		text = 'Buszek...'
	end
	RequestAnimDict('mp_player_intdrink')
	while not HasAnimDictLoaded('mp_player_intdrink') do
		Citizen.Wait(1)
	end
	
	ESX.Game.SpawnObject('ba_prop_battle_vape_01', {
		x = coords.x,
		y = coords.y,
		z = coords.z + 0.2
	}, function(object)
		TaskPlayAnim(playerPed, ad, anim, 8.00, -8.00, -1, (2 + 16 + 32), 0.00, 0, 0, 0)
		AttachEntityToEntity(object, playerPed, boneIndex,  0.09, -0.065, 0.045, -100.0, 0.0, -25.0, 1, 1, 0, 1, 1, 1)
		Citizen.Wait(3000)
		DeleteObject(object)
		ClearPedSecondaryTask(playerPed)
	end)

	--ESX.ShowNotification("Uzyłeś ~p~E-Peta ✌")
	ExecuteCommand('me '..text..'')

	gummyEatTimeLeft = 300

	SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)
end)

CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if gummyEatTimeLeft > 0 then
			local playerid = PlayerId()
			ResetPlayerStamina(playerid)
			gummyEatTimeLeft = gummyEatTimeLeft - 1
			if gummyEatTimeLeft == 1 or exports["esx_ambulancejob"]:getDeathStatus() then
				SetRunSprintMultiplierForPlayer(playerid, 1.0)
				ESX.ShowNotification('~r~Czujesz, że vape przestaje działać...')
				gummyEatTimeLeft = 0
			end
		end
	end
end)