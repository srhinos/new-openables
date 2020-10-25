-- Button functions
local _
-- global functions and variebles to locals to keep LINT happy
local assert = _G.assert
local BROWSE_NO_RESULTS = _G.BROWSE_NO_RESULTS; assert(BROWSE_NO_RESULTS ~= nil,'BROWSE_NO_RESULTS')
local CreateFrame = _G.CreateFrame; assert(CreateFrame ~= nil,'CreateFrame')
local GameTooltip = _G.GameTooltip; assert(GameTooltip ~= nil,'GameTooltip')
local GameTooltip_SetDefaultAnchor = _G.GameTooltip_SetDefaultAnchor; assert(GameTooltip_SetDefaultAnchor ~= nil,'GameTooltip_SetDefaultAnchor')
local GetCVar = _G.GetCVar; assert(GetCVar ~= nil,'GetCVar')
local GetItemCooldown = _G.GetItemCooldown; assert(GetItemCooldown ~= nil,'GetItemCooldown')
local GetItemInfo = _G.GetItemInfo; assert(GetItemInfo ~= nil,'GetItemInfo')
local GetMouseFocus = _G.GetMouseFocus; assert(GetMouseFocus ~= nil,'GetMouseFocus')
local GetScreenWidth = _G.GetScreenWidth; assert(GetScreenWidth ~= nil,'GetScreenWidth')
local GetTime = _G.GetTime; assert(GetTime ~= nil,'GetTime')
local IsAltKeyDown = _G.IsAltKeyDown; assert(IsAltKeyDown ~= nil,'IsAltKeyDown')
local IsControlKeyDown = _G.IsControlKeyDown; assert(IsControlKeyDown ~= nil,'IsControlKeyDown')
local LibStub = _G.LibStub; assert(LibStub ~= nil,'LibStub')
local math = _G.math; assert(math ~= nil,'math')
local string = _G.string; assert(string ~= nil,'string')
local STRING_SCHOOL_UNKNOWN = _G.STRING_SCHOOL_UNKNOWN; assert(STRING_SCHOOL_UNKNOWN ~= nil,'STRING_SCHOOL_UNKNOWN')
local tinsert = _G.tinsert; assert(tinsert ~= nil,'tinsert')
local tremove = _G.tremove; assert(tremove ~= nil,'tremove')
local type = _G.type; assert(type ~= nil,'type')
local UIParent = _G.UIParent; assert(UIParent ~= nil,'UIParent')
local unpack = _G.unpack; assert(unpack ~= nil,'unpack')
-- local AddOn
local ADDON, P = ...
local NOP = LibStub("AceAddon-3.0"):GetAddon(ADDON)
-- private variables and constants
local BUTTON_FRAME = P.BUTTON_FRAME; assert(BUTTON_FRAME ~= nil,'BUTTON_FRAME')
local CLICK_BLACKLIST_MSG = P.CLICK_BLACKLIST_MSG; assert(CLICK_BLACKLIST_MSG ~= nil,'CLICK_BLACKLIST_MSG')
local CLICK_DRAG_MSG = P.CLICK_DRAG_MSG; assert(CLICK_DRAG_MSG ~= nil,'CLICK_DRAG_MSG')
local CLICK_OPEN_MSG = P.CLICK_OPEN_MSG; assert(CLICK_OPEN_MSG ~= nil,'CLICK_OPEN_MSG')
local CLICK_SKIP_MSG = P.CLICK_SKIP_MSG; assert(CLICK_SKIP_MSG ~= nil,'CLICK_SKIP_MSG')
local DEFAULT_ICON = P.DEFAULT_ICON; assert(DEFAULT_ICON ~= nil,'DEFAULT_ICON')
local DEFAULT_ICON_SIZE = P.DEFAULT_ICON_SIZE; assert(DEFAULT_ICON_SIZE ~= nil,'DEFAULT_ICON_SIZE')
local L = P.L
local MACRO_INACTIVE = P.MACRO_INACTIVE; assert(MACRO_INACTIVE ~= nil,'MACRO_INACTIVE')
local MOUSE_LB = P.MOUSE_LB; assert(MOUSE_LB ~= nil,'MOUSE_LB')
local MOUSE_RB = P.MOUSE_RB; assert(MOUSE_RB ~= nil,'MOUSE_RB')
local TIMER_IDLE = P.TIMER_IDLE; assert(TIMER_IDLE ~= nil,'TIMER_IDLE')
local print = P.print; assert(print ~= nil,'print')
-- private functions
local function SetOutside(obj, anchor, xOffset, yOffset)
  xOffset = xOffset or 1
  yOffset = yOffset or 1
  anchor = anchor or obj:GetParent()
  if obj:GetPoint() then
    obj:ClearAllPoints()
  end
  obj:SetPoint('TOPLEFT', anchor, 'TOPLEFT', -xOffset, yOffset)
  obj:SetPoint('BOTTOMRIGHT', anchor, 'BOTTOMRIGHT', xOffset, -yOffset)
