return function(AllSteps)

	local StepsToShow, edits = {}, {}


	local numCharts = 0

	for chart in ivalues(AllSteps) do
		numCharts = numCharts + 1
	end

	if(numCharts < 6) then
			for i, chart in ipairs(AllSteps) do
				StepsToShow[i] = chart
			end

			return StepsToShow
	end


	local player1 = GAMESTATE:GetHumanPlayers()[1]
	local player1Steps = GAMESTATE:GetCurrentSteps(player1)
	local player1IDX = 0

	for i, chart in ipairs(AllSteps) do
		if  chart:GetDescription() == player1Steps:GetDescription()
		and chart:GetChartName()   == player1Steps:GetChartName()
		and chart:GetMeter()       == player1Steps:GetMeter()
		then
				player1IDX = i
		end
	end


	if #GAMESTATE:GetHumanPlayers() <= 1 then
    local player1StartIdx = math.min(math.max(player1IDX - 2, 1), numCharts - 4)
		for i=1,5 do
				StepsToShow[i] = AllSteps[player1StartIdx];
				player1StartIdx = player1StartIdx + 1
		end

		return StepsToShow
	else
		local player2 = GAMESTATE:GetHumanPlayers()[2]
		local player2Steps = GAMESTATE:GetCurrentSteps(player2)
		local player2IDX = 0

		for i, chart in ipairs(AllSteps) do
			if  chart:GetDescription() == player2Steps:GetDescription()
			and chart:GetChartName()   == player2Steps:GetChartName()
			and chart:GetMeter()       == player2Steps:GetMeter()
			then
					player2IDX = i
			end
		end

		local greaterIdx = math.max(player1IDX, player2IDX)
    local lesserIdx = math.min(player1IDX, player2IDX)
		local delta = greaterIdx - lesserIdx

		if delta < 5 then
			local startIdx = math.max(lesserIdx - (4 - delta), 1)
			for i=1,5 do
				StepsToShow[i] = AllSteps[startIdx];
				startIdx = startIdx + 1
			end
		else
			local startIdx = lesserIdx
			for i=1,3 do
				StepsToShow[i] = AllSteps[startIdx];
				startIdx = startIdx + 1
			end

			startIdx = greaterIdx - 1
			for i=4,5 do
				StepsToShow[i] = AllSteps[startIdx];
				startIdx = startIdx + 1
			end
		end

		return StepsToShow
	end
end
