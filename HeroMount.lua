
SlashCmdList['HERO_MOUNT'] = function()
	if (UnitLevel("player") < 20) then
		CastSpellByName("Bécane avec chauffeur")
		return
	end
	
	if (IsMounted()) then
		Dismount()
		return
	end
	
	timer, initial, maxvalue, scale, paused, label = GetMirrorTimerInfo(2)
	if (pause == 0) then
		-- breath timer is running: player is underwater
		CastSpellByName("Raie de la Grande mer")
		return
	end
	
	if (IsFlyableArea()) then
		CastSpellByName("Expérience 12-B")
		return
	end
	
	CastSpellByName("Seigneur corbeau")
end

SLASH_HERO_MOUNT = '/heromount'