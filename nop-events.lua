-- Event handlers
local _
-- global functions and variebles to locals to keep LINT happy
local assert = _G.assert
local LibStub = _G.LibStub; assert(LibStub ~= nil,'LibStub')
local CreateFrame = _G.CreateFrame; assert(CreateFrame ~= nil,'CreateFrame')
local ERR_CANT_DO_THAT_RIGHT_NOW = _G.ERR_CANT_DO_THAT_RIGHT_NOW; assert(ERR_CANT_DO_THAT_RIGHT_NOW ~= nil,'ERR_CANT_DO_THAT_RIGHT_NOW')
local ERR_ITEM_COOLDOWN = _G.ERR_ITEM_COOLDOWN; assert(ERR_ITEM_COOLDOWN ~= nil,'ERR_ITEM_COOLDOWN')
local ERR_ITEM_LOCKED = _G.ERR_ITEM_LOCKED; assert(ERR_ITEM_LOCKED ~= nil,'ERR_ITEM_LOCKED')
local ERR_ITEM_NOT_FOUND = _G.ERR_ITEM_NOT_FOUND; assert(ERR_ITEM_NOT_FOUND ~= nil,'ERR_ITEM_NOT_FOUND')
local ERR_NO_ITEMS_WHILE_SHAPESHIFTED = _G.ERR_NO_ITEMS_WHILE_SHAPESHIFTED; assert(ERR_NO_ITEMS_WHILE_SHAPESHIFTED ~= nil,'ERR_NO_ITEMS_WHILE_SHAPESHIFTED')
local ERR_SPELL_FAILED_ANOTHER_IN_PROGRESS = _G.ERR_SPELL_FAILED_ANOTHER_IN_PROGRESS; assert(ERR_SPELL_FAILED_ANOTHER_IN_PROGRESS ~= nil,'ERR_SPELL_FAILED_ANOTHER_IN_PROGRESS')
local format = _G.format; assert(format ~= nil,'format')
local GameTooltip = _G.GameTooltip; assert(GameTooltip ~= nil,'GameTooltip')
local GetBindingKey = _G.GetBindingKey; assert(GetBindingKey ~= nil,'GetBindingKey')
local GetBuildInfo = _G.GetBuildInfo; assert(GetBuildInfo ~= nil,'GetBuildInfo')
local GetItemCooldown = _G.GetItemCooldown; assert(GetItemCooldown ~= nil,'GetItemCooldown')
local hooksecurefunc = _G.hooksecurefunc; assert(hooksecurefunc ~= nil,'hooksecurefunc')
local INTERRUPTED = _G.INTERRUPTED; assert(INTERRUPTED ~= nil,'INTERRUPTED')
local ipairs = _G.ipairs; assert(ipairs ~= nil,'ipairs')
local pairs = _G.pairs; assert(pairs ~= nil,'pairs')
local RegisterStateDriver = _G.RegisterStateDriver; assert(RegisterStateDriver ~= nil,'RegisterStateDriver')
local SPELL_FAILED_BAD_TARGETS = _G.SPELL_FAILED_BAD_TARGETS; assert(SPELL_FAILED_BAD_TARGETS ~= nil,'SPELL_FAILED_BAD_TARGETS')
local SPELL_FAILED_ITEM_NOT_READY = _G.SPELL_FAILED_ITEM_NOT_READY; assert(SPELL_FAILED_ITEM_NOT_READY ~= nil,'SPELL_FAILED_ITEM_NOT_READY')
local SPELL_FAILED_MOVING = _G.SPELL_FAILED_MOVING; assert(SPELL_FAILED_MOVING ~= nil,'SPELL_FAILED_MOVING')
local SPELL_FAILED_NOT_MOUNTED = _G.SPELL_FAILED_NOT_MOUNTED; assert(SPELL_FAILED_NOT_MOUNTED ~= nil,'SPELL_FAILED_NOT_MOUNTED')
local string = _G.string; assert(string ~= nil,'string')
local UIErrorsFrame = _G.UIErrorsFrame; assert(UIErrorsFrame ~= nil,'UIErrorsFrame')
local UIParent = _G.UIParent; assert(UIParent ~= nil,'UIParent')
local wipe = _G.wipe; assert(wipe ~= nil,'wipe')
local GetMinimapZoneText = _G.GetMinimapZoneText; assert(GetMinimapZoneText ~= nil,'GetMinimapZoneText')
-- local AddOn
local ADDON, P = ...
local NOP = LibStub("AceAddon-3.0"):GetAddon(ADDON)
--
local print = P.print; assert(print ~= nil,'print')
local T_CHECK = P.T_CHECK; assert(T_CHECK ~= nil,'T_CHECK')
local T_USE = P.T_USE; assert(T_USE ~= nil,'T_USE')
local T_RECIPES_FIND = P.T_RECIPES_FIND; assert(T_RECIPES_FIND ~= nil,'T_RECIPES_FIND')
local T_SPELL_FIND = P.T_SPELL_FIND; assert(T_SPELL_FIND ~= nil,'T_SPELL_FIND')
local LIB_HEREBEDRAGONS = P.LIB_HEREBEDRAGONS; assert(LIB_HEREBEDRAGONS ~= nil,'LIB_HEREBEDRAGONS')
local TIMER_IDLE = P.TIMER_IDLE; assert(TIMER_IDLE ~= nil,'TIMER_IDLE')
local TIMER_RECHECK = P.TIMER_RECHECK; assert(TIMER_RECHECK ~= nil,'TIMER_RECHECK')
local BUTTON_FRAME = P.BUTTON_FRAME; assert(BUTTON_FRAME ~= nil,'BUTTON_FRAME')
local MACRO_PICKLOCK = P.MACRO_PICKLOCK; assert(MACRO_PICKLOCK ~= nil,'MACRO_PICKLOCK')
local NOP_TITLE = P.NOP_TITLE; assert(NOP_TITLE ~= nil,'NOP_TITLE')
local NOP_VERSION = P.NOP_VERSION; assert(NOP_VERSION ~= nil,'NOP_VERSION')
--
function NOP:InitEvents()
  self:RegisterEvent("PLAYER_LOGIN") -- time to load-up data
  self:RegisterEvent("PLAYER_LEVEL_UP") -- lock skill up and some items could be level locked as well
  self:RegisterEvent("SPELLS_CHANGED","PLAYER_LEVEL_UP") -- same as for spellbook
  -- these triggers bag rescan
  self:RegisterEvent("BAG_UPDATE","BAG_UPDATE")
  self:RegisterEvent("BAG_UPDATE_DELAYED","BAG_UPDATE")
  self:RegisterEvent("MAIL_CLOSED","BAG_UPDATE")
  self:RegisterEvent("UNIT_INVENTORY_CHANGED","BAG_UPDATE")
  self:RegisterEvent("BAG_UPDATE_COOLDOWN","BAG_UPDATE")
  self:RegisterEvent("BANKFRAME_CLOSED","BAG_UPDATE")
  self:RegisterEvent("GUILDBANKFRAME_CLOSED","BAG_UPDATE")
  self:RegisterEvent("MERCHANT_CLOSED","BAG_UPDATE")
  self:RegisterEvent("TRADE_CLOSED","BAG_UPDATE")
  self:RegisterEvent("ITEM_PUSH","BAG_UPDATE")
  self:RegisterEvent("CHAT_MSG_LOOT","BAG_UPDATE")
  --
  self:RegisterEvent("GET_ITEM_INFO_RECEIVED") -- when details about cached items are ready
  -- rescan patterns
  self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED","LOOT_SPEC") -- now patterns did change
  self:RegisterEvent("PLAYER_LOOT_SPEC_UPDATED","LOOT_SPEC")
  -- reset cache
  self:RegisterEvent("ZONE_CHANGED","ZONE_CHANGED") -- change zone
  self:RegisterEvent("ZONE_CHANGED_INDOORS","ZONE_CHANGED") -- leave indoors to outdoors or oposite
  self:RegisterEvent("ZONE_CHANGED_NEW_AREA","ZONE_CHANGED") -- leave instance
  self:RegisterEvent("PLAYER_ENTERING_WORLD","ZONE_CHANGED") -- Loading screen
  self:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN") -- cooldown for quest bar
  self:RegisterEvent("QUEST_ACCEPTED") -- update Quest Bar if any item starting quest is placed on it
  self:RegisterEvent("UI_ERROR_MESSAGE") -- blacklist some messages when items and spells are loaded from cache
  self:RegisterEvent("GARRISON_LANDINGPAGE_SHIPMENTS") -- herald notify
