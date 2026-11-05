-- InputSwap
-- Switches the Gamepad UI on/off based on how you last moved your character:
--   * left analog stick  -> Gamepad UI on
--   * movement keys      -> Gamepad UI off (mouse & keyboard UI)
-- Type /inputswap help for commands.

local ADDON, ns = ...
local L = ns.L

local DEFAULTS = {
    enabled = true,
    combat  = false,   -- false: ignore input during combat. true: remember it and switch after combat.
    delay   = 3,       -- minimum seconds between switches (each switch reloads the UI)
    cvar    = "InputDeviceInterfaceStyle",   -- 0 = mouse & keyboard, 1 = gamepad
}

local STICK_THRESHOLD = 0.25   -- squared stick magnitude (~0.5 deflection)
local LOAD_GRACE      = 2      -- seconds to ignore input after a (re)load
local MOVE_ACTIONS = { "MOVEFORWARD", "MOVEBACKWARD", "STRAFELEFT", "STRAFERIGHT", "TURNLEFT", "TURNRIGHT" }

local db
local moveKeys = {}
local pending                  -- device ("pad"/"mkb") waiting for combat to end or the delay to pass
local lastSwitch = -1000
local loadTime = 0
local debugOn, rawOn = false, false

---------------------------------------------------------------------------
-- Output
---------------------------------------------------------------------------
local PREFIX = "|cff66ccffInputSwap:|r "
local function say(msg) print(PREFIX .. msg) end
local function dbg(msg) if debugOn then print("|cff999999InputSwap debug:|r " .. msg) end end
local function rawlog(msg) if rawOn then print("|cffffcc00InputSwap raw:|r " .. msg) end end

---------------------------------------------------------------------------
-- Switching
---------------------------------------------------------------------------
local function InCombat()
    return InCombatLockdown() or UnitAffectingCombat("player")
end

local function WantedValue(device)
    return (device == "pad") and "1" or "0"
end

local Switch   -- forward declaration

local function ScheduleRetry(wait)
    C_Timer.After(wait + 0.05, function()
        if pending then
            local d = pending
            pending = nil
            Switch(d, "queued")
        end
    end)
end

function Switch(device, why)
    if not db or not db.enabled then return end
    if GetTime() - loadTime < LOAD_GRACE then return end

    local want = WantedValue(device)
    if GetCVar(db.cvar) == want then pending = nil; return end   -- already in that mode

    if InCombat() then
        if db.combat then pending = device; dbg("in combat, queued " .. device)
        else dbg("in combat, ignored " .. device) end
        return
    end

    local elapsed = GetTime() - lastSwitch
    if elapsed < db.delay then
        if not pending then ScheduleRetry(db.delay - elapsed) end
        pending = device
        dbg(("too soon, queued %s for %.1fs"):format(device, db.delay - elapsed))
        return
    end

    pending = nil
    local ok, err = pcall(SetCVar, db.cvar, want)
    lastSwitch = GetTime()
    if not ok then say(L["could not change %s: %s"]:format(db.cvar, tostring(err))); return end
    dbg(("%s -> %s (%s = %s)"):format(why or "input", device, db.cvar, want))
end

---------------------------------------------------------------------------
-- Input detection
---------------------------------------------------------------------------
local function BuildMoveKeys()
    wipe(moveKeys)
    for _, action in ipairs(MOVE_ACTIONS) do
        for _, bound in ipairs({ GetBindingKey(action) }) do
            local key = bound:match("([^%-]+)$") or bound      -- strip SHIFT-/CTRL-/ALT-
            if bound:sub(-1) == "-" then key = "-" end
            moveKeys[key] = true
        end
    end
end

local function IsLeftStick(stick)
    local s = tostring(stick):lower()
    return s == "l" or s:find("left") ~= nil
end

local f = CreateFrame("Frame", "InputSwapFrame", UIParent)
f:SetAllPoints()
f:EnableKeyboard(true)
pcall(f.SetPropagateKeyboardInput, f, true)   -- never swallow key presses meant for the game
if f.EnableGamePadButton then f:EnableGamePadButton(true) end
if f.EnableGamePadStick then f:EnableGamePadStick(true) end

f:SetScript("OnKeyDown", function(_, key)
    rawlog("key " .. tostring(key))
    if key and moveKeys[key] then Switch("mkb", "key " .. key) end
end)

f:SetScript("OnGamePadStick", function(_, stick, x, y)
    local mag = (x or 0) ^ 2 + (y or 0) ^ 2
    if mag > STICK_THRESHOLD then
        rawlog(("stick %s %.2f, %.2f"):format(tostring(stick), x or 0, y or 0))
        if IsLeftStick(stick) then Switch("pad", "left stick") end
    end
end)

f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("UPDATE_BINDINGS")
f:RegisterEvent("PLAYER_REGEN_ENABLED")
f:RegisterEvent("PLAYER_REGEN_DISABLED")

f:SetScript("OnEvent", function(_, event, arg1)
    if event == "ADDON_LOADED" and arg1 == ADDON then
        local old = InputSwapDB or {}
        db = {
            enabled = old.enabled ~= false,
            combat  = old.combat == true,
            delay   = tonumber(old.delay) or tonumber(old.debounce) or DEFAULTS.delay,
            cvar    = (old.v == 7 and old.cvar) or DEFAULTS.cvar,
            hideMinimap  = old.hideMinimap == true,
            minimapAngle = tonumber(old.minimapAngle) or 200,
            v       = 7,
        }
        InputSwapDB = db
        ns.db = db
    elseif event == "PLAYER_LOGIN" then
        BuildMoveKeys()
        loadTime = GetTime()
        if ns.OnLogin then ns.OnLogin() end
    elseif event == "UPDATE_BINDINGS" then
        BuildMoveKeys()
    elseif event == "PLAYER_REGEN_DISABLED" then
        if db and not db.combat then pending = nil end
    elseif event == "PLAYER_REGEN_ENABLED" then
        if pending then
            local d = pending
            pending = nil
            Switch(d, "after combat")
        end
    end
end)

