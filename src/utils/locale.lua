-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local locale = {}
local game_debug = require("src.game.debug")

locale.langs = { "en", "ja", "bpmf", "pinyin" }
locale.current = "en"

local ver = "v0.0.11"

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
        pinyin = "⎋ FǍNHUÍ",
    },

    START = {
        en = "START",
        ja = "ｽﾀｰﾄ",
        bpmf = "ㄎㄞㄕ",
        pinyin = "KĀISHǏ",
    },
    START_DESC = {
        en = "Start Game!",
        ja = "ｹﾞｰﾑｦ ｽﾀｰﾄ!",
        bpmf = "ㄎㄞ ㄕˇㄧㄡˊㄒㄧˋ!",
        pinyin = "Kāi shǐ yóu xì!",
    },

    ABOUT = {
        en = "ABOUT",
        ja = "ｾﾂﾒｲ",
        bpmf = "ㄍㄨㄢㄩ",
        pinyin = "GUĀNYÚ",
    },
    ABOUT_DESC = {
        en = "About PIXMINO.",
        ja = "ﾋﾟｸｾﾐﾉ ﾂｲﾃ｡",
        bpmf = "ㄍㄨㄢ ㄩˊ ㄊㄨㄩㄢㄌㄧㄈㄤ",
        pinyin = "Guān yú XIANGSULIFANG.",
    },

    ABOUT_GAME = {
        en = "GAME",
        ja = "ｹﾞｰﾑ",
        bpmf = "ㄧㄡㄒㄧ",
        pinyin = "YÓUXÌ",
    },
    ABOUT_GAME_DESC = {
        en = "PIXMINO " .. ver .. "\r\n\nMade with LÖVE.",
        ja = "ﾋﾟｸｾﾐﾉ " .. ver .. "\r\n\nLÖVE ﾃﾞ ｻｸｾｲ｡",
        bpmf = "ㄊㄨㄩㄢㄌㄧㄈㄤ " .. ver .. "\r\n\nㄩㄥˋLÖVE ㄎㄞ ㄈㄚ｡",
        pinyin = "XIANGSULIFANG " .. ver .. "\r\n\nYòng LÖVE kāi fā.",
    },

    ENVIRONMENT = {
        en = "RUNTIME",
        ja = "ｶﾝｷｮｳ",
        bpmf = "ㄏㄨㄢㄐㄧㄥ",
        pinyin = "HUÁNJÌNG",
    },
    ENVIRONMENT_DESC = {
        en = "Runtime environment:\r\n\n" .. env_info,
        ja = "ｶﾝｷｮｳ:\r\n\n" .. env_info,
        bpmf = "ㄏㄨㄢˊㄐㄧㄥˋ:\r\n\n" .. env_info,
        pinyin = "Huán jìng:\r\n\n" .. env_info,
    },

    SOURCE = {
        en = "SOURCE",
        ja = "ｿｰｽ",
        bpmf = "ㄩㄢㄕㄇㄚ",
        pinyin = "YUÁNDÀIMǍ",
    },
    SOURCE_DESC = {
        en = "Source Code:\r\n\nGitHub:\r\nSennoma-Nn/pixmino\r\n\nLicensed under GPLv3.\r\n🄯 2026 Sennoma-Nn",
        ja = "ｿｰｽ ｺｰﾄﾞ:\r\n\nGitHub:\r\nSennoma-Nn/pixmino\r\n\nGPLv3 ﾗｲｾﾝｽ ﾃﾞ ｺｳｶｲ｡\r\n🄯 2026 Sennoma-Nn",
        bpmf = "ㄩㄢˊㄕˇㄇㄚˇ:\r\n\nGitHub:\r\nSennoma-Nn/pixmino\r\n\nGPLv3 ㄕㄡˋㄑㄩㄢˊ｡\r\n🄯 2026 Sennoma-Nn",
        pinyin = "Yuán dài mǎ:\r\n\nGitHub:\r\nSennoma-Nn/pixmino\r\n\nGPLv3 shòu quán.\r\n🄯 2026 Sennoma-Nn",
    },

    SP_THANKS = {
        en = "SP.THANKS",
        ja = "SP.ｻﾝｸｽ",
        bpmf = "SP.ㄍㄢㄒㄧㄝ",
        pinyin = "MÍNGXIÈ",
    },
    SP_THANKS_DESC = {
        en =
        "Special Thanks:\r\n\nUlydev: (MIT)\r\n- Library Push for LÖVE.\r\n\nSoda 261:\r\n- Provided \"IB-FULL\" font\r\n  4 displaying game stats.\r\n\nmOsh: (CC0)\r\n- 8BIT SFX Library.",
        ja =
        "ｽﾍﾟｼｬﾙ ｻﾝｸｽ:\r\n\nUlydev: (MIT)\r\n- LÖVE ﾖｳ ﾗｲﾌﾞﾗﾘ Push｡\r\n\nSoda 261:\r\n- ｹﾞｰﾑ ｼﾞｮｳﾎｳ ﾋｮｳｼﾞ ﾖｳ\r\n  ｢IB-FULL｣ ﾌｫﾝﾄ ﾃｲｷｮｳ｡\r\n\nmOsh: (CC0)\r\n- 8BIT SFX ﾗｲﾌﾞﾗﾘ｡",
        bpmf =
        "ㄊㄜˋㄅㄧㄝˊㄍㄢˇㄒㄧㄝˋ:\r\n\nUlydev: (MIT)\r\n- ㄩㄥˋㄩˊLÖVE ˙ㄉㄜ Push ㄎㄨˋ｡\r\n\nSoda 261:\r\n- ㄊㄧˊㄍㄨㄥˋ｢IB-FULL｣ ㄗˋㄒㄧㄥˊ\r\n  ㄩㄥˋㄩˊㄧㄡˊㄒㄧˋㄒㄧㄣˋㄒㄧ ㄒㄧㄢˇㄕˋ｡\r\n\nmOsh: (CC0)\r\n- 8BIT SFX ㄎㄨˋ｡",
        pinyin =
        "Tè bié míng xiè:\r\n\nUlydev: (MIT)\r\n- Yòng yú LÖVE de Push kù.\r\n\nSoda 261:\r\n- Tí gōng \"IB-FULL\" zì tǐ\r\n  Yòng yú xìn xī xiǎn shì.\r\n\nmOsh: (CC0)\r\n- 8BIT SFX kù.",
    },

    PAUSE = {
        en = "PAUSED",
        ja = "ﾎﾟｰｽﾞ",
        bpmf = "PAUSED",
        pinyin = "PAUSED",
    },
    GAME_OVER = {
        en = "GAME OVER",
        ja = "ｹﾞｰﾑｵｰﾊﾞｰ",
        bpmf = "GAME OVER",
        pinyin = "GAME OVER",
    },
    BEST = {
        en = "BEST",
        ja = "ｻｲｺｳｷﾛｸ",
        bpmf = "ㄗㄨㄟˋㄐㄧㄚ",
        pinyin = "ZUÌ JIĀ",
    },
    CONTINUE = {
        en = "CONTINUE",
        ja = "ﾂﾂﾞｹ",
        bpmf = "ㄐㄧㄒㄩ",
        pinyin = "JÌXÙ",
    },
    RESTART = {
        en = "RESTART",
        ja = "ﾘｽﾀｰﾄ",
        bpmf = "ㄔㄨㄥㄎㄞ",
        pinyin = "CHÓNGKĀI",
    },
    QUIT = {
        en = "QUIT",
        ja = "ｼｭｳﾘｮｳ",
        bpmf = "ㄊㄨㄟㄔㄨ",
        pinyin = "TUÌCHŪ",
    },
    QUIT_DESC = {
        en = "Exit the game.",
        ja = "ｹﾞｰﾑｦ ｼｭｳﾘｮｳ｡",
        bpmf = "ㄊㄨㄟˋㄔㄨ ㄧㄡˊㄒㄧˋ｡",
        pinyin = "Tuì chū yóu xì.",
    },

    SETTINGS = {
        en = "SETTINGS",
        ja = "ｾｯﾃｨﾝｸﾞ",
        bpmf = "ㄕㄜㄉㄧㄥ",
        pinyin = "SHÈZHÌ",
    },
    SETTINGS_DESC = {
        en = "Adjust game settings.",
        ja = "ｹﾞｰﾑ ｾｯﾃｨﾝｸﾞｦ ﾁｮｳｾｲ｡",
        bpmf = "ㄧㄡˊㄒㄧˋㄕㄜˋㄉㄧㄥˋㄊㄧㄠˊㄓㄥˇ｡",
        pinyin = "Yóu xì shè zhì tiáo zhěng.",
    },

    JMP_CTRL = {
        en = "CONTROLS",
        ja = "ｿｳｻ",
        bpmf = "ㄘㄠㄗㄨㄛ",
        pinyin = "CĀOZUÒ",
    },
    JMP_KEYS = {
        en = "KEY",
        ja = "ｷｰ",
        bpmf = "ㄢㄐㄧㄢ",
        pinyin = "ÀNJIÀN",
    },

    FULLSCREEN = {
        en = "FULL SCR.",
        ja = "ﾌﾙｽｸﾘｰﾝ",
        bpmf = "ㄑㄩㄢㄧㄥㄇㄨ",
        pinyin = "QUÁNPÍNG",
    },
    LANGUAGE = {
        en = "LANGUAGE",
        ja = "ｹﾞﾝｺﾞ",
        bpmf = "ㄩㄧㄢ",
        pinyin = "YǓYÁN",
    },

    DAS = {
        en = "DAS",
        ja = "DAS",
        bpmf = "DAS",
        pinyin = "DAS",
    },
    ARR = {
        en = "ARR",
        ja = "ARR",
        bpmf = "ARR",
        pinyin = "ARR",
    },
    DP_ARR = {
        en = "DP.ARR",
        ja = "DP.ARR",
        bpmf = "DP.ARR",
        pinyin = "DP.ARR",
    },

    CCW = {
        en = "CCW",
        ja = "ﾋﾀﾞﾘｶｲﾃﾝ",
        bpmf = "ㄗㄨㄛㄓㄨㄢ",
        pinyin = "ZUǑZHUǍN",
    },
    CW = {
        en = "CW",
        ja = "ﾐｷﾞｶｲﾃﾝ",
        bpmf = "ㄧㄡㄓㄨㄢ",
        pinyin = "YÒUZHUǍN",
    },
    ROT180 = {
        en = "ROT.180",
        ja = "180ﾄﾞ",
        bpmf = "180 ㄉㄨ",
        pinyin = "180 DÙ",
    },
    HOLD = {
        en = "HOLD",
        ja = "ﾎｰﾙﾄﾞ",
        bpmf = "ㄗㄢㄘㄨㄣ",
        pinyin = "ZÀNCÚN",
    },
    HARD_DROP = {
        en = "HARD DP.",
        ja = "ﾊｰﾄﾞDP.",
        bpmf = "ㄧㄥㄐㄧㄤ",
        pinyin = "YÌNG DP.",
    },
    SOFT_DROP = {
        en = "SOFT DP.",
        ja = "ｿﾌﾄDP.",
        bpmf = "ㄖㄨㄢㄐㄧㄤ",
        pinyin = "RUǍN DP.",
    },
    LEFT = {
        en = "LEFT",
        ja = "ﾋﾀﾞﾘ",
        bpmf = "ㄗㄨㄛ",
        pinyin = "ZUǑ",
    },
    RIGHT = {
        en = "RIGHT",
        ja = "ﾐｷﾞ",
        bpmf = "ㄧㄡ",
        pinyin = "YÒU",
    },

    PRESS_KEY_TIP = {
        en = "PRESS KEY...",
        ja = "ｷｰｦ ｵｼﾃ...",
        bpmf = "ㄑㄧㄥㄢㄐㄧㄢ...",
        pinyin = "ÀNJIÀN...",
    },

    MARATHON = {
        en = "MARATHON",
        ja = "ﾏﾗｿﾝ",
        bpmf = "ㄇㄚㄌㄚㄙㄨㄥ",
        pinyin = "MĀLĀSŌNG",
    },
    MARATHON_DESC = {
        en = "Clear 150 lines,\r\nScore as high as possible!",
        ja = "150 ﾗｲﾝｦ ｸﾘｱ､\r\nｽｺｱｦ ﾈﾗｴ!",
        bpmf = "ㄒㄧㄠ ㄔㄨˊ150 ㄌㄧㄝˋ，\r\nㄈㄣ ㄕㄨˋㄩㄝˋㄍㄠ ㄩㄝˋㄏㄠˇ!",
        pinyin = "Xiāo chú 150 háng,\r\nFēn shù yuè gāo yuè hǎo!",
    },

    SPRINT = {
        en = "SPRINT",
        ja = "40 ﾗｲﾝ",
        bpmf = "40 ㄌㄧㄝ",
        pinyin = "40 HÁNG",
    },
    SPRINT_DESC = {
        en = "Clear 40 lines,\r\nFinish as fast as possible!",
        ja = "40 ﾗｲﾝｦ ｸﾘｱ､\r\nﾊﾔｻｦ ｷｿｴ!",
        bpmf = "ㄒㄧㄠ ㄔㄨˊ 40 ㄌㄧㄝˋ，\r\nㄩㄝˋ ㄎㄨㄞˋ ㄩㄝˋ ㄏㄠˇ!",
        pinyin = "Xiāo chú 40 háng,\r\nYuè kuài yuè hǎo!",
    },

    MASTER = {
        en = "MASTER",
        ja = "ﾏｽﾀｰ",
        bpmf = "ㄉㄚㄕ",
        pinyin = "DÀSHĪ",
    },
    MASTER_DESC = {
        en = "Clear 200 lines,\r\nPieces drop instantly,\r\nless time to act!",
        ja = "200 ﾗｲﾝｦ ｸﾘｱ､\r\nﾌﾞﾛｯｸ ﾁｮｸｾﾂ ﾗｯｶ､\r\nｿｳｻ ｼﾞｶﾝ ﾐｼﾞｶｸ ﾅﾙ!",
        bpmf = "ㄒㄧㄠ ㄔㄨˊ 200 ㄌㄧㄝˋ，\r\nㄈㄤ ㄎㄨㄞˋㄓˊㄐㄧㄝ ㄌㄨㄛˋㄉㄧˋ,\r\nㄘㄠ ㄗㄨㄛˋㄕˊㄐㄧㄢ ㄩㄝˋㄌㄞˊㄩㄝˋㄉㄨㄢˇ!",
        pinyin = "Xiāo chú 200 háng,\r\nFāng kuài zhí jiē luò dì,\r\nCāo zuò shí jiān\r\nYuè lái yuè duǎn!",
    },

    JMP_CTRL_DESC = {
        en = "Adjust game controls.",
        ja = "ｿｳｻｦ ﾁｮｳｾｲ｡",
        bpmf = "ㄘㄠ ㄗㄨㄛˋㄕㄜˋㄉㄧㄥˋㄊㄧㄠˊㄓㄥˇ｡",
        pinyin = "Cāo zuò shè zhì tiáo zhěng.",
    },
    JMP_KEYS_DESC = {
        en = "Assign keys to each action.",
        ja = "ｶｸ ｱｸｼｮﾝﾆ ｷｰｦ ﾌﾘｱﾃﾙ｡",
        bpmf = "ㄨㄟˋㄇㄟˇㄍㄜ ㄉㄨㄥˋㄗㄨㄛˋ\r\nㄈㄣ ㄆㄟˋㄢˋㄐㄧㄢˋ｡",
        pinyin = "Wèi měi gè dòng zuò\r\nFēn pèi àn jiàn.",
    },
    FULLSCREEN_DESC = {
        en = "Toggle fullscreen display.",
        ja = "ﾌﾙｽｸﾘｰﾝ ﾋｮｳｼﾞｦ ｷﾘｶｴ｡",
        bpmf = "ㄑㄧㄝ ㄏㄨㄢˋㄑㄩㄢˊㄧㄥˊㄇㄨˋ｡",
        pinyin = "Qiē huàn quán píng.",
    },
    LANGUAGE_DESC = {
        en = "Select display language.",
        ja = "ﾋｮｳｼﾞ ｹﾞﾝｺﾞｦ ｾﾝﾀｸ｡",
        bpmf = "ㄒㄩㄢˇㄗㄜˊㄒㄧㄢˇㄕˋㄩˇㄧㄢˊ｡",
        pinyin = "Xuǎn zé xiǎn shì yǔ yán.",
    },
    DAS_DESC = {
        en = "Delay before auto-repeat.",
        ja = "ｼﾞﾄﾞｳ ﾚﾝｿﾞｸﾏﾃﾞﾉ ﾁｴﾝ｡",
        bpmf = "ㄗˋㄉㄨㄥˋㄌㄧㄢˊㄒㄩˋㄑㄧㄢˊ˙ㄉㄜ\r\nㄧㄢˊㄔˊ｡",
        pinyin = "Zì dòng lián xù qián de\r\nYán chí.",
    },
    ARR_DESC = {
        en = "Auto-repeat rate.",
        ja = "ｼﾞﾄﾞｳ ﾚﾝｿﾞｸ ﾚｰﾄ｡",
        bpmf = "ㄗˋㄉㄨㄥˋㄌㄧㄢˊㄒㄩˋㄙㄨˋㄌㄩˋ｡",
        pinyin = "Zì dòng lián xù sù dù.",
    },
    DP_ARR_DESC = {
        en = "Soft drop auto-repeat rate.",
        ja = "ｿﾌﾄﾄﾞﾛｯﾌﾟ ﾚﾝｿﾞｸ ﾚｰﾄ｡",
        bpmf = "ㄖㄨㄢˇㄐㄧㄤˋㄌㄨㄛˋㄌㄧㄢˊㄒㄩˋㄙㄨˋㄌㄩˋ｡",
        pinyin = "Ruǎn jiàng lián xù sù dù.",
    },

    CCW_DESC = {
        en = "Rotate counter-clockwise.",
        ja = "ﾋﾀﾞﾘ ｶｲﾃﾝ｡",
        bpmf = "ㄗㄨㄛˇㄒㄩㄢˊㄓㄨㄢˇ｡",
        pinyin = "Zuǒ xuán zhuǎn.",
    },
    CW_DESC = {
        en = "Rotate clockwise.",
        ja = "ﾐｷﾞ ｶｲﾃﾝ｡",
        bpmf = "ㄧㄡˋㄒㄩㄢˊㄓㄨㄢˇ｡",
        pinyin = "Yòu xuán zhuǎn.",
    },
    ROT180_DESC = {
        en = "Rotate 180 degrees.",
        ja = "180ﾄﾞ ｶｲﾃﾝ｡",
        bpmf = "180 ㄉㄨˋㄒㄩㄢˊㄓㄨㄢˇ｡",
        pinyin = "180 dù xuán zhuǎn.",
    },
    HOLD_DESC = {
        en = "Hold current piece.",
        ja = "ﾋﾟｰｽｦ ﾎｰﾙﾄﾞ｡",
        bpmf = "ㄉㄤ ㄑㄧㄢˊMINO ㄗㄢˋㄘㄨㄣˊ｡",
        pinyin = "Dāng qián MINO zàn cún.",
    },
    HARD_DROP_DESC = {
        en = "Drop instantly.",
        ja = "ｽｸﾞ ﾗｯｶ｡",
        bpmf = "ㄧㄥˋㄐㄧㄤˋㄌㄨㄛˋ｡",
        pinyin = "Yìng jiàng luò.",
    },
    SOFT_DROP_DESC = {
        en = "Move piece downward.",
        ja = "ｼﾀﾍﾞ ﾄﾞﾛｯﾌﾟ｡",
        bpmf = "ㄖㄨㄢˇㄐㄧㄤˋㄌㄨㄛˋ｡",
        pinyin = "Ruǎn jiàng luò.",
    },
    LEFT_DESC = {
        en = "Move piece left.",
        ja = "ﾋﾀﾞﾘﾍﾞ ﾑｰﾌﾞ｡",
        bpmf = "MINO ㄒㄧㄤˋㄗㄨㄛˇㄧˊㄉㄨㄥˋ｡",
        pinyin = "MINO xiàng zuǒ yí dòng.",
    },
    RIGHT_DESC = {
        en = "Move piece right.",
        ja = "ﾐｷﾞﾍﾞ ﾑｰﾌﾞ｡",
        bpmf = "MINO ㄒㄧㄤˋㄧㄡˋㄧˊㄉㄨㄥˋ｡",
        pinyin = "MINO xiàng yòu yí dòng.",
    },
}

function locale.get(key)
    local entry = locale.t[key]
    if not entry then return key end
    return entry[locale.current] or entry.en or key
end

return locale
