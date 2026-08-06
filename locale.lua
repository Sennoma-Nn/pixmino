-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local locale = {}

locale.langs = { "en", "ja" }
locale.current = "en"

local ver = "DEMO"

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
        en = "About PIXTRIS.",
        ja = "ﾋﾟｸｾﾄﾘｽﾆ ﾂｲﾃ｡",
    },

    ABOUT_GAME = {
        en = "GAME",
        ja = "ｹﾞｰﾑ",
    },
    ABOUT_GAME_DESC = {
        en = "PIXTRIS " .. ver .. "\r\nMade with LÖVE.",
        ja = "ﾋﾟｸｾﾄﾘｽ " .. ver .. "\r\nLÖVE ﾃﾞ ｻｸｾｲ｡",
    },

    SOURCE = {
        en = "SOURCE",
        ja = "ｿｰｽ",
    },
    SOURCE_DESC = {
        en = "Source Code:\r\n\nGitHub:\r\nSennoma-Nn/pixtris\r\n\nLicensed under GPLv3.\r\n🄯 2026 Sennoma-Nn",
        ja = "ｿｰｽ ｺｰﾄﾞ:\r\n\nGitHub:\r\nSennoma-Nn/pixtris\r\n\nGPLv3 ﾗｲｾﾝｽ ﾃﾞ ｺｳｶｲ｡\r\n🄯 2026 Sennoma-Nn",
    },

    SP_THANKS = {
        en = "SP.THANKS",
        ja = "SP.ｻﾝｸｽ",
    },
    SP_THANKS_DESC = {
        en = "Special Thanks:\r\n\nUlydev:\r\n- Library Push for LÖVE.\r\n\nSoda 261:\r\n- Provided \"IB-FULL\" font\r\n  4 displaying game stats.",
        ja = "ｽﾍﾟｼｬﾙ ｻﾝｸｽ:\r\n\nUlydev:\r\n- LÖVE ﾖｳ ﾗｲﾌﾞﾗﾘ Push｡\r\n\nSoda 261:\r\n- ｹﾞｰﾑ ｼﾞｮｳﾎｳ ﾋｮｳｼﾞ ﾖｳ\r\n  ｢IB-FULL｣ ﾌｫﾝﾄ ﾃｲｷｮｳ｡",
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
}

function locale.get(key)
    local entry = locale.t[key]
    if not entry then return key end
    return entry[locale.current] or entry.en or key
end

return locale
