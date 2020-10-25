-- Quest item bar functions based on http://www.wowace.com/addons/questitembar/ by Nickenyfiken and ZidayaXis
local _
-- global functions and variebles to locals to keep LINT happy
local assert = _G.assert
local LibStub = _G.LibStub; assert(LibStub ~= nil,'LibStub')
local CreateFrame = _G.CreateFrame; assert(CreateFrame ~= nil,'CreateFrame')
local floor = _G.floor; assert(floor ~= nil,'floor')
local GameTooltip = _G.GameTooltip; assert(GameTooltip ~= nil,'GameTooltip')
local GameTooltip_SetDefaultAnchor = _G.GameTooltip_SetDefaultAnchor; assert(GameTooltip_SetDefaultAnchor ~= nil,'GameTooltip_SetDefaultAnchor')
local GetCVar = _G.GetCVar; assert(GetCVar ~= nil,'GetCVar')
local GetItemCount = _G.GetItemCount; assert(GetItemCount ~= nil,'GetItemCount')
local GetItemIcon = _G.GetItemIcon; assert(GetItemIcon ~= nil,'GetItemIcon')
local GetItemInfo = _G.GetItemInfo; assert(GetItemInfo ~= nil,'GetItemInfo')
local GetQuestLogIndexByID = C_QuestLog.GetLogIndexForQuestID; assert(GetQuestLogIndexByID ~= nil,'GetQuestLogIndexByID')
local GetScreenWidth = _G.GetScreenWidth; assert(GetScreenWidth ~= nil,'GetScreenWidth')
local hooksecurefunc = _G.hooksecurefunc; assert(hooksecurefunc ~= nil,'hooksecurefunc')
local ipairs = _G.ipairs; assert(ipairs ~= nil,'ipairs')
local IsControlKeyDown = _G.IsControlKeyDown; assert(IsControlKeyDown ~= nil,'IsControlKeyDown')
local math = _G.math; assert(math ~= nil,'math')
local pairs = _G.pairs; assert(pairs ~= nil,'pairs')
local SetBinding = _G.SetBinding; assert(SetBinding ~= nil,'SetBinding')
local SetBindingClick = _G.SetBindingClick; assert(SetBindingClick ~= nil,'SetBindingClick')
local ShowQuestComplete = _G.ShowQuestComplete; assert(ShowQuestComplete ~= nil,'ShowQuestComplete')
local ShowQuestOffer = _G.ShowQuestOffer; assert(ShowQuestOffer ~= nil,'ShowQuestOffer')
local string = _G.string; assert(string ~= nil,'string')
local type = _G.type; assert(type ~= nil,'type')
local UIParent = _G.UIParent; assert(UIParent ~= nil,'UIParent')
-- local AddOn
local ADDON, P = ...
local NOP = LibStub("AceAddon-3.0"):GetAddon(ADDON)
--
local LIB_QUESTITEM = P.LIB_QUESTITEM; assert(LIB_QUESTITEM ~= nil,'LIB_QUESTITEM')
local print = P.print; assert(print ~= nil,'print')
local T_BLACKLIST_Q = P.T_BLACKLIST_Q; assert(T_BLACKLIST_Q ~= nil,'T_BLACKLIST_Q')
--
function NOP:QBAnchorMove() -- move anchor for quest bar
  if not self.QB then return end
  self.QB:SetClampedToScreen(true)
  self.QB:ClearAllPoints()
  if NOP.AceDB.profile.qb_sticky then
    self.QB:SetAllPoints(P.BUTTON_FRAME)
  else
    local frame = NOP.AceDB.profile.qb[2] or "none"
    if _G[frame] then frame = _G[frame] else frame = nil end -- test if can find frame by name in saved LUA variables
    if not frame then
      if NOP.AceDB.profile.HideInCombat then frame = self.frameHiderQ else frame = UIParent end -- restore frame anchor via requested state
    end
    if not NOP.AceDB.profile.HideInCombat and frame == self.frameHiderQ then frame = UIParent end -- if hide in combat is disabled then can't be anchored to hider
    self.QB:SetPoint(NOP.AceDB.profile.qb[1] or "CENTER", frame, NOP.AceDB.profile.qb[3] or "CENTER", NOP.AceDB.profile.qb[4] or 0, NOP.AceDB.profile.qb[5] or 0)
  end
end
function NOP:QBAnchorSave() -- save Anchor pos after button position change
  if not self.QB then return end
  local point, relativeTo, relativePoint, xOfs, yOfs = self.QB:GetPoint()
  NOP.AceDB.profile.qb = {point or "CENTER", relativeTo and relativeTo.GetName and relativeTo:GetName() or "UIParent", relativePoint or "CENTER", xOfs or 0, yOfs or 0}