end
local function SetInside(obj, anchor, xOffset, yOffset)
  xOffset = xOffset or 1
  yOffset = yOffset or 1
  anchor = anchor or obj:GetParent()
  if obj:GetPoint() then
    obj:ClearAllPoints()
  end
  obj:SetPoint('TOPLEFT', anchor, 'TOPLEFT', xOffset, -yOffset)
  obj:SetPoint('BOTTOMRIGHT', anchor, 'BOTTOMRIGHT', -xOffset, yOffset)
end
--
function NOP:ButtonSkin(button,skin) -- skin or restore button look
  if not button then return end
  if self.masque and NOP.AceDB.profile.masque then -- let Masque do its job
    if button.isSkinned == nil then self.masque:AddButton(button); self.masque:ReSkin() end
    button.isSkinned = true
    return
  end
  if skin then
    if button.isSkinned then return end
    local ht = button:CreateTexture(nil,"OVERLAY")
    if ht.SetTexture then ht:SetColorTexture(0.3, 0.3, 0.3, 0.5) end -- semitransparent highlight
    if ht.SetInside then ht:SetInside() else SetInside(ht) end
    button.ht = ht
    if button.SetHighlightTexture then button:SetHighlightTexture(ht) end
    local pt = button:CreateTexture(nil,"OVERLAY")
    if pt.SetTexture then pt:SetColorTexture(0, 0, 0, 0) end -- transparent push
    if pt.SetInside then pt:SetInside() else SetInside(pt) end
    button.pt = pt
    button:SetPushedTexture(pt)
    if button.cooldown then -- remove swipe
      if button.cooldown.SetDrawEdge then button.cooldown:SetDrawEdge(false) end
      if button.cooldown.SetDrawBling then button.cooldown:SetDrawBling(false) end
      if button.cooldown.SetDrawSwipe then button.cooldown:SetDrawSwipe(false) end
      if button.cooldown.SetSwipeColor then button.cooldown:SetSwipeColor(0, 0, 0, 0) end
    end
    if not _G.WWM then button.icon:SetTexCoord(0.08,0.92,0.08,0.92) end -- cut out icon border
    if button.icon.SetInside then button.icon:SetInside() else SetInside(button.icon) end
    button.normal:SetTexture(nil) -- kill texture
    button.normal:Hide() -- hide overlay
    button.normal:SetAlpha(0) -- kill transparency
    button.hotkey:ClearAllPoints()
    button.hotkey:SetPoint("TOPRIGHT", 1, -2)
    button.isSkinned = true -- skin only once
  else
    if (button.isSkinned == nil) then return end -- nothing to restore is not skinned
    if button.b_icon then button.icon:SetTexCoord(unpack(button.b_icon)) end
    if button.b_texture then button.normal:SetTexture(button.b_texture) end
    if button.b_alpha then button.normal:SetAlpha(button.b_alpha) end
    button.normal:Show()
    button.count:ClearAllPoints()
    if button.b_count then button.count:SetPoint(unpack(button.b_count)) end
    button.hotkey:ClearAllPoints()
    if button.b_hotkey then button.hotkey:SetPoint(unpack(button.b_hotkey)) end
    if button.b_htexture then button:SetHighlightTexture(button.b_htexture) end
    if button.b_ptexture then button:SetPushedTexture(button.b_ptexture) end
    if button.cooldown and button.cooldown.SetDrawEdge then 
      if button.b_draw then 
        button.cooldown:SetDrawEdge(button.b_draw)
        button.cooldown:SetDrawBling(button.b_draw)
        button.cooldown:SetDrawSwipe(button.b_draw)
      end
      button.cooldown:SetSwipeColor(0.1, 0.1, 0.1, .8)
    end
    button.isSkinned = nil
  end
