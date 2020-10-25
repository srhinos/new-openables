-- Constants and private data
local _
-- global functions and variebles to locals to keep LINT happy
local assert = _G.assert
local date = _G.date; assert(date ~= nil,'date')
local debugstack = _G.debugstack; assert(debugstack ~= nil,'debugstack')
local format = _G.format; assert(format ~= nil,'format')
local GetAddOnMetadata = _G.GetAddOnMetadata; assert(GetAddOnMetadata ~= nil,'GetAddOnMetadata')
local GetTime = _G.GetTime; assert(GetTime ~= nil,'GetTime')
local ipairs = _G.ipairs; assert(ipairs ~= nil,'ipairs')
local LibStub = _G.LibStub; assert(LibStub ~= nil,'LibStub')
local select = _G.select; assert(select ~= nil,'select')
local string = _G.string; assert(string ~= nil,'string')
local table = _G.table; assert(table ~= nil,'table')
local tonumber = _G.tonumber; assert(tonumber ~= nil,'tonumber')
local type = _G.type; assert(type ~= nil,'type')
local unpack = _G.unpack; assert(unpack ~= nil,'unpack')
local ITEM_SPELL_TRIGGER_ONUSE = _G.ITEM_SPELL_TRIGGER_ONUSE; assert(ITEM_SPELL_TRIGGER_ONUSE ~= nil,'ITEM_SPELL_TRIGGER_ONUSE')
local ITEM_OPENABLE = _G.ITEM_OPENABLE; assert(ITEM_OPENABLE ~= nil,'ITEM_OPENABLE')
-- local AddOn
local ADDON, P = ...
local NOP = LibStub("AceAddon-3.0"):NewAddon(ADDON,"AceConsole-3.0","AceEvent-3.0","AceTimer-3.0") -- load core libs
_G[ADDON] = NOP -- store reference to addon
NOP.private = P -- store reference to private store
--
local LIB_BABBLESUBZONE = LibStub("LibBabble-SubZone-3.0"); P.LIB_BABBLESUBZONE = LIB_BABBLESUBZONE -- Localized sub-zone names, need it for zone specific items.
local LIB_BABBLESUBZONE_has = LIB_BABBLESUBZONE:GetUnstrictLookupTable() -- all localized zone names
local LIB_HEREBEDRAGONS = LibStub("HereBeDragons-2.0",true); P.LIB_HEREBEDRAGONS = LIB_HEREBEDRAGONS -- MapID fetch 8.x and 7.x compatible
local LIB_MASQUE = LibStub("Masque", true); P.LIB_MASQUE = LIB_MASQUE -- Masque support
local LIB_QUESTITEM = LibStub("LibQuestItem-1.0", true); P.LIB_QUESTITEM = LIB_QUESTITEM -- Quest Items detection
--
P.VALIDATE = false -- validate tables after new patch
P.SALVAGE_YARD = LIB_BABBLESUBZONE_has["Salvage Yard"]
P.MINE_HORDE = LIB_BABBLESUBZONE_has["Frostwall Mine"]
P.MINE_ALLIANCE = LIB_BABBLESUBZONE_has["Lunarfall Excavation"]
P.SHIPYARD_HORDE = LIB_BABBLESUBZONE_has["Frostwall Shipyard"]
P.SHIPYARD_ALLIANCE = LIB_BABBLESUBZONE_has["Lunarfall Shipyard"]
for i=0,1 do
 P['TIMELESS_ISLE'..(i+1)] = 554 + i
end
for i=0,2 do
 P['FROSTWALL'..(i+1)] = 585 + i
 P['LUNARFALL'..(i+1)] = 579 + i
 P['SHADOWMOON_VALLEY'..(i+1)] = 539
end
P.FROSTWALL4 = 590
P.LUNARFALL4 = 582
for i=0,8 do
 P['FROSTFIRE_RIDGE'..(i+1)] = 525 + i
