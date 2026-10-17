local i18n = {}

i18n.info = {
    id = "en",
    name = "ENGLISH"
}

i18n.text = {
    SELECT_LANGUAGE = "SELECT LANGUAGE",

    BACK_TIP = "⎋ BACK",

    RESET = "RESET",
    RESET_DESC = "Restore settings to\r\ndefault.",

    YES_SYMBOL = "✓",
    NO_SYMBOL = "✕",

    READY = "READY",
    GO = "GO",

    START = "START",
    START_DESC = "Start Game!",

    ABOUT = "ABOUT",
    ABOUT_DESC = "About PIXMINO.",

    ABOUT_GAME = "GAME",
    ABOUT_GAME_DESC = "PIXMINO %s\r\n\nMade with LÖVE.",

    ENVIRONMENT = "RUNTIME",
    ENVIRONMENT_DESC = "Runtime environment:\r\n\nLÖVE   %s\r\n%s\r\n%s\r\nOS     %s\r\n\nGOTO FORWARD   %s\r\nGOTO BACKWARD  %s\r\nBIT OPERATOR   %s\r\nIDIV OPERATOR  %s",

    SOURCE = "SOURCE",
    SOURCE_DESC = "Source Code:\r\n\nGitHub:\r\nSennoma-Nn/pixmino\r\n\nLicensed under GPLv3.\r\n🄯 2026 Sennoma-Nn",

    SP_THANKS = "SP.THANKS",
    SP_THANKS_DESC = "Special Thanks",

    SP_PUSH = "PUSH",
    SP_PUSH_DESC = "Ulydev:\r\n\nLibrary Push for LÖVE.\r\n(MIT)",

    SP_NATIVEFS = "NATIVEFS",
    SP_NATIVEFS_DESC = "Engineer Smith:\r\n\nAccess files outside the\r\nLÖVE sandbox. (MIT)",

    SP_JSON = "JSON",
    SP_JSON_DESC = "rxi:\r\n\nJSON library for Lua. (MIT)",

    SP_IBFULL = "IB-FULL",
    SP_IBFULL_DESC = 'Soda 261:\r\n\nMade "IB-FULL" font,\r\nfor displaying game stats.',

    SP_QUANPIXEL = "QUANPIXEL",
    SP_QUANPIXEL_DESC = 'Galmuri8, Chill Bitmap,\r\nDiaowinner:\r\n\n"QuanPixel 8px" font,\r\nfor displaying Chinese.\r\n(OFL 1.1)',

    NAME_MILKYAO = "MilkYao",

    SP_BGM = "BGM",
    SP_BGM_DESC = "MilkYao:\r\n\nMade all BGM for the game.",

    SP_SFX = "SFX",
    SP_SFX_DESC = 'mOsh:\r\n\n8BIT SFX Library. (CC0)',

    PAUSE = "PAUSED",
    GAME_OVER = "GAME OVER",
    CLEAR = "CLEAR",
    BEST = "BEST",
    CONTINUE = "CONTINUE",
    RESTART = "RESTART",
    QUIT = "QUIT",
    QUIT_DESC = "Exit the game.",

    SETTINGS = "SETTINGS",
    SETTINGS_DESC = "Adjust game settings.\r\n\n🠸 X 🠺 ←/→ to change option\r\n- X - ↩ to toggle\r\n[ X ] ↩ then press a key",

    JMP_CTRL = "CONTROLS",
    JMP_KEYS = "KEY",

    DISPLAY = "DISPLAY",
    DISPLAY_DESC = "Adjust display settings.",

    SOUND = "SOUND",
    SOUND_DESC = "Adjust sound settings.",

    INPUT = "INPUT",
    INPUT_DESC = "Adjust input settings.",

    CONSOLE = "CONSOLE",
    CONSOLE_DESC = "Open the Debug console.",

    FIXED_STEP = "FIX STEP",
    FIXED_STEP_DESC = "~~ Fixed Step ~~\r\n\nIf you need precise\r\nactions, those may become\r\nunstable due to uncertain\r\nfluctuations.\r\nTurn on to lock logic at a\r\nfixed 60Hz, independent of\r\nscreen refresh rate.",

    FULLSCREEN = "FULL SCR.",
    FULLSCREEN_DESC = "Toggle fullscreen display.",

    LANGUAGE = "LANGUAGE",
    LANGUAGE_DESC = "Select display language.",

    MUSIC_VOL = "MUSIC VOL",
    MUSIC_VOL_DESC = "Set the music volume.",

    SFX_VOL = "SFX VOL",
    SFX_VOL_DESC = "Set the sound effect volume.",

    DAS = "ASD",
    DAS_DESC = "~~ Auto Shift Delay ~~\r\n\nThe delay from pressing\r\na move key, until the\r\nmino starts auto-shifting\r\nat a fixed speed.",

    ARR = "ASP",
    ARR_DESC = "~~ Auto Shift Period ~~\r\n\nThe interval between moves\r\nwhile a mino auto-shifts\r\nat a fixed speed.",

    DP_ARR = "DP.ASP",
    DP_ARR_DESC = "~~ Drop Auto Shift Period ~\r\n\nThe interval between drops\r\nwhile a mino drops\r\ncontinuously.",

    PREOP = "I*S",
    PREOP_DESC = "~~ Initial ** System ~~\r\n\nHold rotate, move,\r\nor hold keys and\r\nthe action triggers\r\nwhen a new mino spawns.",

    SPAWN_MARK = "SPAWN",
    SPAWN_MARK_DESC = "Mark the next mino's shape\r\nand spawn position on the\r\nfield.",

    KEY_INFO = "KEY INFO",
    KEY_INFO_DESC = "Show the pressed keys\r\nwhile playing.",

    EZ_READ = "EZ.READ",
    EZ_READ_DESC = "Color punctuation,\r\ndakuten / handakuten,\r\nand key symbol\r\nfor easier reading.",

    SKIN = "SKIN",
    SKIN_DESC = "Select the block skin.",

    SPLIT_MINOS = "SPL.MINO",
    SPLIT_MINOS_DESC = "If the middle of a mino\r\nis cleared, the top and\r\nbottom halves will not\r\nconnect together.",

    MINO_COLOR = "COLOR",
    MINO_COLOR_DESC = "Adjust each mino color.",

    MINO_COLOR_SETTING_DESC = "Adjust the color of\r\nthe %s mino.",

    COLOR_R = "RED",
    COLOR_R_DESC = "Adjust the amount of red\r\nin the %s mino.",

    COLOR_G = "GREEN",
    COLOR_G_DESC = "Adjust the amount of green\r\nin the %s mino.",

    COLOR_B = "BLUE",
    COLOR_B_DESC = "Adjust the amount of blue\r\nin the %s mino.",

    CCW = "CCW",
    CW = "CW",
    ROT180 = "ROT.180",
    HOLD = "HOLD",
    HARD_DROP = "HARD DP.",
    SOFT_DROP = "SOFT DP.",
    LEFT = "LEFT",
    RIGHT = "RIGHT",

    PRESS_KEY_TIP = "PRESS KEY...",

    MARATHON = "MARATHON",
    MARATHON_DESC = "Clear 150 lines,\r\nAim for score,\r\nchase the top!",

    SPRINT = "SPRINT",
    SPRINT_DESC = "Clear 40 lines,\r\nAim for speed,\r\nfaster is better!",

    MASTER = "MASTER",
    MASTER_DESC = "Clear 300 lines,\r\nMinos drop instantly,\r\nless time to act!",

    NO_MOVE = "NO MOVE!?",

    JMP_CTRL_DESC = "Adjust game controls.",
    JMP_KEYS_DESC = "Assign keys to each action.",

    CCW_DESC = "Rotate counter-clockwise.",
    CW_DESC = "Rotate clockwise.",
    ROT180_DESC = "Rotate 180 degrees.",
    HOLD_DESC = "Hold current mino.",
    HARD_DROP_DESC = "Drop instantly.",
    SOFT_DROP_DESC = "Move mino downward.",
    LEFT_DESC = "Move mino left.",
    RIGHT_DESC = "Move mino right.",
}

return i18n
