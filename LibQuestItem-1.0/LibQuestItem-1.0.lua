local MAJOR, MINOR = "LibQuestItem-1.0", tonumber("27") or 999 -- ES increased version to take over all older instances
local LibQuestItem = LibStub:NewLibrary(MAJOR, MINOR)

if not LibQuestItem then return end -- no need to update

LibQuestItem.callbacks = LibQuestItem.callbacks or LibStub("CallbackHandler-1.0"):New(LibQuestItem)
local callbacks = LibQuestItem.callbacks

-- -----
-- local upvalues
-- -----
local _G = getfenv(0)

local ipairs = _G.ipairs
local pairs = _G.pairs
local select = _G.select
local tonumber	= _G.tonumber
local tostring	= _G.tostring

local GetContaineritemId = _G.GetContaineritemId
local GetContainerNumSlots = _G.GetContainerNumSlots
local GetInventoryitemId = _G.GetInventoryitemId
local GetInventorySlotInfo = _G.GetInventorySlotInfo
local GetItemInfo = _G.GetItemInfo

local strformat	= _G.string.format
local strlen = _G.string.len

-- -----
-- lib variables
-- -----
LibQuestItem.frame = LibQuestItem.frame	or CreateFrame("Frame", "LibQuestItem10Frame") -- our event frame

-- -----
-- localization
-- -----
local LOCALE_QUEST = ((_G.GetItemClassInfo == nil) and select(10, GetAuctionItemClasses())) or _G.GetItemClassInfo(LE_ITEM_CLASS_QUESTITEM) or "Quest" -- ES legion aware fix

-- -----
-- local helpers
-- -----
local PATTERN_itemid = "item:(%-?%d+).+" -- ES legion ware fix removed :%-?%d+:%-?%d+:%-?%d+:%-?%d+:%-?%d+:%-?%d+:%-?%d+:%-?%d+"
local PATTERN_itemlink = "|c%x+|H"..PATTERN_itemid.."|h%[.-%]|h|r"
local FORMAT_itemid = "item:%d:0:0:0:0:0:0:0"
local questItemsNeededPattern = "(.+): (%d+)/(%d+)" -- string.gsub(string.gsub(QUEST_ITEMS_NEEDED, "(%%s)", "(.+)"), "(%%d)", "(%%d+)")

local questItems = {}
local usableQuestItems = {}
local startsQuestItems = {}
local activeQuestItems = {}
local questItemSpells = {}
local questItemText = {}

local bagIds = { KEYRING_CONTAINER, 0, 1, 2, 3, 4 }

local inventorySlots = {
	(GetInventorySlotInfo("HeadSlot")),
	(GetInventorySlotInfo("NeckSlot")),
	(GetInventorySlotInfo("ShoulderSlot")),
	(GetInventorySlotInfo("BackSlot")),
	(GetInventorySlotInfo("ChestSlot")),
	(GetInventorySlotInfo("ShirtSlot")),
	(GetInventorySlotInfo("TabardSlot")),
	(GetInventorySlotInfo("WristSlot")),
	(GetInventorySlotInfo("HandsSlot")),
	(GetInventorySlotInfo("WaistSlot")),
	(GetInventorySlotInfo("LegsSlot")),
	(GetInventorySlotInfo("FeetSlot")),
	(GetInventorySlotInfo("Finger0Slot")),
	(GetInventorySlotInfo("Finger1Slot")),
	(GetInventorySlotInfo("Trinket0Slot")),
	(GetInventorySlotInfo("Trinket1Slot")),
	(GetInventorySlotInfo("MainHandSlot")),
	(GetInventorySlotInfo("SecondaryHandSlot")),
	(GetInventorySlotInfo("Bag0Slot")),
	(GetInventorySlotInfo("Bag1Slot")),
	(GetInventorySlotInfo("Bag2Slot")),
	(GetInventorySlotInfo("Bag3Slot")),
}

-- -----
-- local functions
-- -----
local function getbaseid(link)
	if link then
		if type(link) == "number" then return link end
		local baseid = strmatch(link, PATTERN_itemlink)
		if not baseid then
			baseid = strmatch(link, PATTERN_itemid)
		end
		if not baseid then
			baseid = link
		end
		return tonumber(baseid)
	end
	return
end

local function IsQuestItem(itemId)
	local itemType, itemSubType = select(6, GetItemInfo(itemId))
	return (itemType == LOCALE_QUEST or itemSubType == LOCALE_QUEST)
end


local ToolTipForMining = _G.CreateFrame("GameTooltip", "LQIToolTip", UIParent, "GameTooltipTemplate")
local function IsStartQuestItemCheckTooltipText(itemId)
	_G.GameTooltip_SetDefaultAnchor(ToolTipForMining, _G.UIParent)
	
	local itemLink = string.format(FORMAT_itemid, itemId)
	ToolTipForMining:SetHyperlink(itemLink)
	
	for i = 1, ToolTipForMining:NumLines() do
		if ( _G["LQIToolTipTextLeft" .. i]:GetText() or "" ):match(ITEM_STARTS_QUEST) then
			ToolTipForMining:Hide()
			return true
		end
	end
	
	ToolTipForMining:Hide()
	return false
end

local function IsUsableItem(itemId)
	local itemSpell = GetItemSpell(itemId)
	return itemSpell and (strlen(itemSpell) > 0)
end