end
local OK_ERROR_SHOW = { -- OK errors not ship but not clear them as well
  [ERR_SPELL_FAILED_ANOTHER_IN_PROGRESS] = true,
  [SPELL_FAILED_ITEM_NOT_READY] = true,
  [ERR_NO_ITEMS_WHILE_SHAPESHIFTED] = true,
  [SPELL_FAILED_MOVING] = true,
  [ERR_ITEM_COOLDOWN] = true,
  [SPELL_FAILED_NOT_MOUNTED] = true,
  [ERR_CANT_DO_THAT_RIGHT_NOW] = true,
  [INTERRUPTED] = true,
}
local OK_ERROR_NEXT = { -- OK error, clear and skip
 [ERR_ITEM_NOT_FOUND] = true,
 [SPELL_FAILED_BAD_TARGETS] = true,
}
function NOP:UI_ERROR_MESSAGE(event, msgType, msg, ...) -- handle lockpicking item could be already unlocked or still locked and can't be used yet.
  if (msg == ERR_ITEM_LOCKED) and not self:inCombat() then -- replace action on button
    UIErrorsFrame:Clear()
    local bt = self.BF
    if bt and self:ItemToPicklock(bt.itemID) then
      bt.mtext = format(MACRO_PICKLOCK,self.pickLockSpell,bt.bagID,bt.slotID)
      bt:SetAttribute("type1", "macro")
      bt:SetAttribute("macrotext1", bt.mtext)
    end
    return
  end
  if OK_ERROR_NEXT[msg] then -- someone bashing button or item did move in bags
    UIErrorsFrame:Clear() -- remove error from error frame
    self:BAG_UPDATE() -- look for another item
    return
  end
  if OK_ERROR_SHOW[msg] then -- these errors are ok, item is on CD or can't be used in current state
    return
  end
  if self.preClick and NOP.AceDB.profile.SkipOnError then -- something with button went wrong, lets temporary blacklist it
    print(msg)
    UIErrorsFrame:Clear()
    self:BlacklistItem(false,self.BF.itemID)
    return
  end
  --print("Type",msgType,"Msg",P.RGB_RED .. msg .. "|r")
