-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local push = require("lib.push")
local vgafont = require("lib.vgafont")
local menu = require("menu")
local game = require("game")

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

function love.draw()
    push:apply("start")

    local pw = playfield.width * style.block_size
    local ph = playfield.height * style.block_size
    local gy = (push:getHeight() - ph) / 2
    local gx = gy
    local bw = style.playfield_width

    game.draw(bold_font, colors, gx, gy, pw, ph, bw)

    if menu.state ~= "GAME" then
        menu.draw(gx, gy, pw, ph, bw, colors, ui_fonts)
    end

    push:apply("end")
end

function love.update(dt)
    if menu.state == "GAME" then
        game.update(dt)
    end
end

function love.keypressed(key)
    if key == "f4" then
        push:switchFullscreen()
        return
    end

    if menu.state == "GAME" then
        if key == "escape" then
            game.reset()
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
