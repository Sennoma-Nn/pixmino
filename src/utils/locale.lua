-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local locale = {}
local dbg = require("src.game.debug")

locale.langs = { "en", "ja", "zh_cn", "zh_tw" }
locale.current = "en"

local features = dbg.detect_features()

local env_info = love._version .. "\r\n" ..
    string.gsub(_VERSION:upper(), " ", "    ") ..
    "\r\n" .. jit.version:upper() ..
    "\r\nOS     " .. love._os .. "\n" ..
    "\r\nGOTO FORWARD  " .. (features.goto_forward and "YES" or "NO") ..
    "\r\nGOTO BACKWARD " .. (features.goto_backward and "YES" or "NO") ..
    "\r\nBIT OPERATOR  " .. (features.bit_operator and "YES" or "NO") ..
    "\r\nIDIV OPERATOR " .. (features.idiv_operator and "YES" or "NO")

locale.t = {
    BACK_TIP = {
        en = "⎋ TO BACK",
        ja = "⎋ ﾃﾞ ﾓﾄﾞﾙ",
        zh_cn = "⎋ 返回",
        zh_tw = "⎋ 返回",
    },

    READY = {
        en = "READY",
        ja = "ﾚﾃﾞｨ",
        zh_cn = "准备",
        zh_tw = "準備",
    },
    GO = {
        en = "GO",
        ja = "ｺﾞｰ",
        zh_cn = "开始",
        zh_tw = "開始"
    },

    START = {
        en = "START",
        ja = "ｽﾀｰﾄ",
        zh_cn = "开始",
        zh_tw = "開始",
    },
    START_DESC = {
        en = "Start Game!",
        ja = "ｹﾞｰﾑｦ ｽﾀｰﾄ!",
        zh_cn = "开始游戏!",
        zh_tw = "開始遊戲!",
    },

    ABOUT = {
        en = "ABOUT",
        ja = "ｾﾂﾒｲ",
        zh_cn = "关于",
        zh_tw = "關於",
    },
    ABOUT_DESC = {
        en = "About PIXMINO.",
        ja = "ﾋﾟｸｾﾐﾉﾆ ﾂｲﾃ｡",
        zh_cn = "关于像素立方｡",
        zh_tw = "關於圖元立方｡",
    },

    ABOUT_GAME = {
        en = "GAME",
        ja = "ｹﾞｰﾑ",
        zh_cn = "游戏",
        zh_tw = "遊戲",
    },
    ABOUT_GAME_DESC = {
        en = "PIXMINO " .. GAMEVER .. "\r\n\nMade with LÖVE.",
        ja = "ﾋﾟｸｾﾐﾉ " .. GAMEVER .. "\r\n\nLOVEﾃﾞ ｻｸｾｲ｡",
        zh_cn = "像素立方 " .. GAMEVER .. "\r\n\n使用 LÖVE 开发｡",
        zh_tw = "圖元立方 " .. GAMEVER .. "\r\n\n使用 LÖVE 開發｡",
    },

    ENVIRONMENT = {
        en = "RUNTIME",
        ja = "ｶﾝｷｮｳ",
        zh_cn = "运行环境",
        zh_tw = "執行環境",
    },
    ENVIRONMENT_DESC = {
        en = "Runtime environment:\r\n\nLÖVE   " .. env_info,
        ja = "ｶﾝｷｮｳ:\r\n\nLOVE   " .. env_info,
        zh_cn = "运行环境:\r\n\nLÖVE   " .. env_info,
        zh_tw = "執行環境:\r\n\nLÖVE   " .. env_info,
    },

    SOURCE = {
        en = "SOURCE",
        ja = "ｿｰｽ",
        zh_cn = "源代码",
        zh_tw = "原始碼",
    },
    SOURCE_DESC = {
        en = "Source Code:\r\n\nGitHub:\r\nSennoma-Nn/pixmino\r\n\nLicensed under GPLv3.\r\n🄯 2026 Sennoma-Nn",
        ja = "ｿｰｽ ｺｰﾄﾞ:\r\n\nGitHub:\r\nSennoma-Nn/pixmino\r\n\nGPLv3 ﾗｲｾﾝｽﾃﾞ ｺｳｶｲ｡\r\n🄯 2026 Sennoma-Nn",
        zh_cn = "源代码:\r\n\nGitHub:\r\nSennoma-Nn/pixmino\r\n\n以 GPLv3 许可发布｡\r\n🄯 2026 Sennoma-Nn",
        zh_tw = "原始碼:\r\n\nGitHub:\r\nSennoma-Nn/pixmino\r\n\n以 GPLv3 授權釋出｡\r\n🄯 2026 Sennoma-Nn",
    },

    SP_THANKS = {
        en = "SP.THANKS",
        ja = "SP.ｻﾝｸｽ",
        zh_cn = "特别鸣谢",
        zh_tw = "特別感謝",
    },
    SP_THANKS_DESC = {
        en = "Special Thanks",
        ja = "ｽﾍﾟｼｬﾙ ｻﾝｸｽ",
        zh_cn = "特别鸣谢",
        zh_tw = "特別感謝",
    },

    SP_PUSH = {
        en = "PUSH",
        ja = "PUSH",
        zh_cn = "PUSH",
        zh_tw = "PUSH",
    },
    SP_PUSH_DESC = {
        en = "Ulydev:\r\n\nLibrary Push for LÖVE.\r\n(MIT)",
        ja = "Ulydev:\r\n\nLOVE ﾖｳ ﾗｲﾌﾞﾗﾘ Push｡\r\n(MIT)",
        zh_cn = "Ulydev:\r\n\n用于 LÖVE 的 Push 函数库｡ (MIT)",
        zh_tw = "Ulydev:\r\n\n用於 LÖVE 的 Push 函式庫｡ (MIT)",
    },

    SP_IBFULL = {
        en = "IB-FULL",
        ja = "IB-FULL",
        zh_cn = "IB-FULL",
        zh_tw = "IB-FULL",
    },
    SP_IBFULL_DESC = {
        en = 'Soda 261:\r\n\nMade "IB-FULL" font,\r\nfor displaying game stats.',
        ja = "Soda 261:\r\n\nｹﾞｰﾑ ｼﾞｮｳﾎｳ ﾋｮｳｼﾞ ﾖｳ\r\n｢IB-FULL｣ ﾌｫﾝﾄ ｾｲｻｸ｡",
        zh_cn = 'Soda 261:\r\n\n制作"IB-FULL"字体,\r\n用于显示游戏信息｡',
        zh_tw = "Soda 261:\r\n\n製作｢IB-FULL｣字型,\r\n用於顯示遊戲資訊｡",
    },

    SP_QUANPIXEL = {
        en = "QUANPIXEL",
        ja = "QUANPIXEL",
        zh_cn = "全小素",
        zh_tw = "全小素",
    },
    SP_QUANPIXEL_DESC = {
        en = 'Galmuri8, Chill Bitmap,\r\nDiaowinner:\r\n\n"QuanPixel 8px" font,\r\nfor displaying Chinese.\r\n(OFL 1.1)',
        ja = "Galmuri8, Chill Bitmap,\r\nDiaowinner:\r\n\nﾁｭｳｺﾞｸｺﾞ ﾖｳ ｢QuanPixel 8px｣\r\nﾌｫﾝﾄ｡ (OFL 1.1)",
        zh_cn = 'Galmuri8, Chill Bitmap,\r\nDiaowinner:\r\n\n"全小素8PX"字体,用于显示中文｡ \r\n(OFL 1.1)',
        zh_tw = "Galmuri8, Chill Bitmap,\r\nDiaowinner:\r\n\n｢全小素8PX｣字型,用於顯示中文｡ \r\n(OFL 1.1)",
    },

    NAME_MILKYAO = {
        en = "MilkYao",
        ja = "MilkYao",
        zh_cn = "缪锞尧 - MilkYao",
        zh_tw = "繆锞堯 - MilkYao", -- 中文字型沒有「錁」只能用「锞」替代了（）
    },

    SP_BGM = {
        en = "BGM",
        ja = "BGM",
        zh_cn = "BGM",
        zh_tw = "BGM"
    },
    SP_BGM_DESC = {
        en = "MilkYao:\r\n\nMade all BGM for the game.",
        ja = "MilkYao:\r\n\nｹﾞｰﾑ ｾﾞﾝﾌﾞﾉ BGMｦ ｾｲｻｸ｡",
        zh_cn = "缪锞尧 - MilkYao:\r\n\n制作游戏全部BGM｡",
        zh_tw = "繆锞堯 - MilkYao:\r\n\n製作遊戲全部BGM｡"
    },

    SP_SFX = {
        en = "SFX",
        ja = "SFX",
        zh_cn = "SFX",
        zh_tw = "SFX",
    },
    SP_SFX_DESC = {
        en = 'mOsh:\r\n\n8BIT SFX Library. (CC0)',
        ja = "mOsh:\r\n\n8BIT SFX ﾗｲﾌﾞﾗﾘ｡ (CC0)",
        zh_cn = 'mOsh:\r\n\n8BIT SFX 库｡ (CC0)',
        zh_tw = "mOsh:\r\n\n8BIT SFX 庫｡ (CC0)",
    },

    PAUSE = {
        en = "PAUSED",
        ja = "ﾎﾟｰｽﾞ",
        zh_cn = "暂停",
        zh_tw = "暫停",
    },
    GAME_OVER = {
        en = "GAME OVER",
        ja = "ｹﾞｰﾑｵｰﾊﾞｰ",
        zh_cn = "游戏结束",
        zh_tw = "遊戲結束",
    },
    BEST = {
        en = "BEST",
        ja = "ｻｲｺｳｷﾛｸ",
        zh_cn = "最佳",
        zh_tw = "最佳",
    },
    CONTINUE = {
        en = "CONTINUE",
        ja = "ﾂﾂﾞｹ",
        zh_cn = "继续",
        zh_tw = "繼續",
    },
    RESTART = {
        en = "RESTART",
        ja = "ﾘｽﾀｰﾄ",
        zh_cn = "重开",
        zh_tw = "重開",
    },
    QUIT = {
        en = "QUIT",
        ja = "ｼｭｳﾘｮｳ",
        zh_cn = "退出",
        zh_tw = "結束",
    },
    QUIT_DESC = {
        en = "Exit the game.",
        ja = "ｹﾞｰﾑｦ ｼｭｳﾘｮｳ｡",
        zh_cn = "退出游戏｡",
        zh_tw = "結束遊戲｡",
    },

    SETTINGS = {
        en = "SETTINGS",
        ja = "ｾｯﾃｲ",
        zh_cn = "设置",
        zh_tw = "設定",
    },
    SETTINGS_DESC = {
        en = "Adjust game settings.\r\n\n🠸 X 🠺 ←/→ to change option\r\n- X - ↩ to toggle\r\n[ X ] ↩ then press a key",
        ja = "ｹﾞｰﾑ ｾｯﾃｲｦ ﾁｮｳｾｲ｡\r\n\n🠸 X 🠺 ←/→ ﾃﾞ ｺｳﾓｸｦ ﾍﾝｺｳ\r\n- X - ↩ ﾃﾞ ｷﾘｶｴ\r\n[ X ] ↩ ﾉｱﾄ ｷｰｦ ﾆｭｳﾘｮｸ",
        zh_cn = "调整游戏设置｡\r\n\n🠸 X 🠺 按下 ←/→ 键改变\r\n- X - 按下 ↩ 键切换\r\n[ X ] 按下 ↩ 键后输入一个按键",
        zh_tw = "調整遊戲設定｡\r\n\n🠸 X 🠺 按下 ←/→ 鍵改變\r\n- X - 按下 ↩ 鍵切換\r\n[ X ] 按下 ↩ 鍵後輸入一個按鍵",
    },

    JMP_CTRL = {
        en = "CONTROLS",
        ja = "ｿｳｻ",
        zh_cn = "操作",
        zh_tw = "操作",
    },
    JMP_KEYS = {
        en = "KEY",
        ja = "ｷｰ",
        zh_cn = "按键",
        zh_tw = "按鍵",
    },

    DISPLAY = {
        en = "DISPLAY",
        ja = "ﾋｮｳｼﾞ",
        zh_cn = "显示",
        zh_tw = "顯示",
    },
    DISPLAY_DESC = {
        en = "Adjust display settings.",
        ja = "ﾋｮｳｼﾞ ｾｯﾃｨﾝｸﾞｦ ﾁｮｳｾｲ｡",
        zh_cn = "调整显示设置｡",
        zh_tw = "調整顯示設定｡",
    },

    SOUND = {
        en = "SOUND",
        ja = "ｻｳﾝﾄﾞ",
        zh_cn = "声音",
        zh_tw = "聲音",
    },
    SOUND_DESC = {
        en = "Adjust sound settings.",
        ja = "ｵﾄ ｾｯﾃｨﾝｸﾞｦ ﾁｮｳｾｲ｡",
        zh_cn = "调整声音设置｡",
        zh_tw = "調整聲音設定｡",
    },

    INPUT = {
        en = "INPUT",
        ja = "ｲﾝﾌﾟｯﾄ",
        zh_cn = "输入",
        zh_tw = "輸入",
    },
    INPUT_DESC = {
        en = "Adjust input settings.",
        ja = "ｲﾝﾌﾟｯﾄ ｾｯﾃｨﾝｸﾞｦ ﾁｮｳｾｲ｡",
        zh_cn = "调整输入设置｡",
        zh_tw = "調整輸入設定｡",
    },

    CONSOLE = {
        en = "CONSOLE",
        ja = "ｺﾝｿｰﾙ",
        zh_cn = "调试控制台",
        zh_tw = "除錯主控臺",
    },
    CONSOLE_DESC = {
        en = "Open the Debug console.",
        ja = "ﾃﾞﾊﾞｯｸﾞ ｺﾝｿｰﾙｦ ﾋﾗｸ｡",
        zh_cn = "打开调试控制台｡",
        zh_tw = "開啟除錯主控臺｡",
    },

    FULLSCREEN = {
        en = "FULL SCR.",
        ja = "ﾌﾙｽｸﾘｰﾝ",
        zh_cn = "全屏",
        zh_tw = "全螢幕",
    },
    LANGUAGE = {
        en = "LANGUAGE",
        ja = "ｹﾞﾝｺﾞ",
        zh_cn = "语言",
        zh_tw = "語言",
    },

    MUSIC_VOL = {
        en = "MUSIC VOL",
        ja = "ｵﾝｶﾞｸ VOL",
        zh_cn = "音乐音量",
        zh_tw = "音樂音量",
    },
    MUSIC_VOL_DESC = {
        en = "Set the music volume.",
        ja = "ｵﾝｶﾞｸﾉ ﾎﾞﾘｭｰﾑｦ ｾｯﾃｲ｡",
        zh_cn = "设置音乐音量｡",
        zh_tw = "設定音樂音量｡",
    },

    SFX_VOL = {
        en = "SFX VOL",
        ja = "ｺｳｶｵﾝ VOL",
        zh_cn = "音效音量",
        zh_tw = "音效音量",
    },
    SFX_VOL_DESC = {
        en = "Set the sound effect volume.",
        ja = "ｺｳｶｵﾝﾉ ﾎﾞﾘｭｰﾑｦ ｾｯﾃｲ｡",
        zh_cn = "设置音效音量｡",
        zh_tw = "設定音效音量｡",
    },

    -- 來自俄羅斯方塊中文維基的建議
    -- http://tetriswiki.cn/p/延迟自动移动

    -- 目前，这三个概念通用的中英文命名是：
    -- {| class="wikitable"
    -- ! 概念 !! 缩写 !! 英文 !! 中文 !! 问题
    -- |-
    -- | 游戏机制 || '''DAS''' || Delayed Auto Shift || '''自动移动延迟''' || 中文习惯译名改变了语序
    -- |-
    -- | 延迟时间 || '''DAS''' || Delayed Auto Shift || '''自动移动延迟''' || 短语主体是「Shift」而非「Delay」<br>而且与机制命名相同容易混淆
    -- |-
    -- | 移动间隔 || '''ARR''' || Auto Repeat Rate || '''自动重复速率''' || 「速率」的量纲应为时间的倒数<br>但现在多习惯使用时间作为单位
    -- |}
    -- 有批评观点认为，这套命名方式存在诸多问题：不仅混淆了机制与参数的名字，而且参数名字的主体、量纲都存在问题，并且两个参数的命名方式完全不对称。

    -- 对此，以 MrZ 为首的中文开发者提出了新的一套中英文命名方式：
    -- {| class="wikitable"
    -- ! 概念 !! 缩写 !! 英文 !! 中文 !! 备注
    -- |-
    -- | 游戏机制 || '''DAS''' || Delayed Auto Shift || '''延迟自动移动''' || 中文名恢复原本语序
    -- |-
    -- | 延迟时间 || '''ASD''' || Auto Shift Delay || '''自动移动延迟''' || 解决主体问题<br>并与其他延迟的命名保持一致
    -- |-
    -- | 移动间隔 || '''ASP''' || Auto Shift Period || '''自动移动周期''' || 解决量纲问题<br>并使两个参数的命名保持对称
    -- |}
    -- 不过，这套新的命名暂时还没有得到广泛使用。在本条目中，{{SITENAME}}将试用「相对更正确」的新命名。

    DAS = {
        en = "ASD",
        ja = "ASD",
        zh_cn = "自动延迟移动",
        zh_tw = "自動移動延遲",
    },
    DAS_DESC = {
        en = "~~ Auto Shift Delay ~~\r\n\nThe delay from pressing\r\na move key, until the\r\npiece starts auto-shifting\r\nat a fixed speed.",
        ja = "‾‾ Auto Shift Delay ‾‾\r\n\nｲﾄﾞｳｷｰｦ ｵｼﾃｶﾗ､ ﾋﾟｰｽｶﾞ\r\nｲｯﾃｲ ｿｸﾄﾞﾃﾞ ｼﾞﾄﾞｳ ﾚﾝｿﾞｸ\r\nｲﾄﾞｳｦ ｶｲｼｽﾙﾏﾃﾞﾉ ｼﾞｶﾝ｡",
        zh_cn = "~~ 自动延迟移动 (ASD) ~~\r\n\n按下移动键,\r\n到方块开始以固定速度\r\n自动连续移动的间隔时间｡",
        zh_tw = "~~ 自動移動延遲 (ASD) ~~\r\n\n按下移動鍵,\r\n到方塊開始以固定速度\r\n自動連續移動的間隔時間｡",
    },

    ARR = {
        en = "ASP",
        ja = "ASP",
        zh_cn = "自动移动周期",
        zh_tw = "自動移動週期",
    },
    ARR_DESC = {
        en = "~~ Auto Shift Period ~~\r\n\nThe interval between moves\r\nwhile a piece auto-shifts\r\nat a fixed speed.",
        ja = "‾‾ Auto Shift Period ‾‾\r\n\nﾋﾟｰｽｶﾞ ｲｯﾃｲ ｿｸﾄﾞﾃﾞ\r\nｼﾞﾄﾞｳ ﾚﾝｿﾞｸｲﾄﾞｳｽﾙｱｲﾀﾞﾉ\r\nｲﾄﾞｳ ｶﾝｶｸ｡",
        zh_cn = "~~ 自动移动周期 (ASP) ~~\r\n\n在方块以固定速度自动连续移动时,\r\n两次移动之间的间隔时间｡",
        zh_tw = "~~ 自動移動週期 (ASP) ~~\r\n\n在方塊以固定速度自動連續移動時,\r\n兩次移動之間的間隔時間｡",
    },

    DP_ARR = {
        en = "DP.ASP",
        ja = "DP.ASP",
        zh_cn = "软降自动移动周期",
        zh_tw = "軟降自動移動週期",
    },
    DP_ARR_DESC = {
        en = "~~ Drop Auto Shift Period ~\r\n\nThe interval between drops\r\nwhile a piece drops\r\ncontinuously.",
        ja = "‾‾ Drop Auto Shift Period ‾\r\n\nｿﾌﾄﾄﾞﾛｯﾌﾟｦ ｵｼﾃ ｶｲｼｽﾙ\r\nﾚﾝｿﾞｸ ｶｺｳﾉ､ﾌﾀﾂﾉ ｶｺｳﾉ\r\nｱｲﾀﾞﾉ ｼﾞｶﾝ｡",
        zh_cn = "~~ 软降自动移动周期 (DP.ASP) ~~\r\n\n按下软降键后开始的连续下降,\r\n两次降落之间的间隔时间｡",
        zh_tw = "~~ 軟降自動移動週期 (DP.ASP) ~~\r\n\n按下軟降鍵後開始的連續下降,\r\n兩次降落之間的間隔時間｡",
    },

    PREOP = {
        en = "I*S",
        ja = "ｾﾝｺｳ",
        zh_cn = "预输入",
        zh_tw = "預輸入",
    },
    PREOP_DESC = {
        en = "~~ Initial ** System ~~\r\n\nHold rotate, move,\r\nor hold keys and\r\nthe action triggers\r\nwhen a new piece spawns.",
        ja = "‾‾ ｾﾝｺｳﾆｭｳﾘｮｸ ‾‾\r\n\nｱﾀﾗｼｲﾋﾟｰｽ ｽﾎﾟｰﾝｼﾞﾆ\r\nｷｰｦ ｵｻｴﾃ ｲﾙﾄ\r\nｶｲﾃﾝ･ｲﾄﾞｳ･ﾎｰﾙﾄﾞ｡",
        zh_cn = "~~ 预输入 ~~\r\n\n新方块入场时\r\n提前按住按键立即触发\r\n旋转､移动或暂存｡",
        zh_tw = "~~ 預輸入 ~~\r\n\n新方塊入場時\r\n提前按住按鍵立即觸發\r\n旋轉､移動或暫存｡",
    },

    SPAWN_MARK = {
        en = "SPAWN",
        ja = "ｽﾎﾟｰﾝ",
        zh_cn = "出生标记",
        zh_tw = "出生標記",
    },
    SPAWN_MARK_DESC = {
        en = "Mark the next piece's shape\r\nand spawn position on the\r\nfield.",
        ja = "ﾌｨｰﾙﾄﾞｼﾞｮｳﾆ ﾂｷﾞﾉ ﾋﾟｰｽﾉ\r\nｶﾀﾁﾄ ｽﾎﾟｰﾝ ｲﾁｦ ﾏｰｸ｡",
        zh_cn = "在场地上标记下个方块的形状与出現位置｡",
        zh_tw = "在場地上標記下個方塊的形狀與出現位置｡",
    },

    KEY_INFO = {
        en = "KEY INFO",
        ja = "ｷｰﾋｮｳｼﾞ",
        zh_cn = "按键显示",
        zh_tw = "按鍵顯示",
    },
    KEY_INFO_DESC = {
        en = "Show the pressed keys\r\nwhile playing.",
        ja = "ﾌﾟﾚｲﾁｭｳ ﾚｼﾞｮｳﾆ\r\nｵｼﾀ ｷｰｦ ﾋｮｳｼﾞ｡",
        zh_cn = "游戏中在画面上方显示当前按下的按键｡",
        zh_tw = "遊戲中在畫面上方顯示目前按下的按鍵｡",
    },
    SKIN = {
        en = "SKIN",
        ja = "ｽｷﾝ",
        zh_cn = "皮肤",
        zh_tw = "皮膚",
    },
    SKIN_DESC = {
        en = "Select the block skin.",
        ja = "ﾌﾞﾛｯｸﾉ ｽｷﾝｦ ｾﾝﾀｸ｡",
        zh_cn = "选择方块皮肤｡",
        zh_tw = "選擇方塊皮膚｡",
    },

    CCW = {
        en = "CCW",
        ja = "ﾋﾀﾞﾘｶｲﾃﾝ",
        zh_cn = "左转",
        zh_tw = "左轉",
    },
    CW = {
        en = "CW",
        ja = "ﾐｷﾞｶｲﾃﾝ",
        zh_cn = "右转",
        zh_tw = "右轉",
    },
    ROT180 = {
        en = "ROT.180",
        ja = "180ﾄﾞ",
        zh_cn = "翻转",
        zh_tw = "翻轉",
    },
    HOLD = {
        en = "HOLD",
        ja = "ﾎｰﾙﾄﾞ",
        zh_cn = "暂存",
        zh_tw = "暫存",
    },
    HARD_DROP = {
        en = "HARD DP.",
        ja = "ﾊｰﾄﾞDP.",
        zh_cn = "硬降",
        zh_tw = "硬降",
    },
    SOFT_DROP = {
        en = "SOFT DP.",
        ja = "ｿﾌﾄDP.",
        zh_cn = "软降",
        zh_tw = "軟降",
    },
    LEFT = {
        en = "LEFT",
        ja = "ﾋﾀﾞﾘ",
        zh_cn = "左移",
        zh_tw = "左移",
    },
    RIGHT = {
        en = "RIGHT",
        ja = "ﾐｷﾞ",
        zh_cn = "右移",
        zh_tw = "右移",
    },

    PRESS_KEY_TIP = {
        en = "PRESS KEY...",
        ja = "ｷｰｦ ｵｼﾃ...",
        zh_cn = "请按下按键...",
        zh_tw = "請按下按鍵...",
    },

    MARATHON = {
        en = "MARATHON",
        ja = "ﾏﾗｿﾝ",
        zh_cn = "马拉松",
        zh_tw = "馬拉松",
    },
    MARATHON_DESC = {
        en = "Clear 150 lines,\r\nAim for score,\r\nchase the top!",
        ja = "150 ﾗｲﾝｦ ｸﾘｱ､\r\nｽｺｱｦ ﾈﾗｴ､ ﾓｯﾄ ﾀｶｸ!",
        zh_cn = "清除150行,\r\n以分数为目标,向更高分冲刺!",
        zh_tw = "消除150列,\r\n以分數為目標,向更高分衝刺!",
    },

    SPRINT = {
        en = "SPRINT",
        ja = "40 ﾗｲﾝ",
        zh_cn = "40行",
        zh_tw = "40列",
    },
    SPRINT_DESC = {
        en = "Clear 40 lines,\r\nAim for speed,\r\nfaster is better!",
        ja = "40 ﾗｲﾝｦ ｸﾘｱ､\r\nﾊﾔｻｦ ｷｿｴ､ ﾊﾔｻ ﾍﾞｽﾄ!",
        zh_cn = "清除40行,\r\n以速度为目标,时间越短越好!",
        zh_tw = "消除40列,\r\n以速度為目標,時間越短越好!",
    },

    MASTER = {
        en = "MASTER",
        ja = "ﾏｽﾀｰ",
        zh_cn = "大师",
        zh_tw = "大師",
    },
    NO_MOVE = {
        en = "NO MOVE!?",
        ja = "ｲﾄﾞｳﾌｶﾉ!?",
        zh_cn = "禁止移动!?",
        zh_tw = "禁止移動!?",
    },
    MASTER_DESC = {
        en = "Clear 300 lines,\r\nPieces drop instantly,\r\nless time to act!",
        ja = "300 ﾗｲﾝｦ ｸﾘｱ､\r\nﾌﾞﾛｯｸ ﾁｮｸｾﾂ ﾗｯｶ､\r\nｿｳｻ ｼﾞｶﾝ ﾐｼﾞｶｸ ﾅﾙ!",
        zh_cn = "清除300行,\r\n方块直接落地,\r\n操作时间越来越短!",
        zh_tw = "消除300列,\r\n方塊直接落地,\r\n操作時間越來越短!",
    },

    JMP_CTRL_DESC = {
        en = "Adjust game controls.",
        ja = "ｿｳｻｦ ﾁｮｳｾｲ｡",
        zh_cn = "调整游戏操作｡",
        zh_tw = "調整遊戲操作｡",
    },
    JMP_KEYS_DESC = {
        en = "Assign keys to each action.",
        ja = "ｶｸ ｱｸｼｮﾝﾆ ｷｰｦ ﾌﾘｱﾃﾙ｡",
        zh_cn = "为每个动作分配按键｡",
        zh_tw = "為每個動作指派按鍵｡",
    },
    FULLSCREEN_DESC = {
        en = "Toggle fullscreen display.",
        ja = "ﾌﾙｽｸﾘｰﾝ ﾋｮｳｼﾞｦ ｷﾘｶｴ｡",
        zh_cn = "切换全屏｡",
        zh_tw = "切換全螢幕｡",
    },
    LANGUAGE_DESC = {
        en = "Select display language.",
        ja = "ﾋｮｳｼﾞ ｹﾞﾝｺﾞｦ ｾﾝﾀｸ｡",
        zh_cn = "选择显示语言｡",
        zh_tw = "選擇顯示語言｡",
    },

    CCW_DESC = {
        en = "Rotate counter-clockwise.",
        ja = "ﾋﾀﾞﾘ ｶｲﾃﾝ｡",
        zh_cn = "左旋转｡",
        zh_tw = "左旋轉｡",
    },
    CW_DESC = {
        en = "Rotate clockwise.",
        ja = "ﾐｷﾞ ｶｲﾃﾝ｡",
        zh_cn = "右旋转｡",
        zh_tw = "右旋轉｡",
    },
    ROT180_DESC = {
        en = "Rotate 180 degrees.",
        ja = "180ﾄﾞ ｶｲﾃﾝ｡",
        zh_cn = "180度旋转｡",
        zh_tw = "180度旋轉｡",
    },
    HOLD_DESC = {
        en = "Hold current piece.",
        ja = "ﾋﾟｰｽｦ ﾎｰﾙﾄﾞ｡",
        zh_cn = "当前方块暂存｡",
        zh_tw = "目前方塊暫存｡",
    },
    HARD_DROP_DESC = {
        en = "Drop instantly.",
        ja = "ｽｸﾞ ﾗｯｶ｡",
        zh_cn = "硬降落｡",
        zh_tw = "硬降落｡",
    },
    SOFT_DROP_DESC = {
        en = "Move piece downward.",
        ja = "ｼﾀﾍ ﾄﾞﾛｯﾌﾟ｡",
        zh_cn = "软降落｡",
        zh_tw = "軟降落｡",
    },
    LEFT_DESC = {
        en = "Move piece left.",
        ja = "ﾋﾀﾞﾘﾍ ﾑｰﾌﾞ｡",
        zh_cn = "方块向左移动｡",
        zh_tw = "方塊向左移動｡",
    },
    RIGHT_DESC = {
        en = "Move piece right.",
        ja = "ﾐｷﾞﾍ ﾑｰﾌﾞ｡",
        zh_cn = "方块向右移动｡",
        zh_tw = "方塊向右移動｡",
    },
}

function locale.get(key)
    local entry = locale.t[key]
    if not entry then return key end
    return entry[locale.current] or entry.en or key
end

return locale
