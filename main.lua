-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local push = require("lib.push")
local vgafont = require("lib.vgafont")
local menu = require("menu")

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

local colors = {
    yellow       = { 1, 0.8, 0, 1 },
    white        = { 1, 1, 1, 1 },
    light_gray   = { 0.75, 0.75, 0.75, 1 },
    gray         = { 0.5, 0.5, 0.5, 1 },
    black        = { 0, 0, 0, 1 },
    out_line     = { 0, 0, 0, 1 },
    playfield_bg = { 0, 0, 0, 0.6 },
    background   = { 0.1, 0.1, 0.15 },
}

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")

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
        vgafont.load("font/QUADBM.F08",       "cp437"),
        vgafont.load("font/SYMBOL.F08",       "symbol"),
    }
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

    love.graphics.setColor(unpack(colors.playfield_bg))
    love.graphics.rectangle("fill", gx, gy, pw, ph)

    love.graphics.setColor(unpack(colors.white))
    love.graphics.rectangle("fill", gx - bw, gy - bw, pw + bw * 2, bw)
    love.graphics.rectangle("fill", gx - bw, gy + ph, pw + bw * 2, bw)
    love.graphics.rectangle("fill", gx - bw, gy, bw, ph)
    love.graphics.rectangle("fill", gx + pw, gy, bw, ph)

    draw_game_info(gx, gy, pw, ph, bw)

    if menu.state ~= "GAME" then
        menu.draw(gx, gy, pw, ph, bw, colors, ui_fonts)
    end

    push:apply("end")
end

function love.update(dt)
    if menu.state == "GAME" then
        time = time + dt
    end
end

function love.keypressed(key)
    if key == "f4" then
        push:switchFullscreen()
        return
    end

    if menu.state == "GAME" then
        if key == "escape" then
            reset_game_stats()
            menu.go_to("MENU_MAIN")
        end
        return
    end

    if menu.keypressed(key) then
        return
    end
end

function love.resize(w, h)
    push:resize(w, h)
end
