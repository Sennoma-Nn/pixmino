-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local locale = {}

locale.langs = { "en", "ja" }
locale.current = "en"

local ver = "v0.0.3"

locale.t = {
    BACK_TIP = {
        en = "⎋ TO BACK",
        ja = "⎋ ﾃﾞ ﾓﾄﾞﾙ",
    },

    START = {
        en = "START",
        ja = "ｽﾀｰﾄ",
    },
    START_DESC = {
        en = "Start Game!",
        ja = "ｹﾞｰﾑｦ ｽﾀｰﾄ!",
    },

    ABOUT = {
        en = "ABOUT",
        ja = "ｾﾂﾒｲ",
    },
    ABOUT_DESC = {
        en = "About PIXMINO.",
        ja = "ﾋﾟｸｾﾐﾉ ﾂｲﾃ｡",
    },

    ABOUT_GAME = {
        en = "GAME",
        ja = "ｹﾞｰﾑ",
    },
    ABOUT_GAME_DESC = {
        en = "PIXMINO " .. ver .. "\r\nMade with LÖVE.",
        ja = "ﾋﾟｸｾﾐﾉ " .. ver .. "\r\nLÖVE ﾃﾞ ｻｸｾｲ｡",
    },

    SOURCE = {
        en = "SOURCE",
        ja = "ｿｰｽ",
    },
    SOURCE_DESC = {
        en = "Source Code:\r\n\nGitHub:\r\nSennoma-Nn/pixmino\r\n\nLicensed under GPLv3.\r\n🄯 2026 Sennoma-Nn",
        ja = "ｿｰｽ ｺｰﾄﾞ:\r\n\nGitHub:\r\nSennoma-Nn/pixmino\r\n\nGPLv3 ﾗｲｾﾝｽ ﾃﾞ ｺｳｶｲ｡\r\n🄯 2026 Sennoma-Nn",
    },

    SP_THANKS = {
        en = "SP.THANKS",
        ja = "SP.ｻﾝｸｽ",
    },
    SP_THANKS_DESC = {
        en =
        "Special Thanks:\r\n\nUlydev:\r\n- Library Push for LÖVE.\r\n\nSoda 261:\r\n- Provided \"IB-FULL\" font\r\n  4 displaying game stats.",
        ja =
        "ｽﾍﾟｼｬﾙ ｻﾝｸｽ:\r\n\nUlydev:\r\n- LÖVE ﾖｳ ﾗｲﾌﾞﾗﾘ Push｡\r\n\nSoda 261:\r\n- ｹﾞｰﾑ ｼﾞｮｳﾎｳ ﾋｮｳｼﾞ ﾖｳ\r\n  ｢IB-FULL｣ ﾌｫﾝﾄ ﾃｲｷｮｳ｡",
    },

    PAUSE = {
        en = "PAUSED",
        ja = "ﾎﾟｰｽﾞ",
    },
    GAME_OVER = {
        en = "GAME OVER",
        ja = "ｹﾞｰﾑｵｰﾊﾞｰ",
    },
    BEST = {
        en = "BEST",
        ja = "ｻｲｺｳｷﾛｸ",
    },
    CONTINUE = {
        en = "CONTINUE",
        ja = "ﾂﾂﾞｹ",
    },
    RESTART = {
        en = "RESTART",
        ja = "ﾘｽﾀｰﾄ",
    },
    QUIT = {
        en = "QUIT",
        ja = "ｼｭｳﾘｮｳ",
    },
    QUIT_DESC = {
        en = "Exit the game.",
        ja = "ｹﾞｰﾑｦ ｼｭｳﾘｮｳ｡",
    },

    SETTINGS = {
        en = "SETTINGS",
        ja = "ｾｯﾃｨﾝｸﾞ",
    },
    SETTINGS_DESC = {
        en = "Adjust game settings.",
        ja = "ｹﾞｰﾑ ｾｯﾃｨﾝｸﾞｦ ﾁｮｳｾｲ｡",
    },

    JMP_CTRL = {
        en = "CONTROLS",
        ja = "ｿｳｻ",
    },
    JMP_KEYS = {
        en = "KEY",
        ja = "ｷｰ",
    },

    FULLSCREEN = {
        en = "FULL SCR.",
        ja = "ﾌﾙｽｸﾘｰﾝ",
    },
    LANGUAGE = {
        en = "LANGUAGE",
        ja = "ｹﾞﾝｺﾞ",
    },

    DAS = {
        en = "DAS",
        ja = "DAS",
    },
    ARR = {
        en = "ARR",
        ja = "ARR",
    },
    DP_ARR = {
        en = "DP.ARR",
        ja = "DP.ARR",
    },

    CCW = {
        en = "CCW",
        ja = "ﾋｶﾞｲ",
    },
    CW = {
        en = "CW",
        ja = "ｶｲﾃﾝ",
    },
    ROT180 = {
        en = "ROT.180",
        ja = "180ﾄﾞ",
    },
    HOLD = {
        en = "HOLD",
        ja = "ﾎｰﾙﾄﾞ",
    },
    HARD_DROP = {
        en = "HARD DP.",
        ja = "ﾊｰﾄﾞDP.",
    },
    SOFT_DROP = {
        en = "SOFT DP.",
        ja = "ｿﾌﾄDP.",
    },
    LEFT = {
        en = "LEFT",
        ja = "ﾋﾀﾞﾘ",
    },
    RIGHT = {
        en = "RIGHT",
        ja = "ﾐｷﾞ",
    },

    PRESS_KEY_TIP = {
        en = "PRESS KEY...",
        ja = "ｷｰｦ ｵｼﾃ...",
    },

    MARATHON = {
        en = "MARATHON",
        ja = "ﾏﾗｿﾝ",
    },
    MARATHON_DESC = {
        en = "Clear 150 lines,\r\nScore as high as possible!",
        ja = "150 ﾗｲﾝｦ ｸﾘｱ､\r\nｽｺｱｦ ﾈﾗｴ!",
    },

    SPRINT = {
        en = "SPRINT",
        ja = "40 ﾗｲﾝ",
    },
    SPRINT_DESC = {
        en = "Clear 40 lines,\r\nFinish as fast as possible!",
        ja = "40 ﾗｲﾝｦ ｸﾘｱ､\r\nﾊﾔｻｦ ｷｿｴ!",
    },

    JMP_CTRL_DESC = {
        en = "Adjust game controls.",
        ja = "ｿｳｻｦ ﾁｮｳｾｲ｡",
    },
    JMP_KEYS_DESC = {
        en = "Assign keys to each action.",
        ja = "ｶｸ ｱｸｼｮﾝﾆ ｷｰｦ ﾌﾘｱﾃﾙ｡",
    },
    FULLSCREEN_DESC = {
        en = "Toggle fullscreen display.",
        ja = "ﾌﾙｽｸﾘｰﾝ ﾋｮｳｼﾞｦ ｷﾘｶｴ｡",
    },
    LANGUAGE_DESC = {
        en = "Select display language.",
        ja = "ﾋｮｳｼﾞ ｹﾞﾝｺﾞｦ ｾﾝﾀｸ｡",
    },
    DAS_DESC = {
        en = "Delay before auto-repeat.",
        ja = "ｼﾞﾄﾞｳ ﾚﾝｿｸﾏﾃﾞﾉ ﾁｴﾝ｡",
    },
    ARR_DESC = {
        en = "Auto-repeat rate.",
        ja = "ｼﾞﾄﾞｳ ﾚﾝｿｸ ﾚｰﾄ｡",
    },
    DP_ARR_DESC = {
        en = "Soft drop auto-repeat rate.",
        ja = "ｿﾌﾄﾄﾞﾛｯﾌﾟ ﾚﾝｿｸ ﾚｰﾄ｡",
    },

    CCW_DESC = {
        en = "Rotate counter-clockwise.",
        ja = "ﾋｶﾞｲ ﾈｼﾞﾘ｡",
    },
    CW_DESC = {
        en = "Rotate clockwise.",
        ja = "ｶｲﾃﾝ｡",
    },
    ROT180_DESC = {
        en = "Rotate 180 degrees.",
        ja = "180ﾄﾞ ﾈｼﾞﾘ｡",
    },
    HOLD_DESC = {
        en = "Hold current piece.",
        ja = "ﾋﾟｰｽｦ ﾎｰﾙﾄﾞ｡",
    },
    HARD_DROP_DESC = {
        en = "Drop instantly.",
        ja = "ｽｸﾞ ﾗｯｶ｡",
    },
    SOFT_DROP_DESC = {
        en = "Move piece downward.",
        ja = "ｼﾀﾍﾞ ﾄﾞﾛｯﾌﾟ｡",
    },
    LEFT_DESC = {
        en = "Move piece left.",
        ja = "ﾋﾀﾞﾘﾍﾞ ﾑｰﾌﾞ｡",
    },
    RIGHT_DESC = {
        en = "Move piece right.",
        ja = "ﾐｷﾞﾍﾞ ﾑｰﾌﾞ｡",
    },
}

function locale.get(key)
    local entry = locale.t[key]
    if not entry then return key end
    return entry[locale.current] or entry.en or key
end

return locale
