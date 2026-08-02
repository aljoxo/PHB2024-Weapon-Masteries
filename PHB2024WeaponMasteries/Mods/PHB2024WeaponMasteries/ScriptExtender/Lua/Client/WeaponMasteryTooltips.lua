-- This is inspired by the script that MaxStrengthWizard used in Heavy Weapons RAW (https://www.nexusmods.com/baldursgate3/mods/19028)
-- Kind of just placeholder rn, unsure if I need it until I talk to Caites about tooltip stuff. . .

local APO_WEAPON_MASTERY = {
    Battleaxes = "APO_WM_ToppleTooltip",
    Clubs = "APO_WM_SlowTooltip",
    Daggers = "APO_WM_NickTooltip",
    Darts = "APO_WM_VexTooltip",
    Flails = "APO_WM_SapTooltip",
    Glaives = "APO_WM_GrazeTooltip",
    Greataxes = "APO_WM_CleaveTooltip",
    Greatclubs = "APO_WM_PushTooltip",
    Greatswords = "APO_WM_GrazeTooltip",
    HandCrossbows = "APO_WM_VexTooltip",
    Halberds = "APO_WM_CleaveTooltip",
    Handaxes = "APO_WM_VexTooltip",
    HeavyCrossbows = "APO_WM_PushTooltip",
    Javelins = "APO_WM_SlowTooltip",
    LightCrossbows = "APO_WM_SlowTooltip",
    LightHammers = "APO_WM_NickTooltip",
    Longbows = "APO_WM_SlowTooltip",
    Longswords = "APO_WM_SapTooltip",
    Mauls = "APO_WM_ToppleTooltip",
    Maces = "APO_WM_SapTooltip",
    Morningstars = "APO_WM_SapTooltip",
    Quarterstaffs = "APO_WM_ToppleTooltip",
    Pikes = "APO_WM_PushTooltip",
    Rapiers = "APO_WM_VexTooltip",
    Scimitars = "APO_WM_NickTooltip",
    Shortbows = "APO_WM_VexTooltip",
    Shortswords = "APO_WM_VexTooltip",
    Sickles = "APO_WM_NickTooltip",
    Slings = "APO_WM_SlowTooltip",
    Spears = "APO_WM_SapTooltip",
    Tridents = "APO_WM_ToppleTooltip",
    Warhammers = "APO_WM_PushTooltip",
    Warpicks = "APO_WM_SapTooltip"
}

local function addWeaponMasteryTooltips()
    for _, name in pairs(Ext.Stats.GetStats("Weapon")) do
        local weapon = Ext.Stats.Get(name)
        local passive
        for _, group in pairs(weapon["Proficiency Group"]) do
           passive = APO_WEAPON_MASTERY[group]
           if passive then break end 
        end    
        if passive then
            for _, property in pairs(weapon["Weapon Properties"]) do    
                if property == "Heavy" then
                    weapon.PassivesOnEquip = (weapon.PassivesOnEquip ~= "" and weapon.PassivesOnEquip .. ";" or "") .. passive
                    break
                end
            end
        end
    end
end

Ext.Events.StatsLoaded:Subscribe(addHeavyWeaponPassive)