end
function NOP:LOOT_SPEC() -- after spec or loot spec switch I need update all paterns!
  wipe(T_RECIPES_FIND)
  wipe(T_SPELL_FIND)
  self.spellLoad = nil
  self.itemLoad = nil
  self:SpellLoad()
  self:ItemLoad()
  self:PickLockUpdate() -- picklock skills
  self:TimerFire('ItemShowNew', TIMER_IDLE)
end
function NOP:BAG_UPDATE() -- bags have changed
  self:TimerFire('ItemShowNew', TIMER_IDLE)
end
NOP.FACTION_TABLE = {} -- ["faction_name"] = factionID,
local tooltip_functions = {
  "SetBagItem", "SetItemByID", 
-- "SetQuestCurrency", "SetQuestLogItem", "SetQuestLogSpecialItem", "SetSendMailItem", "SetTradePlayerItem", "SetTradeTargetItem"
-- "SetCurrencyTokenByID", "SetGuildBankItem", "SetInboxItem", "SetInventoryItem",   
}
function NOP:PLAYER_LOGIN() -- player entering game
  if not NOP.AceDB.global.version or NOP.AceDB.global.version ~= NOP_VERSION then
    print("|cFFFF0000" .. NOP_TITLE .. " " .. NOP_VERSION)
    NOP.AceDB.global.version = NOP_VERSION
  end
  self.frameHiderB = CreateFrame("Frame", ADDON .. "_HiderB", UIParent, "SecureHandlerStateTemplate") -- State hide buttons in vehicle, petbattles and or combat
  self.frameHiderB:SetAllPoints(UIParent)
  RegisterStateDriver(self.frameHiderB, "visibility", string.format( "[petbattle] [vehicleui] %shide; show", NOP.AceDB.profile.HideInCombat and "[combat] " or ""))
  self.frameHiderQ = CreateFrame("Frame", ADDON .. "_HiderQ", UIParent, "SecureHandlerStateTemplate") -- State hide buttons in vehicle and petbattles
  self.frameHiderQ:SetAllPoints(UIParent)
  RegisterStateDriver(self.frameHiderQ, "visibility", "[petbattle] [vehicleui] hide; show")
  self:ButtonLoad() -- create button
  self:QBAnchor() -- create quest bar
  self:TimerFire('LOOT_SPEC', TIMER_IDLE)
  local key = GetBindingKey("CLICK " .. BUTTON_FRAME .. ":LeftButton")
  if self.BF.hotkey then self.BF.hotkey:SetText(self:ButtonHotKey(key)) end
  self:TimerFire("ZONE_CHANGED", TIMER_IDLE * 2)
  self:ScheduleRepeatingTimer("ItemTimer", TIMER_RECHECK) -- slow backing timer for complete rescan, sometime GetItemSpell get hang or new item is added post events are triggered
  if not self.tooltipHooked then
    self.tooltipHooked = true
    if NOP.AceDB.profile.ShowReputation then
      local thook = {"SetBagItem", "SetItemByID"}
      for _, func in pairs(thook) do
        hooksecurefunc(GameTooltip, func, 
          function(...)
            local tooltip, arg1, arg2, arg3, arg4 = ...
            if not tooltip then return end
            if not tooltip:IsVisible( ) then return end
            NOP:ButtonReputation(tooltip,func)
          end
        )
      end
    end
  end
