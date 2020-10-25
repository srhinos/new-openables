-- Chinese Traditional localization file for zhCN. by 图图 and Google translator
local _
-- global functions and variebles to locals to keep LINT happy
local assert = _G.assert
local LibStub = _G.LibStub; assert(LibStub ~= nil,'LibStub')
-- local AddOn
local ADDON = ...
local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local L = AceLocale:NewLocale(ADDON, "zhCN");
if not L then return end
--
L["NOP_TITLE"] = "|cffCCCC88[菜单]|r一键开包"
L["NOP_VERSION"] = "|cFFFFFFFF%s 使用 |cFFFF00FF/nop|cFFFFFFFF"
L["CLICK_DRAG_MSG"] = "ALT-左键拖动。"
L["CLICK_OPEN_MSG"] = "左键点击开启或使用。"
L["CLICK_SKIP_MSG"] = "右键点击略过物品。"
L["CLICK_BLACKLIST_MSG"] = "CTRL-右键点击添加到黑名单。"
L["No openable items!"] = "没有可开启物品!"
L["BUTTON_RESET"] = "重置并移动按钮到屏幕中间!"
L["NOP_USE"] = "使用:"
L["Spell:"] = "施法:"
L["BLACKLISTED_ITEMS"] = "|cFFFF00FF永久黑名单物品:"
L["BLACKLIST_EMPTY"] = "|cFFFF00FF永久黑名单是空的"
L["PERMA_BLACKLIST"] = "永久黑名单:|cFF00FF00"
L["SESSION_BLACKLIST"] = "本次上线黑名单:|cFF00FF00"
L["TEMP_BLACKLIST"] = "临时黑名单:|cFF00FF00"
L["|cFFFF0000Error loading tooltip for|r "] = "|cFFFF0000错误载入提示|r "
L["Plans, patterns and recipes cache update."] = "图纸、配方缓存更新。"
L["Spell patterns cache update."] = "法术图标缓存更新。"
L["|cFFFF0000Error loading tooltip for spell |r "] = "|cFFFF0000法术错误载入提示 |r "
L["|cFFFF0000Error loading tooltip for spellID %d"] = "|cFFFF0000%d 法术ID错误载入提示"
L["TOGGLE"] = "切换"
L["Skin Button"] = "美化按钮"
L["Masque Enable"] = "Masque 啟用"
L["Need UI reload or relogin to activate."] = "需要UI重新加載或重新登錄才能激活。"
L["Lock Button"] = "锁定按钮"
L["Lock button in place to disbale drag."] = "锁定按钮来禁用拖动。"
L["Glow Button"] = "闪光按钮"
L["When item is placed by zone change, button will have glow effect."] = "当物品排序随区域变动时，按钮会有发光效果。"
L["Backdrop Button"] = "按钮边框"
L["Create or remove backdrop around button, need reload UI."] = "显示/隐藏按钮背景(需要重载插件)"
L["Session skip"] = "本次上线略过"
L["Skipping item last until relog."] = "略过物品直到重新登入。"
L["Clear Blacklist"] = "清空黑名单"
L["Reset Permanent blacklist."] = "重置永久黑名单。"
L["Zone unlock"] = "区域解锁"
L["Don't zone restrict openable items"] = "不要根据区域限制可开启的物品"
L["Profession"] = "专业"
L["Place items usable by lockpicking"] = "根据[开锁]放置可使用物品"
L["Button"] = "按钮"
L["Buttom location"] = "按钮位置"
L["Button size"] = "按钮大小"
L["Width and Height"] = "宽和高"
L["Button size in pixels"] = "按钮大小(单位：像素)"
L["Miner's Coffee stacks"] = "矿工咖啡堆叠数"
L["Allow buff up to this number of stacks"] = "允许增益堆叠到此数字"
L["Quest bar"] = "任务条"
L["Quest items placed on bar"] = "任务物品放在条上"
L["Visible"] = "可视化"
L["Make button visible by placing fake item on it"] = "通过放置假物品使按钮可见"
L["Swap"] = "交换"
L["Swap location of numbers for count and cooldown timer"] = "交换数字计数和冷却时间的位置"
L["AutoQuest"]  = "自动任务"
L["Auto accept or hand out quests from AutoQuestPopupTracker!"] = "自动接受或交出任务从AutoQuestPopupTracker！"
L["Strata"] = "地層"
L["Set strata for items button to HIGH, place it over normal windows."] = "將項目的地層按鈕設置為高，將其放在普通窗口上。"
L["Herald"] = "先鋒"
L["Announce completed work orders, artifact points etc.."] = "宣布完成的工單，工件點等。"
L["Skip on Error"] = "跳過錯誤"
L["Temporary blacklist item when click produce error message"] = "臨時黑名單項目點擊時產生錯誤信息"
L["HIDE_IN_COMBAT"] = "隱藏在戰鬥中"
L["HIDE_IN_COMBAT_HELP"] = "在戰鬥中隱藏物品按鈕"
L["SHOW_REPUTATION"] = "顯示聲望"
L["SHOW_REPUTATION_HELP"] = "顯示軍團的聲望站在工具提示信譽標記項目。激活/取消激活需要遊戲客戶端重新加載。"
L["SKIP_EXALTED"] = "跳過崇高"
L["SKIP_EXALTED_HELP"] = "已經崇高的時候不要使用軍團聲望代幣。"
L["SKIP_MAXPOWER"] = "Skip artifact"
L["SKIP_MAXPOWER_HELP"] = "Skip artifact power tokens when artifact have maximum traits."
L["Buttons per row"] = "每行几个按钮"
L["Number of buttons placed in one row"] = "放置在一行的按钮数"
L["Spacing"] = "间距"
L["Space between buttons"] = "按钮之间的距离"
L["Sticky"] = "附着"
L["Anchor to Item button"] = "定位到物品按钮"
L["Direction"] = "方向"
L["Expand bar to"] = "条的扩展方向"
L["Up"] = "上"
L["Down"] = "下"
L["Left"] = "左"
L["Right"] = "右"
L["Add new row"] = "增加新行"
L["Above or below last one"] = "最后一个以上或以下"
L["Hot-Key"] = "快捷键"
L["Key to use for automatic key binding."] = "用于自动绑定按键的快捷键。"
L["Quest"] = "任务"
L["Quest not found for this item."] = "找不到此物品的任務。"
L["Items cache update run |cFF00FF00%d."] = "物品快取更新執行|cFF00FF00%d。"
L["Spells cache update run |cFF00FF00%d."] = "法術快取更新執行|cFF00FF00%d。"
L["TOGO_ANNOUNCE"] = "%s: %d 完成%d去！"
L["REWARD_ANNOUNCE"] = "%s的百麗宮獎勵已經準備就緒！"
L["SHIPYARD_ANNOUNCE"] = "造船廠有%d/%d艘船！"
L["ARTIFACT_ANNOUNCE"] = "%s有%d個特質！"
L["ARCHAELOGY_ANNOUNCE"] = "Archaeology %s 準備好了！"
L["TALENT_ANNOUNCE"] = "%s 準備好了！"
L["RESTARTED_LOOKUP"] = "臨時黑名單被清除，重新開始查找！"
L["CONSOLE_USAGE"] = [=[ [reset|skin|lock|clear|list|unlist|skip|glow|zone|quest|show]
reset  - 將會重置物品位置到螢幕中間
skin   - 將會切換按鈕皮膚
lock   - 將會鎖定/解鎖按鈕
clear  - 將會重置永遠黑名單
list   - 列出永遠黑名單物品
unlist - remove single item from blacklist based on itemID
skip   - 切換右鍵點擊略過臨時或是直到重新記錄
glow   - 切換按鈕在區域時物品發亮
zone   - 切換物品區域限制
quest  - 開關任務條
show   - 空按鈕可見]=];
