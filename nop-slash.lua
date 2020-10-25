-- Slash handler and key-binding header
local _
-- global functions and variebles to locals to keep LINT happy
local assert = _G.assert
local LibStub = _G.LibStub; assert(LibStub ~= nil,'LibStub')
local BACKPACK_CONTAINER = _G.BACKPACK_CONTAINER; assert(BACKPACK_CONTAINER ~= nil,'BACKPACK_CONTAINER')
local format = _G.format; assert(format ~= nil,'format')
local GetAddOnMemoryUsage = _G.GetAddOnMemoryUsage; assert(GetAddOnMemoryUsage ~= nil,'GetAddOnMemoryUsage')
local GetContainerItemID = _G.GetContainerItemID; assert(GetContainerItemID ~= nil,'GetContainerItemID')
local GetContainerItemLink = _G.GetContainerItemLink; assert(GetContainerItemLink ~= nil,'GetContainerItemLink')
local GetContainerNumSlots = _G.GetContainerNumSlots; assert(GetContainerNumSlots ~= nil,'GetContainerNumSlots')
local GetItemInfo = _G.GetItemInfo; assert(GetItemInfo ~= nil,'GetItemInfo')
local GetSpellInfo = _G.GetSpellInfo; assert(GetSpellInfo ~= nil,'GetSpellInfo')
local GetTime = _G.GetTime; assert(GetTime ~= nil,'GetTime')
local issecurevariable = _G.issecurevariable; assert(issecurevariable ~= nil,'issecurevariable')
local math = _G.math; assert(math ~= nil,'math')
local NUM_BAG_SLOTS = _G.NUM_BAG_SLOTS; assert(NUM_BAG_SLOTS ~= nil,'NUM_BAG_SLOTS')
local pairs = _G.pairs; assert(pairs ~= nil,'pairs')
local string = _G.string; assert(string ~= nil,'string')
local tonumber = _G.tonumber; assert(tonumber ~= nil,'tonumber')
local UpdateAddOnMemoryUsage = _G.UpdateAddOnMemoryUsage; assert(UpdateAddOnMemoryUsage ~= nil,'UpdateAddOnMemoryUsage')
-- local AddOn
local ADDON, P = ...
local NOP = LibStub("AceAddon-3.0"):GetAddon(ADDON)
--
local T_CHECK = P.T_CHECK; assert(T_CHECK ~= nil,'T_CHECK')
local print = P.print; assert(print ~= nil,'print')
--
NOP.slash_handler = function(msg, editbox) -- /nop handler
  local line = msg:lower()
  local cmd, arg = string.split(" ,",line)
  if cmd == "bdump" then
    for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS, 1 do
      for slot = 1, GetContainerNumSlots(bag), 1 do
        local link = GetContainerItemLink(bag, slot)
        if link then
          local _, _, itemColor, itemType, itemID = string.find(link, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):")
          print("Bag",bag,"Slot",slot,"Link",itemType or "unknow type",itemID or "unknown ID")
        end
      end
    end
    return
  end
  if cmd == "verbose" then
    NOP.AceDB.profile.verbose = not NOP.AceDB.profile.verbose
    print("Verbose mode", NOP.AceDB.profile.verbose and "on" or "off")
    return
  end
  if cmd == "titem" then
    local id = tonumber(arg)
    if id then
      for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS, 1 do
        for slot = 1, GetContainerNumSlots(bag), 1 do
          local itemID = GetContainerItemID(bag,slot)
          if itemID and itemID == id then -- when I own item just check true tooltip over bags
            print("Tooltip based on item in bag",bag,"slot",slot)
            NOP.itemFrame:ClearLines()
            NOP.itemFrame:SetBagItem(bag, slot)
            NOP:PrintTooltip(NOP.itemFrame)
            return
          end
        end
      end
      local name = GetItemInfo(id)
      if not name then
        print("Item ID",id,"is not in cache yet! Try same ID later")
        return
      end
      print("Tooltip based only on ID")
      NOP.itemFrame:ClearLines()
      NOP.itemFrame:SetItemByID(id)
      NOP:PrintTooltip(NOP.itemFrame)
    end
    return
  end
  if cmd == "tspell" then
    local id = tonumber(arg)
    if id then
      local name = GetSpellInfo(id)
      if not name then
        print("Spell ID",id,"is not in cache yet! Try same ID later")
        return
      end
      NOP.spellFrame:ClearLines()
      NOP.spellFrame:SetSpellByID(id)
      NOP:PrintTooltip(NOP.spellFrame)
    end
    return
  end
  if cmd == "profile" then
    if NOP.profileSession and NOP.profileCount and NOP.profileTotal and NOP.profileMaxRun and NOP.profileCount > 0 then
      local Elapsed = GetTime() - NOP.profileSession
      local textTime = (" %dh %02dm %02ds "):format(Elapsed / 3600, math.fmod(Elapsed / 60, 60), math.fmod(Elapsed, 60))
      print(format("%s session time %d [calls] spend %.2f [ms/call] max run %.2f [ms]", textTime, NOP.profileCount, NOP.profileTotal / NOP.profileCount, NOP.profileMaxRun))
    end
    UpdateAddOnMemoryUsage()
    print(format("Memory usage %.2f kB",GetAddOnMemoryUsage(ADDON)))
    if NOP.BF then
      local secure,addon = issecurevariable(NOP.BF,"Hide")
      if not secure then print("Tainted button Hide() by:",addon) end
      secure,addon = issecurevariable(NOP.BF,"Show")
      if not secure then print("Tainted button Show() by:",addon) end
      secure,addon = issecurevariable(NOP.BF,"SetAttribute")
      if not secure then print("Tainted button SetAttribute() by:",addon) end
    end
    if NOP.profileOn then -- toggle profiling
      NOP.profileOn = nil
      NOP.profileSession = nil
      NOP.profileCount = nil 
      NOP.profileTotal = nil
      print("Profiling OFF")
    else
      NOP.profileOn = true
      NOP.profileSession = nil
      NOP.profileCount = nil 
      NOP.profileTotal = nil
      print("Profiling ON")
    end
    NOP.AceDB.profile["profiling"] = NOP.profileOn
    return
  end
  if cmd == "reset" then
    if NOP.BF and not NOP:inCombat() then
      NOP:ButtonReset()
    end
    return
  end
  if cmd == "skin" then
    NOP.AceDB.profile["skinButton"] = (not NOP.AceDB.profile.skinButton)
    NOP:ButtonLoad()
    NOP:QBSkin()
    return
  end
  if cmd == "quest" then
    NOP.AceDB.profile["quest"] = not NOP.AceDB.profile.quest
    NOP:QBUpdate()
    return
  end
  if cmd == "show" then
    NOP.AceDB.profile["visible"] = not NOP.AceDB.profile.visible
    NOP:BAG_UPDATE()
    NOP:QBUpdate()
    return
  end
  if cmd == "lock" then
    NOP.AceDB.profile["lockButton"] = (not NOP.AceDB.profile.lockButton)
    return
  end
  if cmd == "glow" then
    NOP.AceDB.profile["glowButton"] = (not NOP.AceDB.profile.glowButton)
    return
  end
  if cmd == "skip" then
    NOP.AceDB.profile["Skip"] = (not NOP.AceDB.profile.Skip)
    if NOP:BlacklistClear() then NOP:BAG_UPDATE() end
    return
  end
  if cmd == "clear" then
    NOP:BlacklistReset()
    return
  end
  if cmd == "list" then
    if (NOP.AceDB.profile["T_BLACKLIST"] ~= nil and NOP.AceDB.profile.T_BLACKLIST[0]) or (NOP.AceDB.profile["T_BLACKLIST_Q"] ~= nil and NOP.AceDB.profile.T_BLACKLIST_Q[0])then
      print(P.L["BLACKLISTED_ITEMS"])
      print("--Button--")
      for itemID,count in pairs(NOP.AceDB.profile.T_BLACKLIST) do
        if itemID and itemID > 0 then
          local name = GetItemInfo(itemID)
          if not name then
            print("ItemID:",itemID,"Not in cache, try later same command to see name.")
          else
            print("ItemID:",itemID,"Name:",name)
          end
        end
      end
      print("--Quest--")
      for itemID,count in pairs(NOP.AceDB.profile.T_BLACKLIST_Q) do
        if itemID and itemID > 0 then
          local name = GetItemInfo(itemID)
          if not name then
            print("ItemID:",itemID,"Not in cache, try later same command to see name.")
          else
            print("ItemID:",itemID,"Name:",name)
          end
        end
      end
    else
      print(P.L["BLACKLIST_EMPTY"])
    end
    return
  end
  if cmd == "unlist" then
    local id = tonumber(arg)
    if id then
      if NOP.AceDB.profile["T_BLACKLIST"] ~= nil and NOP.AceDB.profile.T_BLACKLIST[id] then NOP.AceDB.profile.T_BLACKLIST[id] = nil; T_CHECK[id] = nil; NOP:BAG_UPDATE() end
      if NOP.AceDB.profile["T_BLACKLIST_Q"] ~= nil and NOP.AceDB.profile.T_BLACKLIST_Q[id] then NOP.AceDB.profile.T_BLACKLIST_Q[id] = nil; NOP:QBUpdate() end
    end
    return
  end
  if cmd == "zone" then
    NOP.AceDB.profile["zoneUnlock"] = not NOP.AceDB.profile.zoneUnlock
    NOP:BAG_UPDATE()
    return
  end
  local usage = {string.split("\n", P.L["NOP_USE"] .. P.CONSOLE_CMD .. P.CONSOLE_USAGE)}
  for _,line in pairs(usage) do 
    print(line)
  end
end
_G.SLASH_NOP_SWITCH1 = P.CONSOLE_CMD
_G.SlashCmdList["NOP_SWITCH"] = NOP.slash_handler
_G.BINDING_HEADER_NEWOPENABLES = ADDON -- add category to bindings to be able bind button to hotkey in default Blizzard interface
_G["BINDING_NAME_CLICK " .. P.BUTTON_FRAME .. ":LeftButton"] = _G.USABLE_ITEMS
