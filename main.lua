-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local push = require("lib.push")
local vgafont = require("lib.vgafont")
local menu = require("src.menu.menu")
local game = require("src.game.game")
local render = require("src.game.draw")
local input = require("src.game.input")
local modes = require("src.menu.mode")
local save = require("src.utils.save")
local sfx = require("src.utils.sfx")

require("src.menu.settings")
require("custom_cp")

local style = {
    block_size = 8,
    playfield_width = 2
}

local playfield = {
    width = 10,
    height = 20
}

Fonts = {
    ui_fonts = {},
    bold_font = nil,
}

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

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.math.setRandomSeed(os.time())

    push:setupScreen(
        320 * 1, 180 * 1,
        320 * 4, 180 * 4,
        {
            pixelperfect = true,
            resizable = true,
            canvas = true
        }
    )

    Fonts.bold_font = vgafont.load("assets/font/IB-FULL.F08", "cp437")
    Fonts.ui_fonts = {
        vgafont.load("assets/font/QUADBM/CP897.F08", "jisx0201"),
        vgafont.load("assets/font/QUADBM/CP437.F08", "cp437"),
        vgafont.load("assets/font/QUADBM/ext/BPMF.F08", "bpmf"),
        vgafont.load("assets/font/QUADBM/ext/PINYIN.F08", "pinyin"),
        vgafont.load("assets/font/QUADBM/ext/SYMBOL.F08", "symbol"),
    }

    game.input_mod = input
    sfx.load()

    local fullscreen = save.load()
    if fullscreen then
        push:switchFullscreen()
    end
end

function love.draw()
    push:apply("start")

    local pw = playfield.width * style.block_size
    local ph = playfield.height * style.block_size
    local gy = (push:getHeight() - ph) / 2
    local gx = gy
    local bw = style.playfield_width

    render.draw(gx, gy, pw, ph, bw, style.block_size)

    if menu.state ~= "GAME" then
        menu.draw(gx, gy, pw, ph, bw)
    end

    push:apply("end")
end

function love.update(dt)
    if menu.state == "GAME" then
        if not game.started then
            game.start(playfield, modes[menu.selected_mode], menu.selected_mode)
            input.reset()
        end
        game.update(dt)
    end
end

function love.keypressed(key)
    if key == "f4" then
        push:switchFullscreen()
        return
    end

    if menu.state == "GAME" then
        if game.cleared then
            if key == "escape" then
                game.stop()
                menu.go_to("MENU_MAIN")
            end
            return
        end
        if game.over then
            if key == "up" then
                game.modal_move(-1)
            elseif key == "down" then
                game.modal_move(1)
            elseif key == "return" or key == "space" then
                if game.modal_choose() == "restart" then
                    game.stop()
                else
                    game.stop()
                    menu.go_to("MENU_MAIN")
                end
            elseif key == "escape" then
                game.stop()
                menu.go_to("MENU_MAIN")
            end
            return
        end
        if game.modal_active then
            if key == "escape" then
                game.close_modal()
            elseif key == "up" then
                game.modal_move(-1)
            elseif key == "down" then
                game.modal_move(1)
            elseif key == "return" or key == "space" then
                local choice = game.modal_choose()
                if choice == "quit" then
                    game.stop()
                    menu.go_to("MENU_MAIN")
                elseif choice == "restart" then
                    game.stop()
                else
                    game.close_modal()
                end
            end
        elseif key == "escape" then
            game.open_modal()
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

function love.quit()
    save.flush()
end