---------------------------------------------------------------------------
-- Actions shared by the slash commands and the options panel
---------------------------------------------------------------------------
function ns.SetEnabled(v)
    db.enabled = v and true or false
    if not db.enabled then pending = nil end
end

function ns.SetCombat(v) db.combat = v and true or false end

function ns.SetDelay(n) db.delay = n end

function ns.ResetDefaults()
    db.enabled, db.combat, db.delay = DEFAULTS.enabled, DEFAULTS.combat, DEFAULTS.delay
    pending = nil
end

function ns.IsGamepad()
    return GetCVar(db.cvar) == "1"
end

function ns.CurrentMode()      -- localized label of the current mode
    return ns.IsGamepad() and L["Gamepad UI"] or L["Mouse & keyboard UI"]
end

function ns.ToggleMode()
    ns.ForceSwitch((GetCVar(db.cvar) == "1") and "mkb" or "pad")
end

function ns.ForceSwitch(device)           -- device: "pad" or "mkb"; ignores delay and load grace
    local was = db.enabled
    loadTime = -1000; lastSwitch = -1000; db.enabled = true
    Switch(device, "manual")
    db.enabled = was
end

---------------------------------------------------------------------------
-- Slash commands
---------------------------------------------------------------------------
local function onoff(b)
    return b and ("|cff33ff33" .. L["on"] .. "|r") or ("|cffff5555" .. L["off"] .. "|r")
end

local function Status()
    local mode = ns.CurrentMode()
    say(L["%s  |  current: %s  |  during combat: %s  |  min. time between switches: %ds"]:format(
        onoff(db.enabled), mode, db.combat and L["switch after combat"] or L["ignored"], db.delay))
end

local HELP = {
    { "/inputswap",              "show status" },
    { "/inputswap on | off",     "enable or disable the addon" },
    { "/inputswap pad | mkb",    "switch to Gamepad UI / mouse & keyboard UI right now" },
    { "/inputswap combat",       "toggle: ignore input in combat, or switch once combat ends" },
    { "/inputswap delay <s>",    "minimum seconds between switches (default 3)" },
    { "/inputswap minimap",      "show or hide the minimap button" },
    { "/inputswap config",       "open the options panel (Options > AddOns > InputSwap)" },
    { "/inputswap debug",        "toggle debug messages (also: debug raw | debug keys | debug cvar [name])" },
    { "/inputswap help",         "show this list" },
}

local function Help()
    say(L["Switches Gamepad UI automatically: left stick = Gamepad UI, your movement keys = mouse & keyboard UI."])
    for _, row in ipairs(HELP) do
        print(("  |cffffd100%s|r  %s"):format(row[1], L[row[2]]))
    end
end

local function Debug(arg)
    local sub, rest = arg:match("^(%S*)%s*(.-)$")
    sub = sub:lower()
    if sub == "" then
        debugOn = not debugOn; say("debug messages " .. onoff(debugOn))
    elseif sub == "raw" then
        rawOn = not rawOn; say("raw input log " .. onoff(rawOn))
    elseif sub == "keys" then
        local t = {}
        for k in pairs(moveKeys) do t[#t + 1] = k end
        table.sort(t)
        say("movement keys: " .. (#t > 0 and table.concat(t, ", ") or "(none bound)"))
    elseif sub == "cvar" then
        if rest ~= "" then db.cvar = rest end
        say(("controlling CVar %s (value %s)"):format(db.cvar, tostring(GetCVar(db.cvar))))
    else
        say("debug options: (none) | raw | keys | cvar [name]")
    end
end

SLASH_INPUTSWAP1 = "/inputswap"
SLASH_INPUTSWAP2 = "/is"
SlashCmdList["INPUTSWAP"] = function(msg)
    if not db then return end
    local cmd, arg = (msg or ""):match("^(%S*)%s*(.-)$")
    cmd = cmd:lower()

    if cmd == "" or cmd == "status" then Status()
    elseif cmd == "help" or cmd == "?" then Help()
    elseif cmd == "on" then ns.SetEnabled(true); say(L["enabled"])
    elseif cmd == "off" then ns.SetEnabled(false); say(L["disabled"])
    elseif cmd == "combat" then
        ns.SetCombat(not db.combat)
        say(db.combat and L["In combat, input is remembered and the switch happens when combat ends."]
                       or L["Input is ignored during combat."])
    elseif cmd == "delay" then
        local n = tonumber(arg)
        if n and n >= 0 then ns.SetDelay(n); say(L["minimum time between switches: %ds"]:format(n))
        else say(L["usage: /inputswap delay <seconds>"]) end
    elseif cmd == "pad" or cmd == "mkb" then
        ns.ForceSwitch(cmd)
    elseif cmd == "minimap" then
        if ns.SetMinimapShown then
            ns.SetMinimapShown(db.hideMinimap)
            say(db.hideMinimap and L["minimap button hidden"] or L["minimap button shown"])
        end
    elseif cmd == "config" or cmd == "options" then
        if ns.OpenOptions then ns.OpenOptions() else say(L["options panel is not available in this client"]) end
    elseif cmd == "debug" then Debug(arg)
    else
        say(L["unknown command '%s'. Type /inputswap help"]:format(cmd))
    end
end