end
function NOP:QBAnchorSize() -- resize quest bar anchor to current icon size
  if not self.QB then return end
  self.QB:SetClampedToScreen(true)
  local iconSize = NOP.AceDB.profile.iconSize or P.DEFAULT_ICON_SIZE
  if not (GetScreenWidth() > 1500) then iconSize = math.floor(iconSize * 0.75) end
  self.QB:SetWidth(iconSize)
  self.QB:SetHeight(iconSize)
  if not self.QB.buttons then return end
  for i = 1, #self.QB.buttons do 
    local bt = self.QB.buttons[i]
    self:QBButtonSize(bt)
    self:QBButtonAnchor(i)
  end
end
function NOP:QBAnchor() -- create quest bar anchor frame
  self.QB = CreateFrame("Frame",P.QB_NAME.."Anchor",self.frameHiderQ)
  self:QBAnchorSize() -- same size as item button
  self:QBAnchorMove() -- same position as item button
  self.QB.buttons = {} -- create empty button list
  if NOP.AceDB.profile.quest then 
    if not (self.QB:IsShown() or self.QB:IsVisible()) then self.QB:Show() end
  else
    if self.QB:IsShown() or self.QB:IsVisible() then self.QB:Hide() end
  end -- state of anchor
end
function NOP:QBButtonSize(bt) -- resize button to current icon size
  local iconSize = NOP.AceDB.profile.iconSize or P.DEFAULT_ICON_SIZE
  if not (GetScreenWidth() > 1500) then iconSize = math.floor(iconSize * 0.75) end
  bt:SetWidth(iconSize)
  bt:SetHeight(iconSize)
end
function NOP:QBButton(i, p) -- create new quest bar button
  if p.buttons and p.buttons[i] then
    local bt = p.buttons[i]
    return bt
  end
  local name = P.QB_NAME..i
  local bt = CreateFrame("Button", name, p, "SecureActionButtonTemplate, ActionButtonTemplate")
  self:QBButtonSize(bt)
  self:ButtonBackdrop(bt)
  bt:RegisterForClicks("AnyUp") -- act on key release 
  bt:SetScript("OnEnter",  function(self) NOP:QBOnEnter(self) end)
  bt:SetScript("OnLeave",  function(self) NOP:QBOnLeave(self) end)
  bt:SetScript("PostClick",function(self,mouse) NOP:QBPostClick(self,mouse) end)
  bt.questMark = bt:CreateTexture(name.."Quest", "OVERLAY")
  bt.questMark:SetTexture(P.QUEST_ICON);
  bt.questMark:SetTexCoord(0.125, 0.250, 0.125, 0.250);
  bt.questMark:SetAllPoints()
  bt.questMark:Hide()
  self:ButtonStore(bt)
  bt.timer = bt:CreateFontString(nil,"OVERLAY","GameFontWhite")
  local timer = bt.timer
  local font, size = bt.count:GetFont()
  timer:SetFont(font, size-2,"OUTLINE")
  self:ButtonSwap(bt,NOP.AceDB.profile.swap)
  self:ButtonSkin(bt,NOP.AceDB.profile.skinButton)
  p.buttons[i] = bt -- store button ref to anchor frame
  return bt -- return button
end
function NOP:QBOnEnter(bt) -- build and show tooltip
  if self:inCombat() then return end
  if not _G.ElvUI then -- with ElvUI installed this is not neccessary
    if GetCVar("UberTooltips") == "1" then
      GameTooltip_SetDefaultAnchor(GameTooltip, bt)
    else
      GameTooltip:SetOwner(bt, "ANCHOR_RIGHT")
    end
  else
    local gto = GameTooltip:GetOwner()
    if not gto then GameTooltip_SetDefaultAnchor(GameTooltip,  UIParent) end
  end
  GameTooltip:SetHyperlink(bt:GetAttribute("item1")) -- fill up tooltip
  local text = LIB_QUESTITEM.questItemText[bt.itemID] -- fetch quest
  if text then
    text = P.L["Quest"] .. ": " .. LIB_QUESTITEM.questItemText[bt.itemID]
  else
    text = P.L["Quest not found for this item."]
  end
  GameTooltip:AddLine(text, 0, 1, 0)
  GameTooltip:AddLine(" ")
  GameTooltip:AddLine(P.MOUSE_RB .. P.CLICK_SKIP_MSG,0,1,0)
  GameTooltip:AddLine(P.MOUSE_RB .. P.CLICK_BLACKLIST_MSG)
  GameTooltip:Show()
