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
  ["Projectile_PiercingShot"] = true
}

-- local function APO_SpellsToRemove(entry)
--   for i, name in ipairs(APO_WeaponSpells) do
--     if string.find(entry, name) then
--       return true
--     end
--   end
-- end

Ext.Events.StatsLoaded:Subscribe(function(StatsLoaded)
  for i, name in pairs(Ext.Stats.GetStats("Weapon")) do
    local stat = Ext.Stats.Get(name)
    local boosts = stat.BoostsOnEquipMainHand

    if boosts and boosts ~= "" then
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
        stat.BoostsOnEquipMainHand = table.concat(keptBoosts, ";")
      end
    end
  end
end)
