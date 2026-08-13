-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local locale = {}
local game_debug = require("src.game.debug")

locale.langs = { "en", "ja", "zh_cn", "zh_tw" }
locale.current = "en"

local ver = "v0.0.12"

local features = game_debug.detect_features()

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
        en = "PIXMINO " .. ver .. "\r\n\nMade with LÖVE.",
        ja = "ﾋﾟｸｾﾐﾉ " .. ver .. "\r\n\nLÖVE ﾃﾞ ｻｸｾｲ｡",
        zh_cn = "像素立方 " .. ver .. "\r\n\n使用 LÖVE 开发｡",
        zh_tw = "圖元立方 " .. ver .. "\r\n\n使用 LÖVE 開發｡",
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
        ja = "ｿｰｽ ｺｰﾄﾞ:\r\n\nGitHub:\r\nSennoma-Nn/pixmino\r\n\nGPLv3 ﾗｲｾﾝｽ ﾃﾞ ｺｳｶｲ｡\r\n🄯 2026 Sennoma-Nn",
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
        en = "Ulydev: (MIT)\r\n\nLibrary Push for LÖVE.",
        ja = "Ulydev: (MIT)\r\n\nLÖVE ﾖｳ ﾗｲﾌﾞﾗﾘ Push｡",
        zh_cn = "Ulydev: (MIT)\r\n\n用于 LÖVE 的 Push 函数库｡",
        zh_tw = "Ulydev: (MIT)\r\n\n用於 LÖVE 的 Push 函式庫｡",
    },

    SP_IBFULL = {
        en = "IB-FULL",
        ja = "IB-FULL",
        zh_cn = "IB-FULL",
        zh_tw = "IB-FULL",
    },
    SP_IBFULL_DESC = {
        en = "Soda 261:\r\n\nProvided \"IB-FULL\" font,\r\nfor displaying game stats.",
        ja = "Soda 261:\r\n\nｹﾞｰﾑ ｼﾞｮｳﾎｳ ﾋｮｳｼﾞ ﾖｳ\r\n｢IB-FULL｣ ﾌｫﾝﾄ ﾃｲｷｮｳ｡",
        zh_cn = "Soda 261:\r\n\n提供｢IB-FULL｣字体,\r\n用于显示游戏信息｡",
        zh_tw = "Soda 261:\r\n\n提供｢IB-FULL｣字型,\r\n用於顯示遊戲資訊｡",
    },

    SP_QUANPIXEL = {
        en = "QUANPIXEL",
        ja = "QUANPIXEL",
        zh_cn = "全小素",
        zh_tw = "全小素",
    },
    SP_QUANPIXEL_DESC = {
        en =
        "Galmuri8, Chill Bitmap,\r\nDiaowinner: (OFL 1.1)\r\n\nProvided \"QuanPixel 8px\" font,\r\nfor displaying Chinese characters.",
        ja = "Galmuri8, Chill Bitmap,\r\nDiaowinner: (OFL 1.1)\r\n\nﾁｭｳｺﾞｸｺﾞ ﾖｳ\r\n｢QuanPixel 8px｣ ﾌｫﾝﾄ｡",
        zh_cn = "Galmuri8, Chill Bitmap,\r\nDiaowinner: (OFL 1.1)\r\n\n提供｢全小素8PX｣字体,\r\n用于显示中文｡",
        zh_tw = "Galmuri8, Chill Bitmap,\r\nDiaowinner: (OFL 1.1)\r\n\n提供｢全小素8PX｣字型,\r\n用於顯示中文｡",
    },

    SP_SFX = {
        en = "8BIT SFX",
        ja = "8BIT SFX",
        zh_cn = "8BIT SFX",
        zh_tw = "8BIT SFX",
    },
    SP_SFX_DESC = {
        en = "mOsh: (CC0)\r\n\n8BIT SFX Library.",
        ja = "mOsh: (CC0)\r\n\n8BIT SFX ﾗｲﾌﾞﾗﾘ｡",
        zh_cn = "mOsh: (CC0)\r\n\n8BIT SFX 库｡",
        zh_tw = "mOsh: (CC0)\r\n\n8BIT SFX 庫｡",
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

    DAS = {
        en = "DAS",
        ja = "DAS",
        zh_cn = "DAS",
        zh_tw = "DAS",
    },
    ARR = {
        en = "ARR",
        ja = "ARR",
        zh_cn = "ARR",
        zh_tw = "ARR",
    },
    DP_ARR = {
        en = "DP.ARR",
        ja = "DP.ARR",
        zh_cn = "DP.ARR",
        zh_tw = "DP.ARR",
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
        zh_cn = "180度",
        zh_tw = "180度",
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
        zh_cn = "自动连续前的延迟｡",
        zh_tw = "自動連續前的延遲｡",
    },
    ARR_DESC = {
        en = "Auto-repeat rate.",
        ja = "ｼﾞﾄﾞｳ ﾚﾝｿﾞｸ ﾚｰﾄ｡",
        zh_cn = "自动连续的速度｡",
        zh_tw = "自動連續的速度｡",
    },
    DP_ARR_DESC = {
        en = "Soft drop auto-repeat rate.",
        ja = "ｿﾌﾄﾄﾞﾛｯﾌﾟ ﾚﾝｿﾞｸ ﾚｰﾄ｡",
        zh_cn = "软降连续速度｡",
        zh_tw = "軟降連續速度｡",
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
        zh_cn = "当前MINO暂存｡",
        zh_tw = "目前MINO暫存｡",
    },
    HARD_DROP_DESC = {
        en = "Drop instantly.",
        ja = "ｽｸﾞ ﾗｯｶ｡",
        zh_cn = "硬降落｡",
        zh_tw = "硬降落｡",
    },
    SOFT_DROP_DESC = {
        en = "Move piece downward.",
        ja = "ｼﾀﾍﾞ ﾄﾞﾛｯﾌﾟ｡",
        zh_cn = "软降落｡",
        zh_tw = "軟降落｡",
    },
    LEFT_DESC = {
        en = "Move piece left.",
        ja = "ﾋﾀﾞﾘﾍﾞ ﾑｰﾌﾞ｡",
        zh_cn = "MINO向左移动｡",
        zh_tw = "MINO向左移動｡",
    },
    RIGHT_DESC = {
        en = "Move piece right.",
        ja = "ﾐｷﾞﾍﾞ ﾑｰﾌﾞ｡",
        zh_cn = "MINO向右移动｡",
        zh_tw = "MINO向右移動｡",
    },
}

function locale.get(key)
    local entry = locale.t[key]
    if not entry then return key end
    return entry[locale.current] or entry.en or key
end

return locale