end
function NOP:QBOnLeave(bt) -- close tooltip
  if self:inCombat() then return end
  GameTooltip:Hide() 
end
function NOP:QBBlacklist(isPermanent,itemID) -- add quest item to blacklist
  if itemID then
    local name = GetItemInfo(itemID)
    if isPermanent then
      if not NOP.AceDB.profile["T_BLACKLIST_Q"] then NOP.AceDB.profile.T_BLACKLIST_Q = {} end
      NOP.AceDB.profile.T_BLACKLIST_Q[0] = true
      NOP.AceDB.profile.T_BLACKLIST_Q[itemID] = true
      print(P.L["PERMA_BLACKLIST"],name or itemID)
    else
      T_BLACKLIST_Q[0] = true -- blacklist is defined
      T_BLACKLIST_Q[itemID] = true
      print(P.L["SESSION_BLACKLIST"],name or itemID)
    end
    self:QBUpdate() -- force update
  end
end
function NOP:QBPostClick(bt,mouse) -- click on button, place hotkey if none
  if mouse and (mouse == 'RightButton') then self:QBBlacklist(IsControlKeyDown(),bt.itemID) end
  if NOP.AceDB.profile.keyBind and (bt.itemID ~= self.AceDB.char.questBarID) then
    self.AceDB.char.questBarID = bt.itemID
    self:QBKeyBind(bt)
  end
end
function NOP:QBKeyBind(bt,i) -- define hotkey
  if not (bt and NOP.AceDB.profile.keyBind and string.len(NOP.AceDB.profile.keyBind) > 0) then return end
  if self:inCombat() then self:TimerFire("QBKeyBind", P.TIMER_IDLE, bt, i); return end
  if bt and bt.GetName and string.len(bt:GetName()) > 0 then 
    self:QBClearBind()
    SetBindingClick(NOP.AceDB.profile.keyBind, bt:GetName(), 'LeftButton')
    if bt.hotkey then bt.hotkey:SetText(self:ButtonHotKey(NOP.AceDB.profile.keyBind)) end
    self.qbKBIndex = i
  end
end
function NOP:QBClearBind() -- remove hotkey from bar and key-binds
  if not (self.QB and self.QB.buttons) then return end
  for _,bt in ipairs(self.QB.buttons) do -- at least one button can have hot-key, clear all
    if bt and bt.hotkey and bt.hotkey.SetText then bt.hotkey:SetText("") end
  end
  SetBinding(NOP.AceDB.profile.keyBind) -- unbind key
  self.qbKBIndex = nil -- no index
end
function NOP:QBButtonAnchor(i) -- anchor buttons
  local button = self.QB.buttons[i]
  local parent = (i == 1 or (i-1) % NOP.AceDB.profile.slots == 0) and (P.QB_NAME.."Anchor") or (P.QB_NAME..(i-1)) -- anchor to anchor frame or last button
  local rowspace = 0
  if (i > 1) and ((i-1) % NOP.AceDB.profile.slots == 0) then rowspace = -NOP.AceDB.profile.expand * (NOP.AceDB.profile.iconSize + NOP.AceDB.profile.spacing) * floor(i/NOP.AceDB.profile.slots) end
  button:ClearAllPoints()
  if NOP.AceDB.profile.direction == "RIGHT" then
    button:SetPoint("LEFT", parent, "RIGHT", NOP.AceDB.profile.spacing, -rowspace)
  elseif NOP.AceDB.profile.direction == "LEFT" then
    button:SetPoint("RIGHT", parent, "LEFT", -NOP.AceDB.profile.spacing, rowspace)
  elseif NOP.AceDB.profile.direction == "UP" then
    button:SetPoint("BOTTOM", parent, "TOP", rowspace, NOP.AceDB.profile.spacing)
  elseif NOP.AceDB.profile.direction == "DOWN" then
    button:SetPoint("TOP", parent, "BOTTOM", -rowspace, -NOP.AceDB.profile.spacing)
  end
end
function NOP:QBButtonAdd(i, itemID) -- set new item
  local count = GetItemCount(itemID)
  local bt = self:QBButton(i, self.QB)
  bt.icon:SetTexture(GetItemIcon(itemID))
  bt.itemID = itemID
  bt.count:SetText((type(count) == "number") and (count > 1) and count or "")
  bt:SetAttribute("type1","item") -- "type1" Unmodified left click, old type*.
  bt:SetAttribute("item1", LIB_QUESTITEM:GetItemString(itemID))
  if (LIB_QUESTITEM.startsQuestItems[itemID] and not LIB_QUESTITEM.activeQuestItems[itemID]) or (itemID == P.DEFAULT_ITEMID and NOP.AceDB.profile.visible) then -- quest item or fake button
    self.QB.refreshBar = true -- even QUEST_ACCEPTED need call LIB_QUESTITEM:Scan()
    bt.questMark:Show()
  else
    bt.questMark:Hide()
  end
  self:QBButtonAnchor(i)
  if (itemID == self.AceDB.char.questBarID) then -- rebind hotkey to last used item
    self:QBKeyBind(bt,i)
  end
  if not(bt:IsShown() or bt:IsVisible()) then bt:Show() end
