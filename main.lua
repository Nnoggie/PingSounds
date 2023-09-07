local addonName, addon = ...
local asyncConfig = {
  type = "everyFrame",
  maxTime = 8,
  maxTimeCombat = 8,
  errorHandler = geterrorhandler()
}
addon.asyncHandler = LibStub("LibAsync"):GetHandler(asyncConfig)

function addon:Async(func, name, singleton)
  addon.asyncHandler:Async(func, name, singleton)
end

function addon:AddonPrint(msg)
  print("|cFF3275c3"..addonName.."|r: "..msg)
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("CVAR_UPDATE")
f:RegisterEvent("PLAYER_LOGOUT")
f:RegisterEvent("CHAT_MSG_PING")

local reportLoadingFinished = false
local isLoadingFinished = false

f:SetScript("OnEvent", function(self, event, ...)
  if event == "PLAYER_ENTERING_WORLD" then
    local isInitialLogin, isReload = ...
    if isInitialLogin then
      addon:Login()
    end
    f:UnregisterEvent("PLAYER_ENTERING_WORLD")
  elseif event == "CVAR_UPDATE" then
    local cvar, value = ...
    if cvar == "Sound_EnableSFX" and addon.db.enabled then
      addon:AddonPrint(
        "To Restore normal sound effect behavior, use /pingsounds disable and relog or disable the AddOn completely")
    end
  elseif event == "PLAYER_LOGOUT" then
    if addon.db.enabled then
      SetCVar("Sound_EnableSFX", 0)
    end
  elseif event == "CHAT_MSG_PING" then
    if addon.db.enabled and not isLoadingFinished then
      addon:AddonPrint("Ping sounds will play after the loading process has finished.")
      reportLoadingFinished = true
    end
  end
end)

function addon:Login()
  if addon.db.enabled then
    C_Timer.After(2, function()
      addon:SetMuteStatus(true)
    end)
  end
end

local function round(number, decimals)
  return tonumber((("%%.%df"):format(decimals)):format(number))
end

local pingSounds = {
  5339002, -- standard ping
  --5339004, -- standard hostile variation, unused
  5340601, -- standard hostile
  5339006, -- assist
  5350036, -- attack
  5342387,
  5340605,
}

function addon:SetMuteStatus(mute)
  f:UnregisterEvent("CVAR_UPDATE")
  SetCVar("Sound_EnableSFX", 0)
  local setMuteStatusAllAsync = function()
    for i = 1, 6000000 do
      if mute then
        MuteSoundFile(i)
      else
        ---@diagnostic disable-next-line: redundant-parameter
        UnmuteSoundFile(i)
      end
      if i % 100 == 0 then
        coroutine.yield()
      end
    end
  end

  local setMuteStatusForSounds = function(sounds)
    for _, id in pairs(sounds) do
      ---@diagnostic disable-next-line: redundant-parameter
      UnmuteSoundFile(id)
    end
  end

  addon:Async(function()
    local start = GetTime()
    setMuteStatusAllAsync()
    setMuteStatusForSounds(pingSounds)
    local elapsed = round(GetTime() - start, 2)
    if mute then SetCVar("Sound_EnableSFX", 1) end
    f:RegisterEvent("CVAR_UPDATE")
    if reportLoadingFinished then
      addon:AddonPrint("Loading finished after "..elapsed.."s")
    end
    isLoadingFinished = true
  end, "Mute")
end
