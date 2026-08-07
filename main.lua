-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local push = require("lib.push")
local vgafont = require("lib.vgafont")
local menu = require("menu")
local game = require("game")
local render = require("game_draw")

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

Colors = {
    yellow       = { 1, 0.8, 0, 1 },
    white        = { 1, 1, 1, 1 },
    light_gray   = { 0.75, 0.75, 0.75, 1 },
    gray         = { 0.5, 0.5, 0.5, 1 },
    black        = { 0, 0, 0, 1 },
    out_line     = { 0, 0, 0, 1 },
    mino_border  = { 0, 0, 0, 0.2 },
    piece_border = { 0, 0, 0, 0.6 },
    ghost_border = { 1, 1, 1, 0.2 },
    playfield_bg = { 0, 0, 0, 0.6 },
    background   = { 0.1, 0.1, 0.15 },
}

Settings = {
    input = {
        das = 8,
        arr = 0,
        drop_arr = 0,
    },
    keys = {
        ccw = "z",
        cw = "x",
        rot180 = "a",
        hold = "c",
        hard_drop = "space",
        soft_drop = ".",
        left = ",",
        right = "/",
    }
}

local debug_flags = {
    piece = false,
    pf_data = false,
    wallkick = false,
}

local function das_ms()
    return Settings.input.das * (1000 / 60)
end

local function arr_ms()
    return Settings.input.arr * (1000 / 60)
end

local function drop_ms()
    return Settings.input.drop_arr * (1000 / 60)
end

local held_left  = { active = false, das_t = 0, arr_t = 0 }
local held_right = { active = false, das_t = 0, arr_t = 0 }
local held_down  = { active = false, arr_t = 0 }

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.math.setRandomSeed(os.time())

    vgafont.register_codepage("symbol", {
        [0] = "⎋",
        [1] = "©",
        [2] = "🄯",
    })

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
        vgafont.load("font/QUADBM_CP897.F08", "jisx0201"),
        vgafont.load("font/QUADBM.F08", "cp437"),
        vgafont.load("font/SYMBOL.F08", "symbol"),
    }

    game.set_debug(debug_flags)
end

function love.draw()
    push:apply("start")

    local pw = playfield.width * style.block_size
    local ph = playfield.height * style.block_size
    local gy = (push:getHeight() - ph) / 2
    local gx = gy
    local bw = style.playfield_width

    render.draw(bold_font, gx, gy, pw, ph, bw, style.block_size)

    if menu.state ~= "GAME" then
        menu.draw(gx, gy, pw, ph, bw, Colors, ui_fonts)
    end

    push:apply("end")
end

local function tick_held(held, das_ms, arr_ms, action)
    if not held.active then return end
    local ms = love.timer.getDelta() * 1000

    if arr_ms <= 0 then
        if das_ms and held.das_t < das_ms then
            held.das_t = held.das_t + ms
            return
        end
        while action() do end
        return
    end

    if das_ms and held.das_t < das_ms then
        held.das_t = held.das_t + ms
    end

    if not das_ms or held.das_t >= das_ms then
        held.arr_t = held.arr_t + ms
        while held.arr_t >= arr_ms do
            held.arr_t = held.arr_t - arr_ms
            if not action() then
                held.arr_t = 0
                break
            end
        end
    end
end

function love.update(dt)
    if menu.state == "GAME" then
        if not game.started then
            game.start(playfield)
        end
        game.update(dt)

        if held_left.active then
            tick_held(held_left, das_ms(), arr_ms(), game.move_left)
        elseif held_right.active then
            tick_held(held_right, das_ms(), arr_ms(), game.move_right)
        end

        if held_down.active then
            tick_held(held_down, nil, drop_ms(), game.soft_drop)
        end
    end
end

function love.keypressed(key)
    if key == "f4" then
        push:switchFullscreen()
        return
    end

    if menu.state == "GAME" then
        if key == "escape" then
            game.stop()
            menu.go_to("MENU_MAIN")
        end

        local k = Settings.keys
        if key == k.ccw then
            game.rotate_ccw()
        elseif key == k.cw then
            game.rotate_cw()
        elseif key == k.rot180 then
            game.rotate_180()
        elseif key == k.hold then
            game.do_hold()
        elseif key == k.hard_drop then
            game.hard_drop()
        elseif key == k.left then
            game.move_left()
            held_left.active = true; held_left.das_t = 0; held_left.arr_t = 0
            held_right.active = false
        elseif key == k.right then
            game.move_right()
            held_right.active = true; held_right.das_t = 0; held_right.arr_t = 0
            held_left.active = false
        elseif key == k.soft_drop then
            game.soft_drop()
            held_down.active = true; held_down.arr_t = 0
        end
        return
    end

    if menu.keypressed(key) then
        return
    end
end

function love.keyreleased(key)
    local k = Settings.keys
    if key == k.left then
        held_left.active = false
    elseif key == k.right then
        held_right.active = false
    elseif key == k.soft_drop then
        held_down.active = false
    end
end

function love.resize(w, h)
    push:resize(w, h)
end
