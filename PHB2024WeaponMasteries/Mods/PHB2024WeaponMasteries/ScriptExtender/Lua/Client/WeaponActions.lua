local APO_WeaponSpells = {
  "Target_PostureBreaker",
  "Shout_Steady",
  "Zone_Cleave",
  "Target_ConcussiveSmash",
  "Target_CripplingStrike",
  "Target_DisarmingStrike",
  "Target_OpeningAttack",
  "Target_HeartStopper",
  "Target_Slash_New",
  "Target_PiercingThrust",
  "Target_PommelStrike",
  "Shout_FullSwing",
  "Rush_SpringAttack",
  "Interrupt_Overwhelm",
  "Target_Topple",
  "Target_HinderingSmash",
  "Shout_SteadyRangedCrossbow",
  "Projectile_HamstringShot",
  "Projectile_MobileShooting",
  "Projectile_PiercingShot"
}

local function APO_SpellsToRemove(entry)
  for i, name in ipairs(APO_WeaponSpells) do
    if string.find(entry, name) then
      return true
    end
  end
end

Ext.Events.StatsLoaded:Subscribe(function(StatsLoaded)
  for i, name in pairs(Ext.Stats.GetStats("Weapon")) do
    local stat = Ext.Stats.Get(name)
    local boosts = stat.BoostsOnEquipMainHand

    if boosts and boosts ~= "" then
      local updatedBoost = false
      local emptyBoost = {}
      
      for entry in string.gmatch(boosts, "([^;]+)") dp
        if APO_SpellsToRemove(entry) then
          updatedBoost = true
        else
          table.insert(emptyBoost, entry)
        end
      end

      if updatedBoost then
        stat.BoostsOnEquipMainHand = table.concat(emptyBoost, ";")
      end
    end
  end
end)