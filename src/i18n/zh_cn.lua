local i18n = {}

i18n.info = {
    id = "zh_cn",
    name = "简体中文"
}

i18n.text = {
    SELECT_LANGUAGE = "选择语言",

    BACK_TIP = "⎋ 返回",

    YES_SYMBOL = "✓",
    NO_SYMBOL = "✕",

    READY = "准备",
    GO = "开始",

    START = "开始",
    START_DESC = "开始游戏!",

    ABOUT = "关于",
    ABOUT_DESC = "关于像素立方｡",

    ABOUT_GAME = "游戏",
    ABOUT_GAME_DESC = "像素立方 %s\r\n\n使用 LÖVE 开发｡",

    ENVIRONMENT = "运行环境",
    ENVIRONMENT_DESC = "运行环境:\r\n\nLÖVE   %s\r\n%s\r\n%s\r\nOS     %s\r\n\nGOTO FORWARD   %s\r\nGOTO BACKWARD  %s\r\nBIT OPERATOR   %s\r\nIDIV OPERATOR  %s",

    SOURCE = "源代码",
    SOURCE_DESC = "源代码:\r\n\nGitHub:\r\nSennoma-Nn/pixmino\r\n\n以 GPLv3 许可发布｡\r\n🄯 2026 Sennoma-Nn",

    SP_THANKS = "特别鸣谢",
    SP_THANKS_DESC = "特别鸣谢",

    SP_PUSH = "PUSH",
    SP_PUSH_DESC = "Ulydev:\r\n\n用于 LÖVE 的 Push 函数库｡ (MIT)",

    SP_IBFULL = "IB-FULL",
    SP_IBFULL_DESC = 'Soda 261:\r\n\n制作"IB-FULL"字体,\r\n用于显示游戏信息｡',

    SP_QUANPIXEL = "全小素",
    SP_QUANPIXEL_DESC = 'Galmuri8, Chill Bitmap,\r\nDiaowinner:\r\n\n"全小素8PX"字体,用于显示中文｡ \r\n(OFL 1.1)',

    NAME_MILKYAO = "缪锞尧 - MilkYao",

    SP_BGM = "BGM",
    SP_BGM_DESC = "缪锞尧 - MilkYao:\r\n\n制作游戏全部BGM｡",

    SP_SFX = "SFX",
    SP_SFX_DESC = 'mOsh:\r\n\n8BIT SFX 库｡ (CC0)',

    PAUSE = "暂停",
    GAME_OVER = "游戏结束",
    CLEAR = "通关",
    BEST = "最佳",
    CONTINUE = "继续",
    RESTART = "重开",
    QUIT = "退出",
    QUIT_DESC = "退出游戏｡",

    SETTINGS = "设置",
    SETTINGS_DESC = "调整游戏设置｡\r\n\n🠸 X 🠺 按下 ←/→ 键改变\r\n- X - 按下 ↩ 键切换\r\n[ X ] 按下 ↩ 键后输入一个按键",

    JMP_CTRL = "操作",
    JMP_KEYS = "按键",

    DISPLAY = "显示",
    DISPLAY_DESC = "调整显示设置｡",

    SOUND = "声音",
    SOUND_DESC = "调整声音设置｡",

    INPUT = "输入",
    INPUT_DESC = "调整输入设置｡",

    CONSOLE = "调试控制台",
    CONSOLE_DESC = "打开调试控制台｡",

    FULLSCREEN = "全屏",
    LANGUAGE = "语言",

    MUSIC_VOL = "音乐音量",
    MUSIC_VOL_DESC = "设置音乐音量｡",

    SFX_VOL = "音效音量",
    SFX_VOL_DESC = "设置音效音量｡",

    DAS = "自动延迟移动",
    DAS_DESC = "~~ 自动延迟移动 (ASD) ~~\r\n\n按下移动键,\r\n到形状开始以固定速度\r\n自动连续移动的间隔时间｡",

    ARR = "自动移动周期",
    ARR_DESC = "~~ 自动移动周期 (ASP) ~~\r\n\n在形状以固定速度自动连续移动时,\r\n两次移动之间的间隔时间｡",

    DP_ARR = "软降自动移动周期",
    DP_ARR_DESC = "~~ 软降自动移动周期 (DP.ASP) ~~\r\n\n按下软降键后开始的连续下降,\r\n两次降落之间的间隔时间｡",

    PREOP = "预输入",
    PREOP_DESC = "~~ 预输入 ~~\r\n\n新的形状入场时\r\n提前按住按键立即触发\r\n旋转､移动或暂存｡",

    SPAWN_MARK = "出生标记",
    SPAWN_MARK_DESC = "在场地上标记下个形状的出現位置｡",

    KEY_INFO = "按键显示",
    KEY_INFO_DESC = "游戏中在画面上方显示当前按下的按键｡",

    EZ_READ = "阅读辅助",
    EZ_READ_DESC = "给标点符号､日文浊音/半浊音､按键符号\r\n添加颜色以方便阅读｡",

    SKIN = "皮肤",
    SKIN_DESC = "选择方块皮肤｡",

    SPLIT_MINOS = "切断形状",
    SPLIT_MINOS_DESC = "如果把一个形状的中间部分消除,\r\n那么形状的上下两端将不会连接在一起｡",

    MINO_COLOR = "形状颜色",
    MINO_COLOR_DESC = "调整各形状的颜色｡",

    MINO_COLOR_SETTING_DESC = "调整形状 %s 的颜色｡",

    COLOR_R = "红",
    COLOR_R_DESC = "调整形状 %s 的红色量｡",

    COLOR_G = "绿",
    COLOR_G_DESC = "调整形状 %s 的绿色量｡",

    COLOR_B = "蓝",
    COLOR_B_DESC = "调整形状 %s 的蓝色量｡",

    CCW = "左转",
    CW = "右转",
    ROT180 = "翻转",
    HOLD = "暂存",
    HARD_DROP = "硬降",
    SOFT_DROP = "软降",
    LEFT = "左移",
    RIGHT = "右移",

    PRESS_KEY_TIP = "请按下按键...",

    MARATHON = "马拉松",
    MARATHON_DESC = "清除150行,\r\n以分数为目标,向更高分冲刺!",

    SPRINT = "40行",
    SPRINT_DESC = "清除40行,\r\n以速度为目标,时间越短越好!",

    MASTER = "大师",
    NO_MOVE = "禁止移动!?",
    MASTER_DESC = "清除300行,\r\n形状直接落地,\r\n操作时间越来越短!",

    JMP_CTRL_DESC = "调整游戏操作｡",
    JMP_KEYS_DESC = "为每个动作分配按键｡",
    FULLSCREEN_DESC = "切换全屏｡",
    LANGUAGE_DESC = "选择显示语言｡",

    CCW_DESC = "左旋转｡",
    CW_DESC = "右旋转｡",
    ROT180_DESC = "180度旋转｡",
    HOLD_DESC = "当前形状暂存｡",
    HARD_DROP_DESC = "硬降落｡",
    SOFT_DROP_DESC = "软降落｡",
    LEFT_DESC = "形状向左移动｡",
    RIGHT_DESC = "形状向右移动｡",
}

return i18n
