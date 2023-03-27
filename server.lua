ESX = exports.es_extended:getSharedObject()

ESX.RegisterUsableItem('vape', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('vape', 1)
	TriggerClientEvent('esx_basicneeds:onVape', source)
end)