end
function NOP:ButtonReputation(tooltip,func) -- add reputation into tooltip
  if not (tooltip and tooltip.GetItem) then return end
  local OHC = _G.OHC -- reference to order hall commander addon
  local OrderHallMissionFrame = _G.OrderHallMissionFrame -- Order Hall Mission frame
  if (func == "SetItemByID") and (OHC ~= nil) and OrderHallMissionFrame and OrderHallMissionFrame:IsVisible() then return end -- OHC have own tooltip for reward with reputation item
  local name = tooltip:GetItem(); if not name then return end
  local level, top, value, reward = self:GetReputation(name); if not level then return end
  if level < 8 then -- up to exalted
    tooltip:AddLine(_G['FACTION_STANDING_LABEL' .. level] .. (" |cffca3c3c%.2f%%|r"):format((value/top) * 100.0))
  else
    tooltip:AddLine(_G['FACTION_STANDING_LABEL' .. level] .. (reward and "+" or ''))
  end
  tooltip:Show()
end
function NOP:ButtonOnEnter(button) -- show tooltip
  if self:inCombat() then return; end
  if not _G.ElvUI then -- with ElvUI installed this is not neccessary
    if GetCVar("UberTooltips") == "1" then
      GameTooltip_SetDefaultAnchor(GameTooltip, UIParent)
    else
      GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
    end
  else
    local gto = GameTooltip:GetOwner()
    if not gto then GameTooltip_SetDefaultAnchor(GameTooltip, UIParent) end
  end
  if button.bagID ~= nil and button.slotID ~= nil then
    GameTooltip:SetBagItem(button.bagID,button.slotID)
    if GameTooltip:NumLines() < 1 then
      local name = GetItemInfo(button.itemID)
      GameTooltip:SetText("|cFFFF00FF" .. (name or STRING_SCHOOL_UNKNOWN) .. "|r")
    end
  else
    GameTooltip:SetText(BROWSE_NO_RESULTS)
  end
  if button.itemTexture then
    GameTooltip:AddLine(" ")
    GameTooltip:AddLine(MOUSE_LB .. CLICK_OPEN_MSG,0,1,0)
    GameTooltip:AddLine(MOUSE_RB .. CLICK_SKIP_MSG,0,1,0)
    GameTooltip:AddLine(MOUSE_RB .. CLICK_BLACKLIST_MSG)
  end
  if not NOP.AceDB.profile.lockButton then 
    GameTooltip:AddLine(MOUSE_LB .. CLICK_DRAG_MSG)
  end
  GameTooltip:SetClampedToScreen(true) -- tooltip must stay at screen
  GameTooltip:Show()
end
function NOP:ButtonOnLeave(button) -- hide tooltip
  if self:inCombat() then return; end
  GameTooltip:Hide()
end
function NOP:ButtonPostClick(button) -- post click on button
  if button then
    self.BF.clickON = nil
    if (button == 'RightButton') then
      self:BlacklistItem(IsControlKeyDown(),self.BF.itemID)
      self.BF.itemID = nil
    end
    self:TimerFire("ItemShowNew", TIMER_IDLE / 3)
  end
end
function NOP:ButtonOnDragStart(button) -- start moving
  if NOP.AceDB.profile.lockButton or self:inCombat() then return end
  if IsAltKeyDown() then button:StartMoving() end
end
function NOP:ButtonOnDragStop(button) -- stop moving and save new position
  button:StopMovingOrSizing()
  self:ButtonSave()
  self:QBAnchorSave() -- now always save if NOP.AceDB.profile.qb_sticky then self:QBAnchorSave() end
end
function NOP:ButtonReset() -- reset button to default position
  if self:inCombat() then self:TimerFire("ButtonReset", TIMER_IDLE); return end
  self.AceDB.profile.iconSize = DEFAULT_ICON_SIZE -- default size
  self.AceDB.profile.lockButton = false -- unlock
  self.AceDB.profile.button = {"CENTER", nil, "CENTER", 0, 0}
  self:ButtonSize()
  self:ButtonMove()
  self:QBUpdate()
  print(L["BUTTON_RESET"])