end
function NOP:QBReset() -- hide and clear buttons on quest bar
  self.QB.refreshBar = false -- post refresh by calling LIB_QUESTITEM:Scan()
  if not (self.QB and self.QB.buttons) then return end
  for i = 1, #self.QB.buttons do 
    local bt = self.QB.buttons[i]
    if bt then
      bt.itemID = nil
      bt.count:SetText("") -- empty count
      if bt:IsShown() or bt:IsVisible() then bt:Hide() end -- hide button
    end
  end
end
function NOP:QBUpdate() -- update all buttons on quest bar
  if not self.QB or not self.QB.buttons then return end -- not yet initialized
  if self:inCombat() then self:TimerFire("QBUpdate", P.TIMER_IDLE); return end
  if not NOP.AceDB.profile.quest then 
    if self.QB:IsShown() or self.QB:IsVisible() then self.QB:Hide() end
    return
  end -- quest bar is disabled and hidden nothing to do
  self:QBClearBind() -- remove hotkey
  self:QBReset() -- clear and hide all buttons on quest bar
  if not (self.QB:IsShown() or self.QB:IsVisible()) then self.QB:Show() end
  local i = 1
  for itemID, _ in pairs(LIB_QUESTITEM.startsQuestItems) do -- place all items starting quests
    if not (LIB_QUESTITEM.activeQuestItems[itemID] or NOP.AceDB.profile.T_BLACKLIST_Q[itemID] or T_BLACKLIST_Q[itemID]) then self:QBButtonAdd(i, itemID); i = i + 1 end
  end
  for itemID, _ in pairs(LIB_QUESTITEM.usableQuestItems) do -- place all usable items
    if not (LIB_QUESTITEM.startsQuestItems[itemID] or NOP.AceDB.profile.T_BLACKLIST_Q[itemID] or T_BLACKLIST_Q[itemID]) then self:QBButtonAdd(i, itemID); i = i + 1 end -- this item is already on bar
  end
  if (i > 1) then -- have at least one item on quest bar
    if not self.qbKBIndex then -- no button has hot-key assigned
      self:QBKeyBind(self.QB.buttons[1]) -- bind by default 1st button
      self.qbKBIndex = 1
    end
    return
  end
  if NOP.AceDB.profile.visible then -- create quest bar with fake item and exclamation over it
    for i = 1, NOP.AceDB.profile.slots * 2 do
      self:QBButtonAdd(i, P.DEFAULT_ITEMID)
    end
  end
end
function NOP:QBSkin() -- skin buttons on quest bar
  if not self.QB then return end
  for i = 1, #self.QB.buttons do self:ButtonSkin(self.QB.buttons[i],NOP.AceDB.profile.skinButton) end
end
function NOP:QBQuestAccept() -- refresh items on Quest Items Bar when quest is accepted, some items can change state, but bags get not update event!
  if not (self.LQI and self.QB and self.QB.refreshBar) then return end -- nothing to do
  if self:inCombat() then self:TimerFire("QBQuestAccept", P.TIMER_IDLE); return end
  self.LQI:Scan()
end
function NOP:QBAutoQuestTimer(ptype,qID)
  if self:inCombat() then self:TimerFire("QBAutoQuestTimer", P.TIMER_IDLE,ptype,qID); return end
  local index = GetQuestLogIndexByID(qID)
  if not index then return end -- qest is not present now it was completed during fight
  if (ptype == "OFFER") then
    ShowQuestOffer(index)
  else
    ShowQuestComplete(index)
  end
end
function NOP:QBAutoQuest()
  hooksecurefunc("AutoQuestPopupTracker_AddPopUp", 
    function(questID, popUpType)
      if NOP.AceDB.profile.autoquest and (type(questID) == "number") and (type(popUpType) == "string") and questID then
        local index = GetQuestLogIndexByID(questID)
        if index then NOP:QBAutoQuestTimer(popUpType,questID) end -- taint prevent
      end
    end
  )
end
-- /dump (NOP.QB.buttons[1]).isSkinned
-- /dump NOP:ButtonSkin(NOP.QB.buttons[1])