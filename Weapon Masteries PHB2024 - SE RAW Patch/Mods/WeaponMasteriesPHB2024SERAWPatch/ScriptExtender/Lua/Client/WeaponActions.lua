-- Script removes the vanilla Weapon Actions that are granted when you have proficiency with the equipped weapon type
  -- This does not remove *special* Weapon Actions (e.g., Pahalar Aluve's Melody or The Sacred Star's Dawnburst Strike)

local APO_WeaponSpells = {
  ["Target_PostureBreaker"] = true,
  ["Shout_Steady"] = true,
  ["Zone_Cleave"] = true,
  ["Target_ConcussiveSmash"] = true,
  ["Target_CripplingStrike"] = true,
  ["Target_DisarmingStrike"] = true,
  ["Target_OpeningAttack"] = true,
  ["Target_HeartStopper"] = true,
  ["Target_Slash_New"] = true,
  ["Target_PiercingThrust"] = true,
  ["Target_PommelStrike"] = true,
  ["Shout_FullSwing"] = true,
  ["Rush_SpringAttack"] = true,
  ["Interrupt_Overwhelm"] = true,
  ["Target_Topple"] = true,
  ["Target_HinderingSmash"] = true,
  ["Shout_SteadyRangedCrossbow"] = true,
  ["Projectile_HamstringShot"] = true,
  ["Projectile_MobileShooting"] = true,
  ["Projectile_PiercingShot"] = true,
  ["Goon_Target_PostureBreaker_Offhand"] = true,
  ["Goon_Zone_Cleave_Offhand"] = true,
  ["Goon_Target_ConcussiveSmash_Offhand"] = true,
  ["Goon_Target_CripplingStrike_Offhand"] = true,
  ["Goon_Target_DisarmingStrike_Offhand"] = true,
  ["Goon_Target_OpeningAttack_Offhand"] = true,
  ["Goon_Target_HeartStopper_Offhand"] = true,
  ["Goon_Target_Slash_New_Offhand"] = true,
  ["Goon_Target_PiercingThrust_Offhand"] = true,
  ["Goon_Target_PommelStrike_Offhand"] = true,
  ["Goon_Shout_FullSwing_Offhand"] = true,
  ["Goon_FullSwing_Passive_Offhand"] = true,
  ["Goon_Rush_SpringAttack_Offhand"] = true,
  ["Goon_Overwhelm_Offhand"] = true,
  ["Goon_Target_Topple_Offhand"] = true,
  ["Goon_Target_HinderingSmash_Offhand"] = true,
  ["Goon_Shout_MAG_WhirlwindAttack_Offhand"] = true
}

local APO_BoostFields = {
  "BoostsOnEquipMainHand",
  "BoostsOnEquipOffHand",
  "PassivesMainHand",
  "PassivesOffHand"
}

local function APO_RemoveWeaponActions(boosts)
  local updatedBoost = false
  local keptBoosts = {}

  for entry in string.gmatch(boosts, "([^;]+)") do
    local spellId = entry:match("^UnlockSpell%(([^,%)]+)")
    if spellId and APO_WeaponSpells[spellId] then
      updatedBoost = true
    else
      keptBoosts[#keptBoosts + 1] = entry
    end
  end

  if updatedBoost then
    return table.concat(keptBoosts, ";"), true
  end
  return boosts, false
end

Ext.Events.StatsLoaded:Subscribe(function(StatsLoaded)
  for i, name in pairs(Ext.Stats.GetStats("Weapon")) do
    local stat = Ext.Stats.Get(name)

    for _, field in ipairs(APO_BoostFields) do
      local boosts = stat[field]
      if boosts and boosts ~= "" then
        local cleaned, keptBoosts = APO_RemoveWeaponActions(boosts)
        if updatedBoosts then
          stat[field] = cleaned
        end
      end
    end
  end
end)