ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function CountJobs()
	local EMSConnected = 0
	local PoliceConnected = 0
	local TaxiConnected = 0
	local MekConnected = 0
	local BilConnected = 0
	local MaklareConnected = 0
	local PlayerConnected = 0

	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		
		PlayerConnected = PlayerConnected + 1
		if xPlayer.job.name == 'ambulance' then
			EMSConnected = EMSConnected + 1
		elseif xPlayer.job.name == 'police' then
			PoliceConnected = PoliceConnected + 1
		elseif xPlayer.job.name == 'taxi' then
			TaxiConnected = TaxiConnected + 1
		elseif xPlayer.job.name == 'mecano' then
			MekConnected = MekConnected + 1
		elseif xPlayer.job.name == 'cardealer' then
			BilConnected = BilConnected + 1
		elseif xPlayer.job.name == 'realestateagent' then
			MaklareConnected = MaklareConnected + 1
		end
	end

	return EMSConnected, PoliceConnected, TaxiConnected, MekConnected, BilConnected, MaklareConnected, PlayerConnected
end

ESX.RegisterServerCallback('scoreboard:getScoreboard', function(source, cb)
	cb(CountJobs())
end)

