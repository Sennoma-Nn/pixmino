local locale = {}

locale.langs = { "en", "ja" }
locale.current = "en"

locale.t = {
    START = {
        en = "START",
        ja = "ｽﾀｰﾄ",
    },
    ABOUT = {
        en = "ABOUT",
        ja = "ｾﾂﾒｲ",
    },
    ABOUT_GAME = {
        en = "GAME",
        ja = "ｹﾞｰﾑ",
    },
    SP_THANKS = {
        en = "SP.THANKS",
        ja = "SP.ｻﾝｸｽ",
    },
    MARATHON = {
        en = "MARATHON",
        ja = "ﾏﾗｿﾝ",
    },
    SPRINT = {
        en = "SPRINT",
        ja = "40 ﾗｲﾝ",
    },
    START_DESC = {
        en = "Start Game!",
        ja = "ｹﾞｰﾑｦ ｽﾀｰﾄ!",
    },
    ABOUT_GAME_DESC = {
        en = "PIXTRIS V0.0.1",
        ja = "ﾋﾟｸｾﾄﾘｽ V0.0.1",
    },
    SP_THANKS_DESC = {
        en = "Special Thanks:\r\n\nUlydev:\r\nLibrary Push for LÖVE.\r\n\nSoda 261:\r\nProvided \"IB-FULL\" font.",
        ja = "ｽﾍﾟｼｬﾙ ｻﾝｸｽ:\r\n\nUlydev:\r\nLove2D ﾖｳ ﾗｲﾌﾞﾗﾘ Push｡\r\n\nSoda 261:\r\n｢IB-FULL｣ ﾌｫﾝﾄ ﾃｲｷｮｳ｡",
    },
    ABOUT_DESC = {
        en = "About PIXTRIS.",
        ja = "ﾋﾟｸｾﾄﾘｽﾆ ﾂｲﾃ｡",
    },
    MARATHON_DESC = {
        en = "Clear 150 lines,\r\nScore as high as possible!",
        ja = "150 ﾗｲﾝｦ ｸﾘｱ､\r\nｽｺｱｦ ﾈﾗｴ!",
    },
    SPRINT_DESC = {
        en = "Clear 40 lines,\r\nFinish as fast as possible!",
        ja = "40 ﾗｲﾝｦ ｸﾘｱ､\r\nﾊﾔｻｦ ｷｿｴ!",
    },
    CLEARS = {
        en = "CLEARS",
        ja = "ﾗｲﾝ",
    },
    SCORE = {
        en = "SCORE",
        ja = "ｽｺｱ",
    },
    TIME = {
        en = "TIME",
        ja = "ﾀｲﾑ",
    },
}

function locale.get(key)
    local entry = locale.t[key]
    if not entry then return key end
    return entry[locale.current] or entry.en or key
end

return locale
