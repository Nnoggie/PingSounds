local addonName, addon = ...;

local dbDefaults = {
  enabled = true,
  addonSounds = {},
};

local function setUpDB()
  PingSoundsDB = PingSoundsDB or CopyTable(dbDefaults);
  for k, v in pairs(dbDefaults) do
    -- migrate
    if (not PingSoundsDB[k]) and (type(PingSoundsDB[k]) ~= "boolean") then
      PingSoundsDB[k] = v;
    end
  end
  addon.db = PingSoundsDB
end

local eventListener = CreateFrame("Frame");
eventListener:RegisterEvent("ADDON_LOADED");

eventListener:SetScript("OnEvent", function(self, event, ...)
  if (event == "ADDON_LOADED") then
    local loadedAddonName = ...;
    if (loadedAddonName == addonName) then
      setUpDB()
      eventListener:UnregisterEvent("ADDON_LOADED");
    end
  end
end);
