local function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

local forceGroundMountZones = {
	'Séjour céleste',
	"Mac’Aree"
}

local GROUND_MOUNT = "Raptor razzashi cuirassé";
local ROBOT_MOUNT = "Extracteur de bois mécanique";
local FLYING_MOUNT = "Wyrm des braises incandescentes";

SlashCmdList['HERO_MOUNT'] = function()

	if (IsMounted()) then
		Dismount()
		return
	end

	if (UnitLevel("player") < 20) then
		CastSpellByName("Invocation d’un chauffeur")
		return
	end

	if (UnitLevel("player") < 60) then
		CastSpellByName(GROUND_MOUNT)
		return
	end

	if (IsShiftKeyDown()) then
		CastSpellByName(GROUND_MOUNT)
		return
	end

	if (IsControlKeyDown()) then
		CastSpellByName(ROBOT_MOUNT)
		return
	end

	local name, instanceType = GetInstanceInfo()
	if (instanceType == "scenario") then
		CastSpellByName(GROUND_MOUNT)
	end

	local zone = GetRealZoneText()
	if (has_value(forceGroundMountZones, zone)) then
		CastSpellByName(GROUND_MOUNT)
	end

	local timer, initial, maxvalue, scale, paused, label = GetMirrorTimerInfo(2)
	if (timer == 'BREATH' and paused == 0) then
		-- breath timer is running: player is underwater
		CastSpellByName("Raie de la Grande mer")
		return
	end

	if (IsFlyableArea()) then
		CastSpellByName(FLYING_MOUNT)
		return
	end

	CastSpellByName(GROUND_MOUNT)
end

SLASH_HERO_MOUNT1 = '/heromount'
