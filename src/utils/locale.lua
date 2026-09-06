-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local locale = {}
local dbg = require("src.game.debug")

locale.langs = { "en", "ja", "zh_cn", "zh_tw" }
locale.current = "en"

local features = dbg.detect_features()

local env_info = "LÖVE   " .. love._version .. "\r\n" ..
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
        ja = "ﾋﾟｸｾﾐﾉ " .. GAMEVER .. "\r\n\nLÖVEﾃﾞ ｻｸｾｲ｡",
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
        en = "Runtime environment:\r\n\n" .. env_info,
        ja = "ｶﾝｷｮｳ:\r\n\n" .. env_info,
        zh_cn = "运行环境:\r\n\n" .. env_info,
        zh_tw = "執行環境:\r\n\n" .. env_info,
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
        ja = "Ulydev:\r\n\nLÖVE ﾖｳ ﾗｲﾌﾞﾗﾘ Push｡\r\n(MIT)",
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
        ja = "ｾｯﾃｨﾝｸﾞ",
        zh_cn = "设置",
        zh_tw = "設定",
    },
    SETTINGS_DESC = {
        en = "Adjust game settings.",
        ja = "ｹﾞｰﾑ ｾｯﾃｨﾝｸﾞｦ ﾁｮｳｾｲ｡",
        zh_cn = "调整游戏设置｡",
        zh_tw = "調整遊戲設定｡",
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

    DAS = {
        en = "DAS",
        ja = "DAS",
        zh_cn = "自动移动延迟",
        zh_tw = "自動移動延遲",
    },
    ARR = {
        en = "ARR",
        ja = "ARR",
        zh_cn = "自动重复速率",
        zh_tw = "自動重複速率",
    },
    DP_ARR = {
        en = "DP.ARR",
        ja = "DP.ARR",
        zh_cn = "软降自动重复速率",
        zh_tw = "軟降自動重複速率",
    },

    PREOP = {
        en = "I*S",
        ja = "ｾﾝｺｳﾆｭｳﾘｮｸ",
        zh_cn = "预输入",
        zh_tw = "預輸入",
    },
    PREOP_DESC = {
        en = "Hold rotate, move,\r\nor hold keys and\r\nthe action triggers\r\nwhen a new piece spawns.",
        ja = "ｱﾀﾗｼｲﾋﾟｰｽ ｽﾎﾟｰﾝｼﾞﾆ\r\nｷｰｦ ｵｻｴﾃ ｲﾙﾄ\r\nｶｲﾃﾝ･ｲﾄﾞｳ･ﾎｰﾙﾄﾞ｡",
        zh_cn = "新方块入场时\r\n提前按住按键立即触发\r\n旋转､移动或暂存｡",
        zh_tw = "新方塊入場時\r\n提前按住按鍵立即觸發\r\n旋轉､移動或暫存｡",
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
        en = "Clear 150 lines,\r\nScore as high as possible!",
        ja = "150 ﾗｲﾝｦ ｸﾘｱ､\r\nｽｺｱｦ ﾈﾗｴ!",
        zh_cn = "清除150行,\r\n分数越高越好!",
        zh_tw = "消除150列,\r\n分數越高越好!",
    },

    SPRINT = {
        en = "SPRINT",
        ja = "40 ﾗｲﾝ",
        zh_cn = "40行",
        zh_tw = "40列",
    },
    SPRINT_DESC = {
        en = "Clear 40 lines,\r\nFinish as fast as possible!",
        ja = "40 ﾗｲﾝｦ ｸﾘｱ､\r\nﾊﾔｻｦ ｷｿｴ!",
        zh_cn = "清除40行,\r\n越快越好!",
        zh_tw = "消除40列,\r\n越快越好!",
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
        en = "Clear 200 lines,\r\nPieces drop instantly,\r\nless time to act!",
        ja = "200 ﾗｲﾝｦ ｸﾘｱ､\r\nﾌﾞﾛｯｸ ﾁｮｸｾﾂ ﾗｯｶ､\r\nｿｳｻ ｼﾞｶﾝ ﾐｼﾞｶｸ ﾅﾙ!",
        zh_cn = "清除200行,\r\n方块直接落地,\r\n操作时间越来越短!",
        zh_tw = "消除200列,\r\n方塊直接落地,\r\n操作時間越來越短!",
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
    DAS_DESC = {
        en = "Delay before auto-repeat.",
        ja = "ｼﾞﾄﾞｳ ﾚﾝｿﾞｸﾏﾃﾞﾉ ﾁｴﾝ｡",
        zh_cn = "自动移动前的延迟｡ (DAS)",
        zh_tw = "自動移動前的延遲｡ (DAS)",
    },
    ARR_DESC = {
        en = "Auto-repeat rate.",
        ja = "ｼﾞﾄﾞｳ ﾚﾝｿﾞｸ ﾚｰﾄ｡",
        zh_cn = "自动重复速率｡ (ARR)",
        zh_tw = "自動重複速率｡ (ARR)",
    },
    DP_ARR_DESC = {
        en = "Soft drop auto-repeat rate.",
        ja = "ｿﾌﾄﾄﾞﾛｯﾌﾟ ﾚﾝｿﾞｸ ﾚｰﾄ｡",
        zh_cn = "软降自动重复速率｡ (ARR)",
        zh_tw = "軟降自動重複速率｡ (ARR)",
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
