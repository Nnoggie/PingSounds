local addonName, addon = ...;

local slashPrefixes = {
  "/pingsounds",
}

local slashArguments = {
  enable = function()
    print('enable')
  end,
  disable = function()
    print('disable')
  end,
  toggle = function()
    print('toggle')
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
