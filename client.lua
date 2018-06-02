local listOn = false
local Faketimer = 0
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	if Faketimer >= 3 then
		Faketimer = 0
	end

	listOn = false
	while true do
		Citizen.Wait(10)

		if IsControlPressed(0, 178)--[[ INPUT_PHONE ]] then
			if not listOn then
				local players = {}
				ptable = GetPlayers()
				for _, i in ipairs(ptable) do
					table.insert(players, 
					'<tr style=\"color: rgb(' .. 255 .. ', ' .. 255 .. ', ' .. 255 .. ')\"><td>' .. GetPlayerServerId(i) .. '</td><td>' .. GetPlayerName(i) .. '</td></tr>')
				end
				if Faketimer >= 2 then
					ESX.TriggerServerCallback('scoreboard:getScoreboard', function(ems, police, taxi, mek, bil, maklare, spelare)

						SendNUIMessage({ text = table.concat(players), 
							ems = ems,
							police = police,
							taxi = taxi,
							mek = mek,
							bil = bil,
							maklare = maklare,
							spelare = spelare
						})
					end)
					Faketimer = 0
				else
					SendNUIMessage({ text = table.concat(players)})
					Faketimer = 0
				end

				listOn = true
				while listOn do
					Citizen.Wait(10)
					if(IsControlPressed(0, 178) == false) then
						listOn = false
						SendNUIMessage({
							meta = 'close'
						})
						break
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function() -- Thread for  timer
	while true do 
		Citizen.Wait(1000)
		Faketimer = Faketimer + 1
	end
end)

function GetPlayers()
	local players = {}

	for i = 0, 32 do
		if NetworkIsPlayerActive(i) then
			table.insert(players, i)
		end
	end

	return players
end
