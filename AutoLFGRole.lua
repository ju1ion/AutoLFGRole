local AcquireFrame, ReleaseFrame
do
	local frame_cache = {}

	function AcquireFrame()
		local frame = tremove(frame_cache) or CreateFrame("Frame")
		return frame
	end

	function ReleaseFrame(frame)
		frame:Hide()
		frame:SetParent(nil)
		frame:ClearAllPoints()
		tinsert(frame_cache, frame)
	end
end	-- do block
 
local frame = AcquireFrame()
frame:RegisterEvent("LFG_ROLE_CHECK_SHOW")
frame:SetScript("OnEvent", function(self, event, arg)

print("Auto accepting role ...")

DEFAULT_CHAT_FRAME.editBox:SetText("/click LFDRoleCheckPopupAcceptButton")
ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0)

end)
ReleaseFrame(frame)

