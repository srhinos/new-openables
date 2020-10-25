-- English localization file for enUS and enGB.
local _
-- global functions and variebles to locals to keep LINT happy
local assert = _G.assert
local LibStub = _G.LibStub; assert(LibStub ~= nil,'LibStub')
-- local AddOn
local ADDON = ...
local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local L = AceLocale:NewLocale(ADDON, "enUS", true, false); -- default translation, not silent load
if not L then return; end
--
L["NOP_TITLE"] = "New Openables"
L["NOP_VERSION"] = "|cFFFFFFFF%s use |cFFFF00FF/nop|cFFFFFFFF"
L["CLICK_DRAG_MSG"] = "ALT-LeftClick and drag to move."
L["CLICK_OPEN_MSG"] = "LeftClick to open or use."
L["CLICK_SKIP_MSG"] = "RightClick to skip item."
L["CLICK_BLACKLIST_MSG"] = "CTRL-RightClick to blacklist item."
L["No openable items!"] = true
L["BUTTON_RESET"] = "Reset and move button to middle of screen!"
L["NOP_USE"] = "Use: "
L["Spell:"] = true
L["BLACKLISTED_ITEMS"] = "|cFFFF00FFPermanently blacklisted items:"
L["BLACKLIST_EMPTY"] = "|cFFFF00FFPermanent blacklist is empty"
L["PERMA_BLACKLIST"] = "Permanently Blacklisted:|cFF00FF00"
L["SESSION_BLACKLIST"] = "Session Blacklisted:|cFF00FF00"
L["TEMP_BLACKLIST"] = "Temporary Blacklisted:|cFF00FF00"
L["|cFFFF0000Error loading tooltip for|r "] = true
L["Plans, patterns and recipes cache update."] = true
L["Spell patterns cache update."] = true
L["|cFFFF0000Error loading tooltip for spell |r "] = true
L["|cFFFF0000Error loading tooltip for spellID %d"] = true
L["TOGGLE"] = "Toggle"
L["Skin Button"] = true
L["Masque Enable"] = true
L["Need UI reload or relogin to activate."] = true
L["Lock Button"] = true
L["Lock button in place to disbale drag."] = true
L["Glow Button"] = true
L["When item is placed by zone change, button will have glow effect."] = true
L["Backdrop Button"] = true
L["Create or remove backdrop around button, need reload UI."] = true
L["Session skip"] = true
L["Skipping item last until relog."] = true
L["Clear Blacklist"] = true
L["Reset Permanent blacklist."] = true
L["Zone unlock"] = true
L["Don't zone restrict openable items"] = true
L["Profession"] = true
L["Place items usable by lockpicking"] = true
L["Button"] = true
L["Buttom location"] = true
L["Button size"] = true
L["Width and Height"] = true
L["Button size in pixels"] = true
L["Miner's Coffee stacks"] = true
L["Allow buff up to this number of stacks"] = true
L["Quest bar"] = true
L["Quest items placed on bar"] = true
L["Visible"] = true
L["Make button visible by placing fake item on it"] = true
L["Swap"] = true
L["Swap location of numbers for count and cooldown timer"] = true
L["AutoQuest"]  = true
L["Auto accept or hand out quests from AutoQuestPopupTracker!"] = true
L["Strata"] = true
L["Set strata for items button to HIGH, place it over normal windows."] = true
L["Herald"] = true
L["Announce completed work orders, artifact points etc.."] = true
L["Skip on Error"] = true
L["Temporary blacklist item when click produce error message"] = true
L["HIDE_IN_COMBAT"] = "Hide in combat"
L["HIDE_IN_COMBAT_HELP"] = "Hide items button when in combat"
L["SHOW_REPUTATION"] = "Show reputation"
L["SHOW_REPUTATION_HELP"] = "Show Legion reputation standing in tooltip for reputation token items. Activate/Deactivate need game client reload."
L["SKIP_EXALTED"] = "Skip exalted"
L["SKIP_EXALTED_HELP"] = "Don't use Legion reputation tokens when already exalted."
L["SKIP_MAXPOWER"] = "Skip artifact"
L["SKIP_MAXPOWER_HELP"] = "Skip artifact power tokens when artifact have maximum traits."
L["Buttons per row"] = true
L["Number of buttons placed in one row"] = true
L["Spacing"] = true
L["Space between buttons"] = true
L["Sticky"] = true
L["Anchor to Item button"] = true
L["Direction"] = true
L["Expand bar to"] = true
L["Up"] = true
L["Down"] = true
L["Left"] = true
L["Right"] = true
L["Add new row"] = true
L["Above or below last one"] = true
L["Hot-Key"] = true
L["Key to use for automatic key binding."] = true
L["Quest"] = true
L["Quest not found for this item."] = true
L["Items cache update run |cFF00FF00%d."] = true
L["Spells cache update run |cFF00FF00%d."] = true
L["TOGO_ANNOUNCE"] = "%s: %d done %d to go!"
L["REWARD_ANNOUNCE"] = "Paragon reward for %s is ready!"
L["SHIPYARD_ANNOUNCE"] = "Shipyard have %d/%d ships!"
L["ARTIFACT_ANNOUNCE"] = "%s have %d traits ready!"
L["ARCHAELOGY_ANNOUNCE"] = "Archaeology %s is ready!"
L["TALENT_ANNOUNCE"] = "%s is ready!"
L["RESTARTED_LOOKUP"] = "Temporary blacklist cleared, restarting lookup!"
L["CONSOLE_USAGE"] = [=[ [reset|skin|lock|clear|list|unlist|skip|glow|zone|quest|show]
reset  - will reset button position to middle of screen
skin   - will toggle skin of button
lock   - will lock/unlock button in place
clear  - will reset Permanent blacklist
list   - list Permanently blacklisted items
unlist - remove single item from blacklist based on itemID
skip   - toggle right click skip temporary or until relog
glow   - toggle button glow on zone items
zone   - toggle zone restriction on items
quest  - toggle quest bar
show   - visible empty button]=];
