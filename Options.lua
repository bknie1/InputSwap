-- InputSwap options panel: Options > AddOns > InputSwap

local ADDON, ns = ...

local panel = CreateFrame("Frame", "InputSwapOptionsPanel")
panel.name = "InputSwap"

local refreshing = false
local controls = {}

---------------------------------------------------------------------------
-- Layout
---------------------------------------------------------------------------
local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
title:SetPoint("TOPLEFT", 16, -16)
title:SetText("InputSwap")

local blurb = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
blurb:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
blurb:SetWidth(560)
blurb:SetJustifyH("LEFT")
blurb:SetText("Switches Enable Gamepad UI automatically based on how you last moved your character. " ..
    "Push the left stick for the Gamepad UI. Press a movement key for the mouse & keyboard UI.")

local status = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
status:SetPoint("TOPLEFT", blurb, "BOTTOMLEFT", 0, -16)
status:SetJustifyH("LEFT")

local function Tooltip(frame, text)
    frame:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(text, 1, 1, 1, 1, true)
        GameTooltip:Show()
    end)
    frame:SetScript("OnLeave", function() GameTooltip:Hide() end)
end

local function MakeCheckbox(key, label, tip, anchor, offsetY, get, set)
    local cb = CreateFrame("CheckButton", "InputSwapOpt" .. key, panel, "UICheckButtonTemplate")
    cb:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", -2, offsetY)
    local text = cb.Text or _G["InputSwapOpt" .. key .. "Text"]
    if text then text:SetText(label) end
    cb:SetScript("OnClick", function(self)
        if not refreshing then set(self:GetChecked() and true or false) end
    end)
    Tooltip(cb, tip)
    controls[#controls + 1] = function() cb:SetChecked(get()) end
    return cb
end

local enabled = MakeCheckbox("Enabled", "Enable automatic switching",
    "Turn InputSwap on or off. When off, the Gamepad UI setting is never changed by this addon.",
    status, -12,
    function() return ns.db.enabled end,
    function(v) ns.SetEnabled(v) end)

local combat = MakeCheckbox("Combat", "Switch after combat ends",
    "Unchecked: stick and keyboard input is ignored while you are in combat.\n" ..
    "Checked: the last input during combat is remembered and the switch happens when combat ends.",
    enabled, -4,
    function() return ns.db.combat end,
    function(v) ns.SetCombat(v) end)

local minimap = MakeCheckbox("Minimap", "Show minimap button",
    "Shows a button on the minimap with the current mode. Left-click switches now, right-click opens these options, drag to move it.",
    combat, -4,
    function() return not ns.db.hideMinimap end,
    function(v) if ns.SetMinimapShown then ns.SetMinimapShown(v) end end)

local slider = CreateFrame("Slider", "InputSwapOptDelay", panel, "OptionsSliderTemplate")
slider:SetPoint("TOPLEFT", minimap, "BOTTOMLEFT", 6, -28)
slider:SetWidth(240)
slider:SetMinMaxValues(0, 10)
slider:SetValueStep(1)
if slider.SetObeyStepOnDrag then slider:SetObeyStepOnDrag(true) end
local sliderText = _G["InputSwapOptDelayText"]
local sliderLow, sliderHigh = _G["InputSwapOptDelayLow"], _G["InputSwapOptDelayHigh"]
if sliderLow then sliderLow:SetText("0s") end
if sliderHigh then sliderHigh:SetText("10s") end
local function SliderLabel(v)
    if sliderText then sliderText:SetText(("Minimum time between switches: %ds"):format(v)) end
end
slider:SetScript("OnValueChanged", function(_, value)
    local v = math.floor(value + 0.5)
    SliderLabel(v)
    if not refreshing then ns.SetDelay(v) end
end)
Tooltip(slider, "Each switch reloads the UI, so this keeps an accidental bump of the stick or a key from causing repeated loading screens.")
controls[#controls + 1] = function() slider:SetValue(ns.db.delay); SliderLabel(ns.db.delay) end

local function MakeButton(label, tip, anchor, x, onClick)
    local b = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    b:SetSize(220, 24)
    b:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", x, -28)
    b:SetText(label)
    b:SetScript("OnClick", onClick)
    Tooltip(b, tip)
    return b
end

local padBtn = MakeButton("Switch to Gamepad UI now", "Switches immediately. The UI reloads.", slider, -6,
    function() ns.ForceSwitch("pad") end)
local mkbBtn = MakeButton("Switch to Mouse & Keyboard now", "Switches immediately. The UI reloads.", slider, -6,
    function() ns.ForceSwitch("mkb") end)
mkbBtn:ClearAllPoints()
mkbBtn:SetPoint("LEFT", padBtn, "RIGHT", 10, 0)

local help = panel:CreateFontString(nil, "ARTWORK", "GameFontDisableSmall")
help:SetPoint("TOPLEFT", padBtn, "BOTTOMLEFT", 0, -20)
help:SetJustifyH("LEFT")
help:SetText("Slash commands: /inputswap help")

---------------------------------------------------------------------------
-- Refresh / Blizzard options callbacks
---------------------------------------------------------------------------
local function Refresh()
    if not ns.db then return end
    refreshing = true
    for _, fn in ipairs(controls) do fn() end
    refreshing = false
    status:SetText("Current mode: " .. ns.CurrentMode())
end

panel:SetScript("OnShow", Refresh)
panel.OnRefresh = Refresh
panel.OnCommit = function() end
panel.OnDefault = function()
    if ns.ResetDefaults then ns.ResetDefaults(); Refresh() end
end

---------------------------------------------------------------------------
-- Register in Options > AddOns
---------------------------------------------------------------------------
if Settings and Settings.RegisterCanvasLayoutCategory then
    local category = Settings.RegisterCanvasLayoutCategory(panel, panel.name)
    Settings.RegisterAddOnCategory(category)
    ns.OpenOptions = function()
        local id = category.GetID and category:GetID() or category.ID
        Settings.OpenToCategory(id)
    end
elseif InterfaceOptions_AddCategory then
    InterfaceOptions_AddCategory(panel)
    ns.OpenOptions = function()
        InterfaceOptionsFrame_OpenToCategory(panel)
        InterfaceOptionsFrame_OpenToCategory(panel)   -- first call can land on the wrong page
    end
end