end
function NOP:ButtonSize() -- resize button
  if self:inCombat() then self:TimerFire("ButtonSize", TIMER_IDLE); return end
  self.timerButtonSize = nil
  if not self.BF then return end
  local iconSize = NOP.AceDB.profile.iconSize or DEFAULT_ICON_SIZE
  if not (GetScreenWidth() > 1500) then iconSize = math.floor(iconSize * 0.75) end
  self.BF:SetWidth(iconSize)
  self.BF:SetHeight(iconSize)
  if NOP.AceDB.profile.qb_sticky then self:QBAnchorSize(); self:QBUpdate(); end -- Quest Bar is locked to Item Button
end
function NOP:ButtonSave() -- save button position after move
  if not self.BF then return end
  local point, relativeTo, relativePoint, xOfs, yOfs = self.BF:GetPoint()
  NOP.AceDB.profile.button = {point or "CENTER", relativeTo and relativeTo.GetName and relativeTo:GetName() or "UIParent", relativePoint or "CENTER", xOfs, yOfs}
end
function NOP:ButtonMove() -- move button from UI config
  if self:inCombat() then self:TimerFire("ButtonMove", TIMER_IDLE); return end
  self.BF:SetClampedToScreen(true)
  self.BF:ClearAllPoints()
  local frame = NOP.AceDB.profile.button[2] or "none"
  if _G[frame] then frame = _G[frame] else frame = nil end -- test if can find frame by name in saved LUA variables
  if not frame then
    if NOP.AceDB.profile.HideInCombat then frame = self.frameHiderB else frame = UIParent end -- restore frame anchor via requested state
  end
  if not NOP.AceDB.profile.HideInCombat and frame == self.frameHiderB then frame = UIParent end -- if hide in combat is disabled then can't be anchored to hider
  self.BF:SetPoint(NOP.AceDB.profile.button[1] or "CENTER", frame, NOP.AceDB.profile.button[3] or "CENTER", NOP.AceDB.profile.button[4] or 0, NOP.AceDB.profile.button[5] or 0)
  self:ButtonSave()
end
function NOP:ButtonStore(button) -- save default properties
  local name = button and button:GetName()
  if not name then return end
  button.icon   = _G[name .. "Icon"]
  button.hotkey = _G[name .. "HotKey"]
  button.count  = _G[name .. "Count"]
  button.normal = _G[name .. "NormalTexture"]
  if self.masque == nil then
    button.b_icon     = {button.icon:GetTexCoord()} -- save actual values
    button.b_texture  = button.normal:GetTexture() -- save original texture
    button.b_alpha    = button.normal:GetAlpha() -- save original value
    button.b_count    = {button.count:GetPoint()} -- save points
    button.b_hotkey   = {button.hotkey:GetPoint()} -- save points
    button.b_htexture = button.GetHighlightTexture and button:GetHighlightTexture() or nil
    button.b_ptexture = button.GetPushedTexture and button:GetPushedTexture() or nil
    button.b_draw     = button.cooldown and button.cooldown.GetDrawEdge and button.cooldown:GetDrawEdge() or false
  end
end
function NOP:ButtonBackdrop(bt) -- create backdrop for button
  if not NOP.AceDB.profile.backdrop then return end
  if self.masque and NOP.AceDB.profile.masque then return end
  local btex = bt:CreateTexture(nil, "BACKGROUND")
  btex:SetColorTexture(0, 0, 0, 1)
  btex:SetDrawLayer("BACKGROUND", -1)
  if btex.SetOutside then btex:SetOutside(bt) else SetOutside(btex,bt) end
  bt.backdropTexture = btex
