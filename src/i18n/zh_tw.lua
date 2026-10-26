local i18n = {}

i18n.info = {
    id = "zh_tw",
    name = "繁體中文"
}

i18n.text = {
    SELECT_LANGUAGE = "選擇語言",

    BACK_TIP = "⎋ 返回",

    RESET = "恢復預設",
    RESET_DESC = "將設定恢復為預設｡",

    YES_SYMBOL = "✓",
    NO_SYMBOL = "✕",

    READY = "準備",
    GO = "開始",

    START = "開始",
    START_DESC = "開始遊戲!",

    ABOUT = "關於",
    ABOUT_DESC = "關於«像素立方»｡",

    ABOUT_GAME = "遊戲",
    ABOUT_GAME_DESC = "像素立方 %s\r\n\n使用 LÖVE 開發｡",

    ENVIRONMENT = "執行環境",
    ENVIRONMENT_DESC = "執行環境:\r\n\nLÖVE   %s\r\n%s\r\n%s\r\nOS     %s\r\n\nGOTO FORWARD   %s\r\nGOTO BACKWARD  %s\r\nBIT OPERATOR   %s\r\nIDIV OPERATOR  %s",

    SOURCE = "原始碼",
    SOURCE_DESC = "原始碼:\r\n\nGitHub:\r\nSennoma-Nn/pixmino\r\n\n以 GPLv3 授權釋出｡\r\n🄯 2026 Sennoma-Nn",

    SP_THANKS = "特別感謝",
    SP_THANKS_DESC = "特別感謝",

    SP_PUSH = "PUSH",
    SP_PUSH_DESC = "Ulydev:\r\n\n用於 LÖVE 的 Push 函式庫｡ (MIT)",

    SP_NATIVEFS = "NATIVEFS",
    SP_NATIVEFS_DESC = "Engineer Smith:\r\n\n存取 LÖVE 沙箱外檔案系統的函式庫｡ (MIT)",

    SP_JSON = "JSON",
    SP_JSON_DESC = "rxi:\r\n\nLua 的 JSON 函式庫｡ (MIT)",

    SP_IBFULL = "IB-FULL",
    SP_IBFULL_DESC = "Soda 261:\r\n\n製作｢IB-FULL｣字型,\r\n用於顯示遊戲資訊｡",

    SP_QUANPIXEL = "全小素",
    SP_QUANPIXEL_DESC = "Galmuri8, Chill Bitmap,\r\nDiaowinner:\r\n\n｢全小素8PX｣字型,用於顯示中文｡ \r\n(OFL 1.1)",

    NAME_MILKYAO = "繆錁堯 - MilkYao",

    SP_BGM = "BGM",
    SP_BGM_DESC = "繆錁堯 - MilkYao:\r\n\n製作遊戲全部BGM｡",

    SP_SFX = "SFX",
    SP_SFX_DESC = "mOsh:\r\n\n8BIT SFX 庫｡ (CC0)",

    SP_DEEPSEEK = "DEEPSEEK",
    SP_DEEPSEEK_DESC = "DeepSeek:\r\n\n用於程式碼審查､補全､以及部分程式碼的編寫｡",

    PAUSE = "暫停",
    GAME_OVER = "遊戲結束",
    CLEAR = "通關",
    BEST = "最佳",
    CONTINUE = "繼續",
    RESTART = "重開",
    QUIT = "結束",
    QUIT_DESC = "結束遊戲｡",

    SETTINGS = "設定",
    SETTINGS_DESC = "調整遊戲設定｡\r\n\n◄ X ► 按下 ←/→ 鍵改變\r\n- X - 按下 ↩ 鍵切換\r\n[ X ] 按下 ↩ 鍵後輸入一個按鍵",

    JMP_CTRL = "操作",
    JMP_KEYS = "按鍵",

    DISPLAY = "顯示",
    DISPLAY_DESC = "調整顯示設定｡",

    SOUND = "聲音",
    SOUND_DESC = "調整聲音設定｡",

    INPUT = "輸入",
    INPUT_DESC = "調整輸入設定｡",

    CONSOLE = "除錯主控臺",
    CONSOLE_DESC = "開啟除錯主控臺｡",

    FIXED_STEP = "固定步長",
    FIXED_STEP_DESC = "~~ 固定步長 ~~\r\n\n如果你需要進行一些高精度操作,這些操作\r\n可能因為一些不確定的波動影響帶來\r\n不確定性,開啓後會鎖定60Hz執行邏輯\r\n不受螢幕更新率影響｡",

    FULLSCREEN = "全螢幕",
    FULLSCREEN_DESC = "切換全螢幕｡",

    PLAYFIELD_ALPHA = "場地背景不透明度",
    PLAYFIELD_ALPHA_DESC = "設定場地背景的不透明度｡",

    LANGUAGE = "語言",
    LANGUAGE_DESC = "選擇顯示語言｡",

    MUSIC_VOL = "音樂音量",
    MUSIC_VOL_DESC = "設定音樂音量｡",

    SFX_VOL = "音效音量",
    SFX_VOL_DESC = "設定音效音量｡",

    DAS = "自動移動延遲",
    DAS_DESC = "~~ 自動移動延遲 (ASD) ~~\r\n\n按下移動鍵,\r\n到形狀開始以固定速度\r\n自動連續移動的間隔時間｡",

    ARR = "自動移動週期",
    ARR_DESC = "~~ 自動移動週期 (ASP) ~~\r\n\n在形狀以固定速度自動連續移動時,\r\n兩次移動之間的間隔時間｡",

    DP_ARR = "軟降自動移動週期",
    DP_ARR_DESC = "~~ 軟降自動移動週期 (DP.ASP) ~~\r\n\n按下軟降鍵後開始的連續下降,\r\n兩次降落之間的間隔時間｡",

    DP_LOCK = "軟降鎖定",
    DP_LOCK_DESC = "~~ 軟降鎖定 ~~\r\n\n開啟後,軟降時下方有方塊,形狀會立即鎖定｡",

    PREOP = "預輸入",
    PREOP_DESC = "~~ 預輸入 ~~\r\n\n新的形狀入場時\r\n提前按住按鍵立即觸發\r\n旋轉､移動或暫存｡",

    SPAWN_MARK = "出生標記",
    SPAWN_MARK_DESC = "在場地上標記下個形狀的出現位置｡",

    KEY_INFO = "按鍵顯示",
    KEY_INFO_DESC = "遊戲中在畫面上方顯示目前按下的按鍵｡",

    EZ_READ = "閱讀輔助",
    EZ_READ_DESC = "給標點符號､日文濁音/半濁音､按鍵符號\r\n添加顏色以方便閱讀｡",

    SKIN = "皮膚",
    SKIN_DESC = "選擇方塊皮膚｡",

    SPLIT_MINOS = "切斷形狀",
    SPLIT_MINOS_DESC = "如果把一個形狀的中間部分消除,\r\n那麼形狀的上下兩端將不會連接在一起｡",

    BLOCK_CONNECT = "方塊連接方式",
    BLOCK_CONNECT_DESC = "選擇相同形狀的方塊的連接方式｡",

    MINO_COLOR = "形狀顏色",
    MINO_COLOR_DESC = "調整各形狀的顏色｡",

    MINO_COLOR_SETTING_DESC = "調整形狀 %s 的顏色｡",

    COLOR_R = "紅",
    COLOR_R_DESC = "調整形狀 %s 的紅色量｡",

    COLOR_G = "綠",
    COLOR_G_DESC = "調整形狀 %s 的綠色量｡",

    COLOR_B = "藍",
    COLOR_B_DESC = "調整形狀 %s 的藍色量｡",

    CCW = "左轉",
    CW = "右轉",
    ROT180 = "翻轉",
    HOLD = "暫存",
    HARD_DROP = "硬降",
    SOFT_DROP = "軟降",
    SOFT_DROP_BOTTOM = "瞬降",
    LEFT = "左移",
    RIGHT = "右移",

    PRESS_KEY_TIP = "請按下按鍵...",
    CLEAR_KEY_TIP = "按下 ⌦ 鍵清除按鍵綁定｡",

    MARATHON = "馬拉松",
    MARATHON_DESC = "消除150列,\r\n以分數為目標,向更高分衝刺!",

    SPRINT = "競速",
    SPRINT_DESC = "消除40列,\r\n以速度為目標,時間越短越好!",

    MASTER = "大師",
    MASTER_DESC = "消除300列,\r\n形狀直接落地,\r\n操作時間越來越短!",

    NO_MOVE = "禁止移動!?",

    JMP_CTRL_DESC = "調整遊戲操作｡",
    JMP_KEYS_DESC = "為每個動作指派按鍵｡",

    CCW_DESC = "左旋轉｡",
    CW_DESC = "右旋轉｡",
    ROT180_DESC = "180度旋轉｡",
    HOLD_DESC = "目前形狀暫存｡",
    HARD_DROP_DESC = "硬降落｡",
    SOFT_DROP_DESC = "軟降落｡",
    SOFT_DROP_BOTTOM_DESC = "降落到最底部,但不立即鎖定｡",
    LEFT_DESC = "形狀向左移動｡",
    RIGHT_DESC = "形狀向右移動｡",
}

return i18n
