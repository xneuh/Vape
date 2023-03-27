ESX = exports.es_extended:getSharedObject()

ESX.RegisterUsableItem('vape', function(source)
	TriggerClientEvent('esx_basicneeds:onVape', source)
end)
