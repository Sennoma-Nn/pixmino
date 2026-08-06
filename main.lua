local push = require("lib.push")
local vgafont = require("lib.vgafont")
local locale = require("locale")

local style = {
    block_size = 8,
    playfield_width = 2
}

local playfield = {
    width = 10,
    height = 20
}

local ui_fonts = {}
local bold_font = nil

local state = "MENU_MAIN"
local menu_selection = 1

local time = 0
local clears = 0
local scores = 0
local level = 0

local function reset_game_stats()
    time = 0
    clears = 0
    scores = 0
    level = 0
end

local menu_data = {
    MENU_MAIN = {
        {
            text_key = "START",
            desc_key = "START_DESC",
            action = function()
                state = "MENU_START"
                menu_selection = 1
            end
        },
        {
            text_key = "ABOUT",
            desc_key = "ABOUT_DESC",
            action = function()
                state = "MENU_ABOUT"
                menu_selection = 1
            end
        },
    },
    MENU_START = {
        {
            text_key = "MARATHON",
            desc_key = "MARATHON_DESC",
            action = function()
                state = "GAME"
                reset_game_stats()
            end
        },
        {
            text_key = "SPRINT",
            desc_key = "SPRINT_DESC",
            action = function()
                state = "GAME"
                reset_game_stats()
            end
        },
    },
    MENU_ABOUT = {
        {
            text_key = "ABOUT_GAME",
            desc_key = "ABOUT_GAME_DESC",
            action = false
        },
        {
            text_key = "SP_THANKS",
            desc_key = "SP_THANKS_DESC",
            action = false
        },
    },
}

local function utf8_len(text)
    local count = 0
    local i = 1
    while i <= #text do
        local byte = string.byte(text, i)
        local len
        if byte < 128 then len = 1
        elseif byte < 192 then len = 1
        elseif byte < 224 then len = 2
        elseif byte < 240 then len = 3
        else len = 4
        end
        count = count + 1
        i = i + len
    end
    return count
end

local colors = {
    yellow     = { 1, 0.8, 0, 1 },
    white      = { 1, 1, 1, 1 },
    light_gray = { 0.75, 0.75, 0.75, 1 },
    gray       = { 0.5, 0.5, 0.5, 1 },
    black      = { 0, 0, 0, 1 },
    out_line   = { 0, 0, 0, 1 },
    background = { 0.1, 0.1, 0.15 },
}

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")

    push:setupScreen(
        320 * 1, 180 * 1,
        320 * 4, 180 * 4,
        {
            pixelperfect = true,
            resizable = true,
            canvas = true
        }
    )

    bold_font = vgafont.load("font/IB-FULL.F08", "cp437")
    ui_fonts = {
        en = vgafont.load("font/QUADBM.F08",       "cp437"),
        ja = vgafont.load("font/QUADBM_CP897.F08", "jisx0201"),
    }
end

local function get_ui_font()
    return ui_fonts[locale.current]
end

local function draw_menu(gx, gy, pw, ph, bw)
    local menu = menu_data[state]
    local font = get_ui_font()
    local num_items = #menu
    local line_height = vgafont.get_height(font) + 2
    local total_h = num_items * line_height
    local start_y = gy + (ph - total_h) / 2
    local desc_x = gx + pw + bw + 8
    local desc_y = gy - 1

    for i, item in ipairs(menu) do
        local text = locale.get(item.text_key)
        local item_y = start_y + (i - 1) * line_height
        local item_x = gx + (pw - utf8_len(text) * 8) / 2

        local disabled = (item.action == false)
        local color = disabled and colors.gray or colors.white

        if i == menu_selection then
            local highlight = disabled and colors.light_gray or colors.yellow
            vgafont.print_outlined(font, text, item_x, item_y, 1, highlight, colors.out_line)

            local desc = locale.get(item.desc_key) or ""
            vgafont.print_outlined(font, desc, desc_x, desc_y, 1, colors.white, colors.out_line)
        else
            vgafont.print_outlined(font, text, item_x, item_y, 1, color, colors.out_line)
        end
    end
end

local function draw_game_info(gx, gy, pw, ph, bw)
    local ix = gx + pw + bw + 8
    local iy = gy + ph + bw - 8

    local info = {
        scores = string.format("SCORES %d", scores),
        clears = string.format("CLEARS %d", clears),
        level  = string.format("LEVEL  %d", level),
        time   = string.format("TIME   %02d:%02d.%02d",
            math.floor(time / 60),
            math.floor(time % 60),
            math.floor((time * 100) % 100)
        ),
    }

    vgafont.print_outlined(bold_font, info.scores, ix, iy - 8 * 3, 1, colors.white, colors.out_line)
    vgafont.print_outlined(bold_font, info.clears, ix, iy - 8 * 2, 1, colors.white, colors.out_line)
    vgafont.print_outlined(bold_font, info.level,  ix, iy - 8 * 1, 1, colors.white, colors.out_line)
    vgafont.print_outlined(bold_font, info.time,   ix, iy - 8 * 0, 1, colors.white, colors.out_line)
end

function love.draw()
    push:apply("start")

    love.graphics.clear(unpack(colors.background))

    local pw = playfield.width * style.block_size
    local ph = playfield.height * style.block_size
    local gy = (push:getHeight() - ph) / 2
    local gx = gy
    local bw = style.playfield_width

    love.graphics.setColor(unpack(colors.black))
    love.graphics.rectangle("fill", gx, gy, pw, ph)

    love.graphics.setColor(unpack(colors.white))
    love.graphics.rectangle("fill", gx - bw, gy - bw, pw + bw * 2, bw)
    love.graphics.rectangle("fill", gx - bw, gy + ph, pw + bw * 2, bw)
    love.graphics.rectangle("fill", gx - bw, gy, bw, ph)
    love.graphics.rectangle("fill", gx + pw, gy, bw, ph)

    draw_game_info(gx, gy, pw, ph, bw)

    if state ~= "GAME" then
        draw_menu(gx, gy, pw, ph, bw)
    end

    push:apply("end")
end

function love.update(dt)
    if state == "GAME" then
        time = time + dt
    end
end

function love.keypressed(key)
    if key == "f4" then
        push:switchFullscreen()
        return
    end

    if state == "GAME" then
        if key == "escape" then
            reset_game_stats()
            state = "MENU_MAIN"
            menu_selection = 1
        end
        return
    end

    local menu = menu_data[state]
    if not menu then return end

    if key == "up" then
        menu_selection = menu_selection - 1
        if menu_selection < 1 then
            menu_selection = #menu
        end
    elseif key == "down" then
        menu_selection = menu_selection + 1
        if menu_selection > #menu then
            menu_selection = 1
        end
    elseif key == "return" or key == "space" then
        local action = menu[menu_selection].action
        if type(action) == "function" then
            action()
        end
    elseif key == "escape" then
        if state == "MENU_START" or state == "MENU_ABOUT" then
            state = "MENU_MAIN"
            menu_selection = 1
        end
    end
end

function love.resize(w, h)
    push:resize(w, h)
end
