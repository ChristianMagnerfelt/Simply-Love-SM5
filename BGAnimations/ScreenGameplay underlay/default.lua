local Players = GAMESTATE:GetHumanPlayers()
local t = Def.ActorFrame{ Name="GameplayUnderlay" }

-- underlay stuff like BackgroundFilter, ColumnFlash, and MeasureCounter
for pn in ivalues(Players) do
	t[#t+1] = LoadActor("./PerPlayer/Danger.lua", pn)
	t[#t+1] = LoadActor("./PerPlayer/Filter.lua", pn)
	t[#t+1] = LoadActor("./PerPlayer/ColumnFlashOnMiss.lua", pn)
	t[#t+1] = LoadActor("./PerPlayer/MeasureCounter.lua", pn)
end

-- semi-transparent quad at the top of ScreenGameplay
t[#t+1] = Def.Quad{
	Name="TopBar",
	InitCommand=cmd(diffuse,color("0,0,0,0.85"); zoomto, _screen.w, _screen.h/5;),
	OnCommand=cmd(xy, _screen.w/2, _screen.h/12 - 10 )
}


-- Song title and progress bar for how much song remains
t[#t+1] = LoadActor("./Shared/SongInfoBar.lua")

-- More per-player stuff
for player in ivalues(Players) do
	t[#t+1] = LoadActor("./PerPlayer/Score.lua", player)
	t[#t+1] = LoadActor("./PerPlayer/LifeMeter/default.lua", player)
	t[#t+1] = LoadActor("./PerPlayer/DifficultyMeter.lua", player)
end


if GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2) then
	t[#t+1] = LoadActor("./Shared/WhoIsCurrentlyWinning.lua")
end

t[#t+1] = LoadActor("./Shared/BPMDisplay.lua")

return t