end
function NOP:ZONE_CHANGED() -- map change, all items tied to zone need update
  self:Profile(true)
  local minimapZone, mapID = GetMinimapZoneText(), LIB_HEREBEDRAGONS:GetPlayerZone()
  if mapID and mapID ~= self.mapID then
    self.mapID = mapID
    wipe(T_CHECK) -- empty list, recheck all on new map
    wipe(T_USE)
  end
  if minimapZone and minimapZone ~= self.Zone then -- new zone need update Button
    self.Zone = minimapZone
  end
  self:Profile(false)
  self:TimerFire('ItemShowNew', TIMER_IDLE)
end
function NOP:PLAYER_LEVEL_UP() -- may be there are items now usable
  self:PickLockUpdate() -- new level rising picklock level
  wipe(T_CHECK) -- empty already checked items
  wipe(T_USE)
  self:BAG_UPDATE()
end
function NOP:QUEST_ACCEPTED() -- update quest bard buttons
  if not NOP.AceDB.profile.quest then return end -- quest bar is disabled and hidden nothing to do
  self:QBQuestAccept()
end
function NOP:PLAYER_ENTERING_WORLD() -- loading screen
  self:CheckBuilding(true) -- refresh garrison landing page as well
end
function NOP:ACTIONBAR_UPDATE_COOLDOWN() -- update cooldowns on quest bar and item button
  if self.QB and NOP.AceDB.profile.quest and not self.qbHidden then -- quest bar is not disabled or none and hidden nothing to do
    for _, bt in ipairs(self.QB.buttons) do -- quest bar buttons text cooldowns
      if bt:IsShown() and bt.itemID then 
        local start, duration, enable = GetItemCooldown(bt.itemID)
        self:ButtonOnUpdate(bt,start,duration)
      end
    end
  end
  local bt = self.BF -- item button
  if bt and bt.itemID and bt:IsShown() then
    local start, duration, enable = GetItemCooldown(bt.itemID) -- GetContainerItemCooldown(bt.bagID, bt.slotID)
    self:ButtonOnUpdate(bt,start,duration)
  end
end
function NOP:GARRISON_LANDINGPAGE_SHIPMENTS() -- print notifications into chat
  self:CheckBuilding()
end
function NOP:GET_ITEM_INFO_RECEIVED() -- ItemLoad and SpellLoad need cached items from server
  self:TimerFire("ItemLoad", TIMER_IDLE)
  self:TimerFire("SpellLoad", TIMER_IDLE)
end
