local addonName, addon = ...

addon.sounds = {
  ---------------
  --- PING SOUNDS
  ---------------
  5339002, -- standard ping
  --5339004, -- standard hostile variation, unused
  5340601, -- standard hostile
  5339006, -- assist
  5350036, -- attack
  5342387,
  5340605,

  ---------------
  --- BLIZZARD
  ---------------
  -- 567478,  -- Ready Check, also used by wow in the SFX channel by default
  -- 876098,  -- Blizzard Raid Emote

  ---------------
  --- DBM
  ---------------
  -- 543587,  -- Algalon: Beware!
  -- 552035,  -- BB Wolf: Run Away
  -- 552503,  -- Illidan: Not Prepared
  -- 1412178, -- Illidan: Not Prepared2
  -- 553193,  -- Kil'Jaeden: Destruction
  -- 554236,  -- Loatheb: I see you
  -- 566558,  -- Night Elf Bell
  -- 569200,  -- PvP Flag
  -- 546633,  -- C'Thun: You Will Die!
  -- 551703,  -- Headless Horseman: Laugh
  -- 553050,  -- Kaz'rogal: Marked
  -- 553566,  -- Lady Malande: Flee
  -- 555337,  -- Milhouse: Light You Up
  -- 563787,  -- Void Reaver: Marked
  -- 564859,  -- Yogg Saron: Laugh

}

function addon:AddLSMSounds()
  local LSM = LibStub("LibSharedMedia-3.0")
  if not LSM then return end
  if not LSM.MediaTable then return end
  if not LSM.MediaTable.sound then return end
  for _, sound in pairs(LSM.MediaTable.sound) do
    local fileId = tonumber(sound)
    if fileId then
      table.insert(addon.sounds, fileId)
    end
  end
end
