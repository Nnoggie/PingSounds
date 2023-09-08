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
  vdt(addon.sounds)
end