end
function NOP:ButtonLoad() -- create button, restore his position
  if self:inCombat() then self:TimerFire("ButtonLoad", TIMER_IDLE); return end
  if not self.BF then -- new button
    self.BF = CreateFrame("Button", BUTTON_FRAME, self.frameHiderB, "SecureActionButtonTemplate, ActionButtonTemplate")
    local bt = self.BF
    if bt:IsVisible() or bt:IsShown() then bt:Hide() end
    bt:SetFrameStrata(NOP.AceDB.profile.strata and "HIGH" or "MEDIUM")
    self:ButtonBackdrop(bt) -- create backdrop around button if enabled
    bt:RegisterForDrag("LeftButton") -- ALT-LEFT-MOUSE for drag
    bt:RegisterForClicks("AnyUp") -- act on key release 
    bt:SetScript("OnEnter",     function(self) NOP:ButtonOnEnter(self) end)
    bt:SetScript("OnLeave",     function(self) NOP:ButtonOnLeave(self) end)
    bt:SetScript("PreClick",    function(self,button) NOP.preClick = true end)
    bt:SetScript("PostClick",   function(self,button) NOP:ButtonPostClick(button) end)
    bt:SetScript("OnDragStart", function(self) NOP:ButtonOnDragStart(self) end)
    bt:SetScript("OnDragStop",  function(self) NOP:ButtonOnDragStop(self) end)
    bt.icon:SetTexture(DEFAULT_ICON)
    self:ButtonStore(bt)
    bt.timer = bt:CreateFontString(nil,"OVERLAY","GameFontWhite")
    local timer = bt.timer
    local font, size = bt.count:GetFont()
    timer:SetFont(font,size-2,"OUTLINE")
    bt:EnableMouse(true)
    bt:SetMovable(true)
  end
  self:ButtonSize() -- set or restore size
  self:ButtonMove() -- set or restore position
  self:ButtonSkin(self.BF, NOP.AceDB.profile.skinButton)
  self:ButtonSwap(self.BF, NOP.AceDB.profile.swap)
end
function NOP:ButtonSwap(bt,swap) -- swap count and timer text sides on button
  if not bt then return end
  if not bt.timer then return end
  if not bt.count then return end
  if swap then
    bt.count:ClearAllPoints()
    bt.count:SetPoint('BOTTOMLEFT',bt,'BOTTOMLEFT', 1, -1)
    bt.count:SetJustifyH("LEFT")
    bt.count:SetJustifyV("MIDDLE")
    bt.timer:ClearAllPoints()
    bt.timer:SetPoint("BOTTOMRIGHT",bt,"BOTTOMRIGHT", 1, -1)
    bt.timer:SetJustifyH("RIGHT")
    bt.timer:SetJustifyV("MIDDLE")
  else
    bt.count:ClearAllPoints()
    bt.count:SetPoint("BOTTOMRIGHT",bt,"BOTTOMRIGHT", 1, -1)
    bt.count:SetJustifyH("RIGHT")
    bt.count:SetJustifyV("MIDDLE")
    bt.timer:ClearAllPoints()
    bt.timer:SetPoint('BOTTOMLEFT',bt,'BOTTOMLEFT', 1, -1)
    bt.timer:SetJustifyH("LEFT")
    bt.timer:SetJustifyV("MIDDLE")
  end
end
function NOP:ButtonCount(count) -- update counter on button
  if self.BF and self.BF.count then
    self.BF.count:SetText((type(count) == "number") and (count > 1) and count or "")
  end
end
function NOP:ButtonShow() -- display button
  if self:inCombat() then self:TimerFire("ButtonShow", TIMER_IDLE); return end
  local bt = self.BF
  self:ButtonCount(bt.itemCount)
  bt.icon:SetTexture(bt.itemTexture or DEFAULT_ICON)
  if (GetMouseFocus() == bt) then self:ButtonOnEnter(bt) end -- update tooltip if mouse is over button
  if bt.itemTexture then
    bt:SetAttribute("type1", "macro") -- "type1" Unmodified left click.
    bt:SetAttribute("macrotext1", bt.mtext)
    self:Verbose("ButtonShow:","macro text",self:CompressText(bt.mtext))
  else
    bt:SetAttribute("macrotext1", "")
  end
  -- self:printt("ButtonShow:","macro text",self:CompressText(bt.mtext))
  if not (bt:IsVisible() or bt:IsShown()) then bt:Show() end
  if NOP.AceDB.profile.glowButton and bt.isGlow then
    self.ActionButton_ShowOverlayGlow(bt)
  else
    self.ActionButton_HideOverlayGlow(bt)
  end
  self.BF.clickON = true -- signals to other addon about new item on button
