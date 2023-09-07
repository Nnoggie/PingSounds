local addonName, addon = ...;

local dbDefaults = {
  enabled = true,
};

local function setUpDB()
  PingSoundsDB = PingSoundsDB or CopyTable(dbDefaults);
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
