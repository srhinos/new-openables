-- Chinese Traditional localization file for zhTW. by BNSSNB and rest by Google translator
local _
-- global functions and variebles to locals to keep LINT happy
local assert = _G.assert
local LibStub = _G.LibStub; assert(LibStub ~= nil,'LibStub')
-- local AddOn
local ADDON = ...
local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local L = AceLocale:NewLocale(ADDON, "zhTW");
if not L then return end
--
L["NOP_TITLE"] = "New Openables"
L["NOP_VERSION"] = "|cFFFFFFFF%s 使用 |cFFFF00FF/nop|cFFFFFFFF"
L["CLICK_DRAG_MSG"] = "ALT-左鍵點擊拖曳移動。"
L["CLICK_OPEN_MSG"] = "左鍵點擊開啟或使用。"
L["CLICK_SKIP_MSG"] = "右鍵點擊略過物品"
L["CLICK_BLACKLIST_MSG"] = "CTRL-右鍵點擊到黑名單物品。"
L["No openable items!"] = "沒有可開啟物品!"
L["BUTTON_RESET"] = "重置並移動按鈕到螢幕中間!"
L["NOP_USE"] = "使用:"
L["Spell:"] = "施法:"
L["BLACKLISTED_ITEMS"] = "|cFFFF00FF永遠黑名單物品:"
L["BLACKLIST_EMPTY"] = "|cFFFF00FF永遠黑名單是空的"
L["PERMA_BLACKLIST"] = "永遠黑名單:|cFF00FF00"
L["SESSION_BLACKLIST"] = "本次上線黑名單:|cFF00FF00"
L["TEMP_BLACKLIST"] = "臨時黑名單:|cFF00FF00"
L["|cFFFF0000Error loading tooltip for|r "] = "|cFFFF0000錯誤載入提示|r "
L["Plans, patterns and recipes cache update."] = "計畫、圖案和配方快取更新。"
L["Spell patterns cache update."] = "施法圖案快取更新。"
L["|cFFFF0000Error loading tooltip for spell |r "] = "|cFFFF0000法術錯誤載入提示 |r "
L["|cFFFF0000Error loading tooltip for spellID %d"] = "|cFFFF0000%d 法術ID錯誤載入提示"
L["TOGGLE"] = "切換"
L["Skin Button"] = "皮膚按鈕"
L["Masque Enable"] = "Masque 啟用"
L["Need UI reload or relogin to activate."] = "需要UI重新加載或重新登錄才能激活。"
L["Lock Button"] = "鎖定按鈕"
L["Lock button in place to disbale drag."] = "鎖定按鈕來禁用拖曳。"
L["Glow Button"] = "閃光按鈕"
L["When item is placed by zone change, button will have glow effect."] = "當物品根據區域改變來放置，按鈕將會有發光效果。"
L["Backdrop Button"] = "背景按鈕"
L["Create or remove backdrop around button, need reload UI."] = "創建或移除環繞按鈕的背景，需要重載UI。"
L["Session skip"] = "本次上線略過"
L["Skipping item last until relog."] = "略過物品直到重新登入。"
L["Clear Blacklist"] = "清空黑名單"
L["Reset Permanent blacklist."] = "重置永遠黑名單。"
L["Zone unlock"] = "區域解鎖"
L["Don't zone restrict openable items"] = "不要根據區域限制可開啟的物品"
L["Profession"] = "專業"
L["Place items usable by lockpicking"] = "根據開鎖放置可使用物品"
L["Button"] = "按鈕"
L["Buttom location"] = "按鈕位置"
L["Button size"] = "按鈕大小"
L["Width and Height"] = "寬和高"
L["Button size in pixels"] = "按鈕大小向素"
L["Miner's Coffee stacks"] = "礦工咖啡堆疊數"
L["Allow buff up to this number of stacks"] = "允許增益堆疊到此數字"
L["Quest bar"] = "任務條"
L["Quest items placed on bar"] = "任務物品放置在條上"
L["Visible"] = "可視的"
L["Make button visible by placing fake item on it"] = "透過放置假物品使按鈕可見"
L["Swap"] = "交換"
L["Swap location of numbers for count and cooldown timer"] = "交換數字計數和冷卻時間的位置"
L["Buttons per row"] = "每行幾個按鈕"
L["AutoQuest"]  = "自動任務"
L["Auto accept or hand out quests from AutoQuestPopupTracker!"] = "自動接受或交出任務從AutoQuestPopupTracker！"
L["Strata"] = "地層"
L["Set strata for items button to HIGH, place it over normal windows."] = "將項目的地層按鈕設置為高，將其放在普通窗口上。"
L["Herald"] = "先鋒"
L["Announce completed work orders, artifact points etc.."] = "宣布完成的工單，工件點等。"
L["Skip on Error"] = "跳過錯誤"
L["Temporary blacklist item when click produce error message"] = "臨時黑名單項目點擊時產生錯誤信息"
L["HIDE_IN_COMBAT"] = "顯示聲望"
L["HIDE_IN_COMBAT_HELP"] = "在戰鬥中隱藏物品按鈕"
L["SHOW_REPUTATION"] = "顯示聲望"
L["SHOW_REPUTATION_HELP"] = "顯示軍團的聲望站在工具提示信譽標記項目。激活/取消激活需要遊戲客戶端重新加載。"
L["SKIP_EXALTED"] = "跳過崇高"
L["SKIP_EXALTED_HELP"] = "已經崇高的時候不要使用軍團聲望代幣。"
L["SKIP_MAXPOWER"] = "Skip artifact"
L["SKIP_MAXPOWER_HELP"] = "Skip artifact power tokens when artifact have maximum traits."
L["Number of buttons placed in one row"] = "放置在一行的按鈕數"
L["Spacing"] = "間距"
L["Space between buttons"] = "按鈕之間的距離"
L["Sticky"] = "黏附"
L["Anchor to Item button"] = "定位到物品按鈕"
L["Direction"] = "方向"
L["Expand bar to"] = "條的擴展方向"
L["Up"] = "上"
L["Down"] = "下"
L["Left"] = "左"
L["Right"] = "右"
L["Add new row"] = "增加新行"
L["Above or below last one"] = "最後一個以上或以下"
L["Hot-Key"] = "熱鍵"
L["Key to use for automatic key binding."] = "用於自動綁定按鍵的熱鍵。"
L["Quest"] = "任務"
L["Quest not found for this item."] = "找不到此物品的任務。"
L["Items cache update run |cFF00FF00%d."] = "物品快取更新執行|cFF00FF00%d。"
L["Spells cache update run |cFF00FF00%d."] = "法術快取更新執行|cFF00FF00%d。"
L["TOGO_ANNOUNCE"] = "%s：%d完成 還剩%d！"
L["REWARD_ANNOUNCE"] = "%s的巔峰聲望獎勵已就緒！"
L["SHIPYARD_ANNOUNCE"] = "船塢還有%d/%d艘船！"
L["ARTIFACT_ANNOUNCE"] = "%s有%d特長已就緒！"
L["ARCHAELOGY_ANNOUNCE"] = "考古學 %s已就緒！"
L["TALENT_ANNOUNCE"] = "%s 已就緒！"
L["RESTARTED_LOOKUP"] = "臨時黑名單已清除，重新開始建立！"
L["CONSOLE_USAGE"] = [=[ [reset|skin|lock|clear|list|unlist|skip|glow|zone|quest|show]
reset  - 將會重置物品位置到螢幕中間
skin   - 將會切換按鈕皮膚
lock   - 將會鎖定/解鎖按鈕
clear  - 將會重置永遠黑名單
list   - 列出永遠黑名單物品
unlist - 根據物品ID從黑名單移除單獨物品
skip   - 切換右鍵點擊略過臨時或是直到重新記錄
glow   - 切換按鈕在區域時物品發亮
zone   - 切換物品區域限制
quest  - 開關任務條
show   - 空按鈕可見]=];