end
function NOP:ButtonHide() -- hide button
  if self:inCombat() then self:TimerFire("ButtonHide", TIMER_IDLE); return end
  local bt = self.BF
  bt.itemCount = 0
  bt.bagID = nil
  bt.itemID = nil
  bt.isGlow = nil
  bt.mtext = MACRO_INACTIVE
  bt.itemTexture = nil
  bt.icon:SetTexture(DEFAULT_ICON)
  bt:SetAttribute("macrotext1", MACRO_INACTIVE)
  self:ButtonCount(bt.itemCount)
  self.ActionButton_HideOverlayGlow(bt)
  if NOP.AceDB.profile.visible then  -- show fake button, instead hide.
    if not (bt:IsShown() or bt:IsVisible()) then bt:Show() end
  else
    if bt:IsShown() or bt:IsVisible() then bt:Hide() end
  end
end
function NOP:ButtonHotKey(key) -- abbreviation for hotkey string
  if key and (string.len(key) > 0) then
    key = key:gsub('ALT%-', 'A')
    key = key:gsub('CTRL%-', 'C')
    key = key:gsub('SHIFT%-', 'S')
    key = key:gsub('BUTTON', 'M')
		key = key:gsub('MOUSEWHEELUP', 'MWUp');
		key = key:gsub('MOUSEWHEELDOWN', 'MWDn');
		key = key:gsub('NUMPAD', 'Np');
		key = key:gsub('PAGEUP', 'PgUp');
		key = key:gsub('PAGEDOWN', 'PgDn');
		key = key:gsub('INSERT', 'Ins');
		key = key:gsub('HOME', 'Hm');
		key = key:gsub('DELETE', 'Del');
		key = key:gsub('NMULTIPLY', "Np*");
		key = key:gsub('NMINUS', "Np-");
		key = key:gsub('NPLUS', "Np+");
		key = key:gsub('NEQUALS', "Np="); 
  else
    key = ""
  end
  return key
end
function NOP:ButtonOnUpdate(bt,start,duration) -- setup timer on button
  if not bt.timer then return end -- timer text is not defined
  if (start > 0) and (duration > 0) then
    -- print("start",start,"duration",duration)
    local expire = start + duration
    if bt.expire == nil or bt.expire < expire then
      bt.expire = expire
      bt:SetScript("OnUpdate",nil)
      bt:SetScript("OnUpdate", function(self,elapsed)
        if not self.update then self.update = 0 end
        self.update = self.update - elapsed
        if (self.update < 0) then
          if self.itemID and self:IsShown() then
            local start, duration, enable = GetItemCooldown(self.itemID) -- item on button could be another one than when timer started
            local cd = 0
            if (start > 0) and (duration > 0) then cd = (start - GetTime()) + duration end
            if (cd > 0) then
              local update,txt = NOP:SecondsToString(cd)
              self.update = update
              self.timer:SetText(txt)
            else
              self:SetScript("OnUpdate",nil)
              self.timer:SetText(nil)
              self.expire = nil
            end
          end
        end
      end)
    end
  end
end
-- Snip code from blizzard .XML source to prevent taint
local unusedOverlayGlows = {}
local numOverlays = 0
function NOP.ActionButton_GetOverlayGlow()
  local overlay = tremove(unusedOverlayGlows)
  if not overlay then
    numOverlays = numOverlays + 1
    overlay = CreateFrame("Frame", ADDON .. "ActionButtonOverlay"..numOverlays, NOP.frameHiderB, "ActionBarButtonSpellActivationAlert")
  end
  return overlay;
end
function NOP.ActionButton_ShowOverlayGlow(self)
  if self.overlay then
    if self.overlay.animOut:IsPlaying() then
      self.overlay.animOut:Stop()
      self.overlay.animIn:Play()
    end
  else
    self.overlay = NOP.ActionButton_GetOverlayGlow()
    local frameWidth, frameHeight = self:GetSize()
    self.overlay:SetParent(self)
    SetOutside(self.overlay,self,frameWidth/3, frameHeight/3) -- adopted from ElvUI to glow outside
    self.overlay.animIn:Play()
  end
end
function NOP.ActionButton_HideOverlayGlow(self)
  if self.overlay then
    if self.overlay.animIn:IsPlaying() then
      self.overlay.animIn:Stop()
    end
    NOP.ActionButton_OverlayGlowAnimOutFinished(self.overlay.animOut)
  end
end
function NOP.ActionButton_OverlayGlowAnimOutFinished(animGroup)
  local overlay = animGroup:GetParent()
  local actionButton = overlay:GetParent()
  overlay:Hide()
  tinsert(unusedOverlayGlows, overlay)
  actionButton.overlay = nil
end