end
P.L = LibStub("AceLocale-3.0"):GetLocale(ADDON, false) -- get localized strings, don't print error if no locale is defined then default will be used
local L = P.L; assert(L ~= nil,'locale not defined')
P.NOP_TITLE = L["NOP_TITLE"]
P.NOP_VERSION = format(L["NOP_VERSION"],GetAddOnMetadata(ADDON, "Version") or "")
P.UNITID_PLAYER = "player"
P.UNITID_PET = "pet"
P.AURA_HELPFUL = "HELPFUL"
P.CONSOLE_CMD = "/nop"
P.CONSOLE_USAGE = L["CONSOLE_USAGE"]
P.MACRO_INACTIVE = "/stopcasting"
P.MACRO_ACTIVE = "/use item:%d" -- "%s/use %d %d"
P.MACRO_PICKLOCK = "/use %s\n/use %d %d" -- Picklock targeted at bags position only works, because there could be locked and unlocked items in bags
P.DEFAULT_ICON = "Interface\\Icons\\inv_crate_01" -- Supply Crate
P.DEFAULT_ITEMID = 4629 -- Supply Crate
P.QUEST_ICON = "Interface\\MINIMAP\\ObjectIcons"
P.ICON_TEXT = "NumberFontNormal"
P.DEFAULT_ICON_SIZE = 35
P.CLICK_DRAG_MSG = L["CLICK_DRAG_MSG"]
P.CLICK_SKIP_MSG = L["CLICK_SKIP_MSG"]
P.CLICK_OPEN_MSG = L["CLICK_OPEN_MSG"]
P.CLICK_BLACKLIST_MSG = L["CLICK_BLACKLIST_MSG"]
P.BUTTON_FRAME = ADDON.."_BUTTON"
P.QB_NAME = ADDON.."_QB_"
P.TOOLTIP_ITEM = ADDON.."_TOOLTIP_ITEM"
P.TOOLTIP_SPELL = ADDON.."_TOOLTIP_SPELL"
P.TOOLTIP_SCAN = ADDON.."_TOOLTIP_SCAN"
P.SPELL_PICKLOCK = 1804
P.AURA_MINERS_COFFEE = 176049 -- applied by Miner's cofee item could have 5 stacks past 6.1 wow version
P.RO_SHIPYARD = 128373 -- Rush Orders: Shipyards in Garrison always get lower priority
P.CB_CVAR = "colorblindMode"
P.ITEM_TYPE_BATTLE_PET = "battlepet"
P.ITEM_TYPE_ITEM = "item"
P.RGB_YELLOW = "|cFFFFFF00"
P.RGB_RED = "|cFFFF0000"
P.RGB_MAGENTA = "|cFF00FFFF"
P.RGB_NORMAL = "|r"
P.TIMER_IDLE = 1.0 -- recheck delay for calling protected function in combat
P.TIMER_RECHECK = 20.0 -- delay for slow non-event driven item lookup in bags
P.PRINT_HEAD = "|cff7f7f7f%s|r [|cff00ffff%s|r]"
P.BLACKLIST = {[90043] = true,} -- special blacklist
P.MOUSE_LB = "\124TInterface\\TutorialFrame\\UI-Tutorial-Frame:12:12:0:0:512:512:10:65:228:283\124t" -- left mouse button
P.MOUSE_RB = "\124TInterface\\TutorialFrame\\UI-Tutorial-Frame:12:12:0:0:512:512:10:65:330:385\124t" -- right mouse button
P.WORK_ANNOUNCE = 0.4 -- 40% and more done is reported
P.TOGO_ANNOUNCE = L["TOGO_ANNOUNCE"]
P.REWARD_ANNOUNCE = L["REWARD_ANNOUNCE"]
P.SHIPYARD_ANNOUNCE = L["SHIPYARD_ANNOUNCE"]
P.ARTIFACT_ANNOUNCE = L["ARTIFACT_ANNOUNCE"]
P.ARCHAELOGY_ANNOUNCE = L["ARCHAELOGY_ANNOUNCE"]
P.TALENT_ANNOUNCE = L["TALENT_ANNOUNCE"]
P.PRI_POPUP =  1 -- highlit item
P.PRI_OPEN  =  2 -- open boxes, top priority
P.PRI_POWER =  3 -- power
P.PRI_TOKEN =  4 -- tokens, tribute
P.PRI_REP   =  5 -- reputation tokens
P.PRI_REST  =  6 -- all remaining items
P.PRI_SKIP  = 10 -- all other locked items get this to theirs priority
P.T_BAGS = {} -- bags cache
P.T_PICK = {} -- lockpicking cache
P.T_SPELL_FIND = {} -- ["spell"] = {count_to_use,priority}
P.T_RECIPES_FIND = {} --  [itemID] = {{count_to_use,priority},"pattern",{"sub-ZoneName","sub-ZoneName"},{[mapID]=true,[mapID]=true}} it will be filled with paterns
P.T_OPEN = { -- ["tooltip-string"] = {{count_to_use,priority},{"sub-ZoneName","sub-ZoneName"},{[mapID]=true,[mapID]=true}}, items by open-spell in tooltip
  [format("%s %s",ITEM_SPELL_TRIGGER_ONUSE,ITEM_OPENABLE)] = {{1,P.PRI_OPEN},nil,nil}, -- standard right click open
  [ITEM_OPENABLE] = {{1,P.PRI_OPEN},nil,nil}, -- standard right click open
}
P.T_BLACKLIST = {} -- [itemID] = true, items blacklisted from right-click
P.T_BLACKLIST_Q = {} -- [itemID] = true, items blacklisted from right-click
P.T_USE = {} -- [itemID] = {{count_to_use,priority},{"sub-zone",...},{[mapID]=true,...},aura,stamp,count_in_bags} /run foreach(T_USE,print)
P.T_CHECK = {} -- already checked items [itemID] = true
P.T_REPS = {} -- [item.name] = factionID, item names and factionID hash table to show them in tooltip
--
function P.print(...) -- add time-stamp and addon name to output
  local ElvUI = _G.ElvUI
  _G.print((P.PRINT_HEAD):format(ElvUI and "" or ("[" .. date("%H:%M") .. "]"),ADDON),...)
end
local print = P.print -- replace build-in function from now
function P.whoCalls(msg) -- show callstack
  local s = debugstack (2,5,0)
  if (s == nil) then s = debugstack (1,5,0) end
  if (type(s) == 'string') then
    if msg then print(msg) end
    print('---- debug stack, please report to author ----')
    local stack = { string.split("\n", s) }
    for n, v in ipairs(stack) do
      local lineNo = string.match(v,":(%d*):")
      local fileName = string.match(v,".*\\(.*)[.]lua:")
      local funcName = string.match(v,"in function .(.*).")
      if fileName then
        if funcName and (string.find(funcName,':') or string.find(funcName,'?')) then funcName = nil end
        print(('%s:%d %s()'):format(fileName, tonumber(lineNo) or -1, funcName or "nofunc"))
      end
    end
  end
end
