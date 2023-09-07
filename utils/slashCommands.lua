local addonName, addon = ...;

local slashPrefixes = {
  "/pingsounds",
}

local slashArguments = {
  enable = function()
    if addon.db.enabled then
      addon:AddonPrint('already enabled')
      return
    end
    addon.db.enabled = true
    addon:AddonPrint('enabled')
    addon:SetMuteStatus(true)
  end,
  disable = function()
    if not addon.db.enabled then
      addon:AddonPrint('already disabled')
      return
    end
    addon.db.enabled = false
    addon:AddonPrint('disabled')
    addon:SetMuteStatus(false)
  end,
  toggle = function()
    addon.db.enabled = not addon.db.enabled
    addon:AddonPrint(addon.db.enabled and 'enabled' or 'disabled')
    addon:SetMuteStatus(addon.db.enabled)
  end,
}

local function slashCommandHandler(args, editbox)
  local req, arg = strsplit(' ', args)
  if req and req ~= '' then
    slashArguments[req]()
  else
    slashArguments.toggle()
  end
end

for i, command in pairs(slashPrefixes) do
  _G["SLASH_"..strupper(addonName).."SHOW"..i] = command
end
SlashCmdList[strupper(addonName).."SHOW"] = slashCommandHandler
