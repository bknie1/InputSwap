-- InputSwap minimap button: shows the current mode and lets you switch or open the options.
--   Left-click  switch to the other mode now
--   Right-click open Options > AddOns > InputSwap
--   Drag        move around the minimap

local ADDON, ns = ...
local L = ns.L

local ICON_PAD = "Interface\\AddOns\\InputSwap\\Media\\icon-pad"
local ICON_MKB = "Interface\\AddOns\\InputSwap\\Media\\icon-mkb"
local atan2 = math.atan2 or math.atan

local button = CreateFrame("Button", "InputSwapMinimapButton", Minimap)
button:SetSize(31, 31)
button:SetFrameStrata("MEDIUM")
button:SetFrameLevel(8)
button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
button:RegisterForDrag("LeftButton")
button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

local icon = button:CreateTexture(nil, "ARTWORK")
icon:SetSize(20, 20)
icon:SetPoint("TOPLEFT", 7, -5)

local border = button:CreateTexture(nil, "OVERLAY")
border:SetSize(53, 53)
border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
border:SetPoint("TOPLEFT")

---------------------------------------------------------------------------
-- Position and appearance
---------------------------------------------------------------------------
local function UpdatePosition()
    local angle = math.rad((ns.db and ns.db.minimapAngle) or 200)
    local radius = (Minimap:GetWidth() / 2) + 5
    button:ClearAllPoints()
    button:SetPoint("CENTER", Minimap, "CENTER", math.cos(angle) * radius, math.sin(angle) * radius)
end

local function Refresh()
    if not ns.db then return end
    icon:SetTexture(ns.IsGamepad() and ICON_PAD or ICON_MKB)
    if ns.db.hideMinimap then button:Hide() else button:Show() end
end

function ns.SetMinimapShown(show)
    ns.db.hideMinimap = not show
    Refresh()
end

ns.OnLogin = function()
    UpdatePosition()
    Refresh()
end

---------------------------------------------------------------------------
-- Interaction
---------------------------------------------------------------------------
local function DragUpdate()
    local mx, my = Minimap:GetCenter()
    local scale = Minimap:GetEffectiveScale()
    local cx, cy = GetCursorPosition()
    ns.db.minimapAngle = math.deg(atan2(cy / scale - my, cx / scale - mx)) % 360
    UpdatePosition()
end

button:SetScript("OnDragStart", function(self)
    self.dragging = true
    GameTooltip:Hide()
    self:SetScript("OnUpdate", DragUpdate)
end)

button:SetScript("OnDragStop", function(self)
    self.dragging = false
    self:SetScript("OnUpdate", nil)
end)

button:SetScript("OnClick", function(_, mouseButton)
    if mouseButton == "RightButton" then
        if ns.OpenOptions then ns.OpenOptions() end
    else
        ns.ToggleMode()
    end
end)

button:SetScript("OnEnter", function(self)
    if self.dragging then return end
    local other = ns.IsGamepad() and L["Mouse & keyboard UI"] or L["Gamepad UI"]
    GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    GameTooltip:AddLine("InputSwap")
    GameTooltip:AddLine(L["Current: %s"]:format(ns.CurrentMode()), 1, 1, 1)
    GameTooltip:AddLine(L["Automatic switching: %s"]:format(ns.db.enabled and L["on"] or L["off"]), 0.7, 0.7, 0.7)
    GameTooltip:AddLine(" ")
    GameTooltip:AddLine(L["Left-click: switch to %s now"]:format(other), 0.8, 0.8, 0.8)
    GameTooltip:AddLine(L["Right-click: options"], 0.8, 0.8, 0.8)
    GameTooltip:AddLine(L["Drag: move this button"], 0.8, 0.8, 0.8)
    GameTooltip:Show()
end)

button:SetScript("OnLeave", function() GameTooltip:Hide() end)

button:RegisterEvent("CVAR_UPDATE")
button:SetScript("OnEvent", function(_, _, name)
    if ns.db and name == ns.db.cvar then Refresh() end
end)
