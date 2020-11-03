local function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

local forceGroundMountZones = {
	"Helheim",
	"Le Maelström",
	"L’île Vagabonde",
	"Mac’Aree",
	"Tol Barad",
	"Séjour céleste",
}

local SURAMAR_MOUNT = "Sabre-de-mana d’arcaniste";
local GROUND_MOUNT = "Raptor razzashi cuirassé";
local ROBOT_MOUNT = "Extracteur de bois mécanique";
local WATER_MOUNT = "Raie de la Grande mer";
local FLYING_MOUNT = "Wyrm des braises incandescentes";

APPRENTICE_RIDING_LEVEL = 10
EXPERT_RIDING_LEVEL = 30

SlashCmdList['HERO_MOUNT'] = function()
	if (IsMounted()) then
		Dismount()
		return
	end

	if (UnitLevel("player") < APPRENTICE_RIDING_LEVEL) then
		CastSpellByName("Invocation d’un chauffeur")
		return
	end

	if (UnitLevel("player") < EXPERT_RIDING_LEVEL) then
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

	local _, instanceType = GetInstanceInfo()
	if (instanceType == "scenario" or instanceType == "pvp" or instanceType == "arena") then
		CastSpellByName(GROUND_MOUNT)
	end

	local zone = GetRealZoneText()
	if (zone == "Suramar") then
		CastSpellByName(SURAMAR_MOUNT)
		return
	end

	if (has_value(forceGroundMountZones, zone)) then
		CastSpellByName(GROUND_MOUNT)
	end

	local timer, _, _, _, paused, _ = GetMirrorTimerInfo(2)
	if (timer == 'BREATH' and paused == 0) then
		-- breath timer is running: player is underwater
		CastSpellByName(WATER_MOUNT)
		return
	end

	if (IsFlyableArea()) then
		CastSpellByName(FLYING_MOUNT)
		return
	end

	CastSpellByName(GROUND_MOUNT)
end

SLASH_HERO_MOUNT1 = '/heromount'