local function ScanBags()
	for _, bagid in ipairs(bagIds) do
		local size = GetContainerNumSlots(bagid)
		if size then
			for slotid = 1, size do
				local itemId = GetContainerItemID(bagid, slotid)
				local isQuestItem, questId, isActive = GetContainerItemQuestInfo(bagid, slotid)
				
				if itemId and (isQuestItem or IsQuestItem(itemId)) then
					questItems[itemId] = true
					--Usable?
					local itemSpell = GetItemSpell(itemId)
					if questId or itemSpell then
						usableQuestItems[itemId] = itemSpell or true
						if itemSpell then
							questItemSpells[itemSpell] = itemId
						end
					end					
					startsQuestItems[itemId] = questId
					activeQuestItems[itemId] = isActive
				end
				
				--Check Tooltip for quest starting items
				if itemId and not questItems[itemId] then 
					if IsStartQuestItemCheckTooltipText(itemId) then
						questItems[itemId] = true
						usableQuestItems[itemId] = true
						startsQuestItems[itemId] = true
					end
				end
			end
		end
	end
end

local function ScanInventory()
	for _, slot in ipairs(inventorySlots) do
		local itemId = GetInventoryItemID("player", slot)
		if itemId and IsQuestItem(itemId) then
			questItems[itemId] = true
			usableQuestItems[itemId] = IsUsableItem(itemId)
		end
	end
end

local function ScanQuestLog()	
	for questIndex = 1, C_QuestLog.GetNumQuestLogEntries() do
		--Special/usable items
		local itemLink = GetQuestLogSpecialItemInfo(questIndex)
		if itemLink then
			local itemId = getbaseid(itemLink)
			questItems[itemId] = true
			usableQuestItems[itemId] = GetItemSpell(itemId) or true
			activeQuestItems[itemId] = true
			questItemText[itemId] = C_QuestLog.GetInfo(questIndex)
      questItemText[itemId] = questItemText[itemId][title]
		end
		
		--Required items (to complete quest). The player may not actually have this item (yet).
		for leaderIndex = 1, GetNumQuestLeaderBoards(questIndex) do
			local objectiveText, type, finished = GetQuestLogLeaderBoard(leaderIndex, questIndex)
			if type == "item" then
				local itemName, completed, total = string.match(objectiveText, questItemsNeededPattern)
				if itemName then
					--print(("%s - %s - %s"):format(itemName, completed, total), GetItemInfo(itemName))
					local itemLink = select(2, GetItemInfo(itemName))
					if itemLink then
						local itemId = getbaseid(itemLink)
						local questName = GetQuestLogTitle(questIndex)
						questItemText[itemId] = questName .. " - " .. objectiveText
					end
				end
			end
		end
	end
end

-- -----
-- public API
-- -----
LibQuestItem.questItems = questItems
LibQuestItem.usableQuestItems = usableQuestItems
LibQuestItem.startsQuestItems = startsQuestItems
LibQuestItem.activeQuestItems = activeQuestItems
LibQuestItem.questItemSpells = questItemSpells
LibQuestItem.questItemText = questItemText

function LibQuestItem:Scan()
	itemScanNeeded = false
	
	wipe(questItems)
	wipe(usableQuestItems)
	wipe(startsQuestItems)
	wipe(activeQuestItems)
	wipe(questItemSpells)
	wipe(questItemText)

	ScanInventory()
	ScanBags()
	ScanQuestLog()
	
	callbacks:Fire("LibQuestItem_Update")
end

function LibQuestItem:GetItemString(itemId)
	return strformat(FORMAT_itemid, itemId)
end

function LibQuestItem:IsQuestItem(itemId)
	return LibQuestItem.questItems[itemId]
end

function LibQuestItem:IsUsable(itemId)
	return usableQuestItems[itemId]
end

function LibQuestItem:StartsQuestId(itemId)
	return startsQuestItems[itemId]
end

function LibQuestItem:IsQuestActive(itemId)
	return activeQuestItems[itemId]
end

-- -----
-- OnEvent and OnUpdate handlers / event registering
-- -----
local eventmap = {
	["BAG_UPDATE"] = "ITEMS_UPDATED",
	["UNIT_INVENTORY_CHANGED"] = "ITEMS_UPDATED",
	
	["PLAYER_ENTERING_WORLD"] = "PLAYER_ENTERING_WORLD",
	["PLAYER_LEAVING_WORLD"] = "PLAYER_LEAVING_WORLD",
	["PLAYER_REGEN_ENABLED"] = "PLAYER_REGEN_ENABLED",
	["PLAYER_REGEN_DISABLED"] = "PLAYER_REGEN_DISABLED",
}

LibQuestItem.frame:SetScript("OnEvent", function(self, event, ...)
	local eventfunc = eventmap[event]
	if eventfunc then
		LibQuestItem[eventfunc](LibQuestItem, ...)
	end
end)

for event in pairs(eventmap) do
	LibQuestItem.frame:RegisterEvent(event)
end

local total_elapsed = 0
LibQuestItem.frame:SetScript("OnUpdate", function(self, elapsed)
	total_elapsed = total_elapsed + elapsed
	if total_elapsed < 1 then return end
	total_elapsed = 0
	if itemScanNeeded and not InCombatLockdown() then
		LibQuestItem:Scan()
	end
	LibQuestItem.frame:Hide()
end)

-- -----
-- event functions
-- -----
function LibQuestItem:ITEMS_UPDATED()
	itemScanNeeded = true
	LibQuestItem.frame:Show()
end

function LibQuestItem:PLAYER_ENTERING_WORLD()
	itemScanNeeded = true
	LibQuestItem.frame:Show()
end

function LibQuestItem:PLAYER_LEAVING_WORLD()
	LibQuestItem.frame:Hide()
end

function LibQuestItem:PLAYER_REGEN_ENABLED()
	LibQuestItem.frame:Show()
end

function LibQuestItem:PLAYER_REGEN_DISABLED()
	LibQuestItem.frame:Hide()
end