local addonName, core = ...;
 
local OptionsPanel = CreateFrame("FRAME", addonName .. "_ConfigPanel", UIParent)
OptionsPanel.name = addonName
InterfaceOptions_AddCategory(OptionsPanel)

local Title = OptionsPanel:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
Title:SetJustifyV('TOP')
Title:SetJustifyH('LEFT')
Title:SetPoint('TOPLEFT', 16, -16)
Title:SetText(OptionsPanel.name)

local SubText = OptionsPanel:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmall')
SubText:SetMaxLines(3)
SubText:SetNonSpaceWrap(true)
SubText:SetJustifyV('TOP')
SubText:SetJustifyH('LEFT')
SubText:SetPoint('TOPLEFT', Title, 'BOTTOMLEFT', 0, -8)
SubText:SetPoint('RIGHT', -32, 0)
SubText:SetText('This Addons automatically confirms your pre selected role (Tank, Healer or DamageDealer) if the party leader queues for a dungeon or raid.')

local checkEnabled = CreateFrame("CheckButton", addonName .."_IsEnabled", OptionsPanel, "UICheckButtonTemplate")
_G[checkEnabled:GetName() .. "Text"]:SetText("Enabled")
checkEnabled:SetPoint('TOPLEFT', SubText, 'BOTTOMLEFT', -8, -20)
checkEnabled:SetScript("OnClick", function(self) 
	AutoLFGRoleEnabled = self:GetChecked()
end)

local frame = CreateFrame("FRAME", addonName .. "_LoadedEventHandler")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, arg1)
	if arg1 == addonName then
		if AutoLFGRoleEnabled == nil then
			AutoLFGRoleEnabled = true
		end
	
		checkEnabled:SetChecked(AutoLFGRoleEnabled)
		print(addonName .. " config loaded!")
	end
end)
 
local frame = CreateFrame("FRAME", addonName .. "_EventHandler")
frame:RegisterEvent("LFG_ROLE_CHECK_SHOW")
frame:SetScript("OnEvent", function(self, event, arg)
	if AutoLFGRoleEnabled == true then
		print("Auto accepting role ...")
		DEFAULT_CHAT_FRAME.editBox:SetText("/click LFDRoleCheckPopupAcceptButton")
		ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)
	end
end)

