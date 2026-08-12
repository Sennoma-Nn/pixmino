-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local locale = {}
local game_debug = require("src.game.debug")

locale.langs = { "en", "ja", "bpmf" }
locale.current = "en"

local ver = "v0.0.10"

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
        bpmf = "⎋ ㄈㄢㄏㄨㄟ",
    },

    START = {
        en = "START",
        ja = "ｽﾀｰﾄ",
        bpmf = "ㄎㄞㄕ",
    },
    START_DESC = {
        en = "Start Game!",
        ja = "ｹﾞｰﾑｦ ｽﾀｰﾄ!",
        bpmf = "ㄎㄞ ㄕˇㄧㄡˊㄒㄧˋ!",
    },

    ABOUT = {
        en = "ABOUT",
        ja = "ｾﾂﾒｲ",
        bpmf = "ㄍㄨㄢㄩ",
    },
    ABOUT_DESC = {
        en = "About PIXMINO.",
        ja = "ﾋﾟｸｾﾐﾉ ﾂｲﾃ｡",
        bpmf = "ㄍㄨㄢ ㄩˊ ㄊㄨㄩㄢㄌㄧㄈㄤ",
    },

    ABOUT_GAME = {
        en = "GAME",
        ja = "ｹﾞｰﾑ",
        bpmf = "ㄧㄡㄒㄧ",
    },
    ABOUT_GAME_DESC = {
        en = "PIXMINO " .. ver .. "\r\n\nMade with LÖVE.",
        ja = "ﾋﾟｸｾﾐﾉ " .. ver .. "\r\n\nLÖVE ﾃﾞ ｻｸｾｲ｡",
        bpmf = "ㄊㄨㄩㄢㄌㄧㄈㄤ " .. ver .. "\r\n\nㄩㄥˋLÖVE ㄎㄞ ㄈㄚ｡",
    },

    ENVIRONMENT = {
        en = "RUNTIME",
        ja = "ｶﾝｷｮｳ",
        bpmf = "ㄏㄨㄢㄐㄧㄥ",
    },
    ENVIRONMENT_DESC = {
        en = "Runtime environment:\r\n\n" .. env_info,
        ja = "ｶﾝｷｮｳ:\r\n\n" .. env_info,
        bpmf = "ㄏㄨㄢˊㄐㄧㄥˋ:\r\n\n" .. env_info,
    },

    SOURCE = {
        en = "SOURCE",
        ja = "ｿｰｽ",
        bpmf = "ㄩㄢㄕㄇㄚ",
    },
    SOURCE_DESC = {
        en = "Source Code:\r\n\nGitHub:\r\nSennoma-Nn/pixmino\r\n\nLicensed under GPLv3.\r\n🄯 2026 Sennoma-Nn",
        ja = "ｿｰｽ ｺｰﾄﾞ:\r\n\nGitHub:\r\nSennoma-Nn/pixmino\r\n\nGPLv3 ﾗｲｾﾝｽ ﾃﾞ ｺｳｶｲ｡\r\n🄯 2026 Sennoma-Nn",
        bpmf = "ㄩㄢˊㄕˇㄇㄚˇ:\r\n\nGitHub:\r\nSennoma-Nn/pixmino\r\n\nGPLv3 ㄕㄡˋㄑㄩㄢˊ｡\r\n🄯 2026 Sennoma-Nn",
    },

    SP_THANKS = {
        en = "SP.THANKS",
        ja = "SP.ｻﾝｸｽ",
        bpmf = "SP.ㄍㄢㄒㄧㄝ",
    },
    SP_THANKS_DESC = {
        en =
        "Special Thanks:\r\n\nUlydev: (MIT)\r\n- Library Push for LÖVE.\r\n\nSoda 261:\r\n- Provided \"IB-FULL\" font\r\n  4 displaying game stats.\r\n\nmOsh: (CC0)\r\n- 8BIT SFX Library.",
        ja =
        "ｽﾍﾟｼｬﾙ ｻﾝｸｽ:\r\n\nUlydev: (MIT)\r\n- LÖVE ﾖｳ ﾗｲﾌﾞﾗﾘ Push｡\r\n\nSoda 261:\r\n- ｹﾞｰﾑ ｼﾞｮｳﾎｳ ﾋｮｳｼﾞ ﾖｳ\r\n  ｢IB-FULL｣ ﾌｫﾝﾄ ﾃｲｷｮｳ｡\r\n\nmOsh: (CC0)\r\n- 8BIT SFX ﾗｲﾌﾞﾗﾘ｡",
        bpmf =
        "ㄊㄜˋㄅㄧㄝˊㄍㄢˇㄒㄧㄝˋ:\r\n\nUlydev: (MIT)\r\n- ㄩㄥˋㄩˊLÖVE ˙ㄉㄜ Push ㄎㄨˋ｡\r\n\nSoda 261:\r\n- ㄊㄧˊㄍㄨㄥˋ｢IB-FULL｣ ㄗˋㄒㄧㄥˊ\r\n  ㄩㄥˋㄩˊㄧㄡˊㄒㄧˋㄒㄧㄣˋㄒㄧ ㄒㄧㄢˇㄕˋ｡\r\n\nmOsh: (CC0)\r\n- 8BIT SFX ㄎㄨˋ｡",
    },

    PAUSE = {
        en = "PAUSED",
        ja = "ﾎﾟｰｽﾞ",
        bpmf = "PAUSED",
    },
    GAME_OVER = {
        en = "GAME OVER",
        ja = "ｹﾞｰﾑｵｰﾊﾞｰ",
        bpmf = "GAME OVER",
    },
    BEST = {
        en = "BEST",
        ja = "ｻｲｺｳｷﾛｸ",
        bpmf = "ㄗㄨㄟˋㄐㄧㄚ",
    },
    CONTINUE = {
        en = "CONTINUE",
        ja = "ﾂﾂﾞｹ",
        bpmf = "ㄐㄧㄒㄩ",
    },
    RESTART = {
        en = "RESTART",
        ja = "ﾘｽﾀｰﾄ",
        bpmf = "ㄔㄨㄥㄎㄞ",
    },
    QUIT = {
        en = "QUIT",
        ja = "ｼｭｳﾘｮｳ",
        bpmf = "ㄊㄨㄟㄔㄨ",
    },
    QUIT_DESC = {
        en = "Exit the game.",
        ja = "ｹﾞｰﾑｦ ｼｭｳﾘｮｳ｡",
        bpmf = "ㄊㄨㄟˋㄔㄨ ㄧㄡˊㄒㄧˋ｡",
    },

    SETTINGS = {
        en = "SETTINGS",
        ja = "ｾｯﾃｨﾝｸﾞ",
        bpmf = "ㄕㄜㄉㄧㄥ",
    },
    SETTINGS_DESC = {
        en = "Adjust game settings.",
        ja = "ｹﾞｰﾑ ｾｯﾃｨﾝｸﾞｦ ﾁｮｳｾｲ｡",
        bpmf = "ㄧㄡˊㄒㄧˋㄕㄜˋㄉㄧㄥˋㄊㄧㄠˊㄓㄥˇ｡",
    },

    JMP_CTRL = {
        en = "CONTROLS",
        ja = "ｿｳｻ",
        bpmf = "ㄘㄠㄗㄨㄛ",
    },
    JMP_KEYS = {
        en = "KEY",
        ja = "ｷｰ",
        bpmf = "ㄢㄐㄧㄢ",
    },

    FULLSCREEN = {
        en = "FULL SCR.",
        ja = "ﾌﾙｽｸﾘｰﾝ",
        bpmf = "ㄑㄩㄢㄧㄥㄇㄨ",
    },
    LANGUAGE = {
        en = "LANGUAGE",
        ja = "ｹﾞﾝｺﾞ",
        bpmf = "ㄩㄧㄢ",
    },

    DAS = {
        en = "DAS",
        ja = "DAS",
        bpmf = "DAS",
    },
    ARR = {
        en = "ARR",
        ja = "ARR",
        bpmf = "ARR",
    },
    DP_ARR = {
        en = "DP.ARR",
        ja = "DP.ARR",
        bpmf = "DP.ARR",
    },

    CCW = {
        en = "CCW",
        ja = "ﾋﾀﾞﾘｶｲﾃﾝ",
        bpmf = "ㄗㄨㄛㄓㄨㄢ",
    },
    CW = {
        en = "CW",
        ja = "ﾐｷﾞｶｲﾃﾝ",
        bpmf = "ㄧㄡㄓㄨㄢ",
    },
    ROT180 = {
        en = "ROT.180",
        ja = "180ﾄﾞ",
        bpmf = "180 ㄉㄨ",
    },
    HOLD = {
        en = "HOLD",
        ja = "ﾎｰﾙﾄﾞ",
        bpmf = "ㄗㄢㄘㄨㄣ",
    },
    HARD_DROP = {
        en = "HARD DP.",
        ja = "ﾊｰﾄﾞDP.",
        bpmf = "ㄧㄥㄐㄧㄤ",
    },
    SOFT_DROP = {
        en = "SOFT DP.",
        ja = "ｿﾌﾄDP.",
        bpmf = "ㄖㄨㄢㄐㄧㄤ",
    },
    LEFT = {
        en = "LEFT",
        ja = "ﾋﾀﾞﾘ",
        bpmf = "ㄗㄨㄛ",
    },
    RIGHT = {
        en = "RIGHT",
        ja = "ﾐｷﾞ",
        bpmf = "ㄧㄡ",
    },

    PRESS_KEY_TIP = {
        en = "PRESS KEY...",
        ja = "ｷｰｦ ｵｼﾃ...",
        bpmf = "ㄑㄧㄥㄢㄐㄧㄢ...",
    },

    MARATHON = {
        en = "MARATHON",
        ja = "ﾏﾗｿﾝ",
        bpmf = "ㄇㄚㄌㄚㄙㄨㄥ",
    },
    MARATHON_DESC = {
        en = "Clear 150 lines,\r\nScore as high as possible!",
        ja = "150 ﾗｲﾝｦ ｸﾘｱ､\r\nｽｺｱｦ ﾈﾗｴ!",
        bpmf = "ㄒㄧㄠ ㄔㄨˊ150 ㄌㄧㄝˋ，\r\nㄈㄣ ㄕㄨˋㄩㄝˋㄍㄠ ㄩㄝˋㄏㄠˇ!",
    },

    SPRINT = {
        en = "SPRINT",
        ja = "40 ﾗｲﾝ",
        bpmf = "40 ㄌㄧㄝ",
    },
    SPRINT_DESC = {
        en = "Clear 40 lines,\r\nFinish as fast as possible!",
        ja = "40 ﾗｲﾝｦ ｸﾘｱ､\r\nﾊﾔｻｦ ｷｿｴ!",
        bpmf = "ㄒㄧㄠ ㄔㄨˊ 40 ㄌㄧㄝˋ，\r\nㄩㄝˋ ㄎㄨㄞˋ ㄩㄝˋ ㄏㄠˇ!",
    },

    MASTER = {
        en = "MASTER",
        ja = "ﾏｽﾀｰ",
        bpmf = "ㄉㄚㄕ",
    },
    MASTER_DESC = {
        en = "Clear 200 lines,\r\n20G with shorter lock delay!",
        ja = "200 ﾗｲﾝｦ ｸﾘｱ､\r\nﾛｯｸ ﾁｴﾝ ﾐｼﾞｶｸ ﾅﾙ 20G!",
        bpmf = "ㄒㄧㄠ ㄔㄨˊ 200 ㄌㄧㄝˋ，\r\n20G ㄅㄧㄥˋ ㄑㄧㄝˇ ㄙㄨㄛˇ ㄉㄧㄥˋ ㄍㄥˋ ㄎㄨㄞˋ!",
    },

    JMP_CTRL_DESC = {
        en = "Adjust game controls.",
        ja = "ｿｳｻｦ ﾁｮｳｾｲ｡",
        bpmf = "ㄘㄠ ㄗㄨㄛˋㄕㄜˋㄉㄧㄥˋㄊㄧㄠˊㄓㄥˇ｡",
    },
    JMP_KEYS_DESC = {
        en = "Assign keys to each action.",
        ja = "ｶｸ ｱｸｼｮﾝﾆ ｷｰｦ ﾌﾘｱﾃﾙ｡",
        bpmf = "ㄨㄟˋㄇㄟˇㄍㄜ ㄉㄨㄥˋㄗㄨㄛˋ\r\nㄈㄣ ㄆㄟˋㄢˋㄐㄧㄢˋ｡",
    },
    FULLSCREEN_DESC = {
        en = "Toggle fullscreen display.",
        ja = "ﾌﾙｽｸﾘｰﾝ ﾋｮｳｼﾞｦ ｷﾘｶｴ｡",
        bpmf = "ㄑㄧㄝ ㄏㄨㄢˋㄑㄩㄢˊㄧㄥˊㄇㄨˋ｡",
    },
    LANGUAGE_DESC = {
        en = "Select display language.",
        ja = "ﾋｮｳｼﾞ ｹﾞﾝｺﾞｦ ｾﾝﾀｸ｡",
        bpmf = "ㄒㄩㄢˇㄗㄜˊㄒㄧㄢˇㄕˋㄩˇㄧㄢˊ｡",
    },
    DAS_DESC = {
        en = "Delay before auto-repeat.",
        ja = "ｼﾞﾄﾞｳ ﾚﾝｿﾞｸﾏﾃﾞﾉ ﾁｴﾝ｡",
        bpmf = "ㄗˋㄉㄨㄥˋㄌㄧㄢˊㄒㄩˋㄑㄧㄢˊ˙ㄉㄜ\r\nㄧㄢˊㄔˊ｡",
    },
    ARR_DESC = {
        en = "Auto-repeat rate.",
        ja = "ｼﾞﾄﾞｳ ﾚﾝｿﾞｸ ﾚｰﾄ｡",
        bpmf = "ㄗˋㄉㄨㄥˋㄌㄧㄢˊㄒㄩˋㄙㄨˋㄌㄩˋ｡",
    },
    DP_ARR_DESC = {
        en = "Soft drop auto-repeat rate.",
        ja = "ｿﾌﾄﾄﾞﾛｯﾌﾟ ﾚﾝｿﾞｸ ﾚｰﾄ｡",
        bpmf = "ㄖㄨㄢˇㄐㄧㄤˋㄌㄨㄛˋㄌㄧㄢˊㄒㄩˋㄙㄨˋㄌㄩˋ｡",
    },

    CCW_DESC = {
        en = "Rotate counter-clockwise.",
        ja = "ﾋﾀﾞﾘ ｶｲﾃﾝ｡",
        bpmf = "ㄗㄨㄛˇㄒㄩㄢˊㄓㄨㄢˇ｡",
    },
    CW_DESC = {
        en = "Rotate clockwise.",
        ja = "ﾐｷﾞ ｶｲﾃﾝ｡",
        bpmf = "ㄧㄡˋㄒㄩㄢˊㄓㄨㄢˇ｡",
    },
    ROT180_DESC = {
        en = "Rotate 180 degrees.",
        ja = "180ﾄﾞ ｶｲﾃﾝ｡",
        bpmf = "180 ㄉㄨˋㄒㄩㄢˊㄓㄨㄢˇ｡",
    },
    HOLD_DESC = {
        en = "Hold current piece.",
        ja = "ﾋﾟｰｽｦ ﾎｰﾙﾄﾞ｡",
        bpmf = "ㄉㄤ ㄑㄧㄢˊㄒㄧㄥˊㄓㄨㄤˋㄗㄢˋㄘㄨㄣˊ｡",
    },
    HARD_DROP_DESC = {
        en = "Drop instantly.",
        ja = "ｽｸﾞ ﾗｯｶ｡",
        bpmf = "ㄧㄥˋㄐㄧㄤˋㄌㄨㄛˋ｡",
    },
    SOFT_DROP_DESC = {
        en = "Move piece downward.",
        ja = "ｼﾀﾍﾞ ﾄﾞﾛｯﾌﾟ｡",
        bpmf = "ㄖㄨㄢˇㄐㄧㄤˋㄌㄨㄛˋ｡",
    },
    LEFT_DESC = {
        en = "Move piece left.",
        ja = "ﾋﾀﾞﾘﾍﾞ ﾑｰﾌﾞ｡",
        bpmf = "MINO ㄒㄧㄤˋㄗㄨㄛˇㄧˊㄉㄨㄥˋ｡",
    },
    RIGHT_DESC = {
        en = "Move piece right.",
        ja = "ﾐｷﾞﾍﾞ ﾑｰﾌﾞ｡",
        bpmf = "MINO ㄒㄧㄤˋㄧㄡˋㄧˊㄉㄨㄥˋ｡",
    },
}

function locale.get(key)
    local entry = locale.t[key]
    if not entry then return key end
    return entry[locale.current] or entry.en or key
end

return locale
