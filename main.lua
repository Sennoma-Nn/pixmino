-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

GAMEVER = "v0.1.0"

local push = require("lib.push")
local vgafont = require("lib.vgafont")
local menu = require("src.menu.menu")
local game = require("src.game.game")
local render = require("src.game.draw")
local input = require("src.game.input")
local modes = require("src.manager.mode")
local save = require("src.utils.save")
local sfx = require("src.manager.sfx")
local bg = require("src.manager.bg")
local core = require("src.debug.core")
local cio = require("src.debug.console_io")
local console = require("src.debug.console")
local launcher = require("src.debug.launcher")
local user_script = require("user_script")

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

local win = {
    resizeInterval = 0.5,
    resizeTimer    = 0,
    W              = 0,
    H              = 0,
}

Fonts = {
    ui_fonts = {},
    bold_font = nil,
}

Colors = {
    yellow             = { 1, 0.8, 0, 1 },
    light_yellow       = { 1, 0.9, 0.4, 1 },
    white              = { 1, 1, 1, 1 },
    light_gray         = { 0.75, 0.75, 0.75, 1 },
    gray               = { 0.5, 0.5, 0.5, 1 },
    goal_lines_comment = { 0.2, 0.2, 0.2, 1 },
    black              = { 0, 0, 0, 1 },
    out_line           = { 0, 0, 0, 1 },
    mino_border        = { 0, 0, 0, 0.2 },
    piece_border       = { 0, 0, 0, 0.6 },
    ghost_border       = { 1, 1, 1, 0.2 },
    playfield_bg       = { 0, 0, 0, 0.6 },
    key                = { 0.8, 0.5, 0, 1 },
}

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.math.setRandomSeed(os.time())
    BG = "grid"

    push:setupScreen(
        320 * 1, 180 * 1,
        320 * 4, 180 * 4,
        {
            resizable = true,
            canvas = true
        }
    )

    win.W, win.H       = love.window.getMode()

    Fonts.bold_font    = vgafont.load("assets/font/IB-FULL.F08", "cp437")
    Fonts.comment_font = vgafont.load("assets/font/PUFFBUB.F08", "cp437")
    Fonts.ui_fonts     = {
        vgafont.load("assets/font/QUADBM/CP897.F08", "jisx0201"),
        vgafont.load("assets/font/QUADBM/CP437.F08", "cp437"),
        vgafont.load("assets/font/QUADBM/ext/BPMF.F08", "bpmf"),
        vgafont.load("assets/font/QUADBM/ext/PINYIN.F08", "pinyin"),
        vgafont.load("assets/font/QUADBM/ext/SYMBOL.F08", "symbol"),
        vgafont.load("assets/font/MIN_QUAN.F08", "mincn"), -- 這麼做是為了在不載入 quan 字型的情況下能夠顯示語言選擇菜單，否則第一次啟動時非中文用戶必須加載整個字型到記憶體，慢
    }

    game.input_mod     = input
    sfx.load()
    console.load()
    core.load()

    user_script.run()

    local fullscreen, has_locale = save.load()
    local _ = fullscreen and push:switchFullscreen()

    if not has_locale then
        menu.rebuild_lang_menu()
        menu.switch_to_lang()
    end
end

function love.draw()
    push:apply("start")

    if console.visible then
        console.draw(0, 0)
    else
        bg.draw()

        local pw = playfield.width * style.block_size
        local ph = playfield.height * style.block_size
        local gy = (push:getHeight() - ph) / 2
        local gx = gy
        local bw = style.playfield_width

        render.draw(gx, gy, pw, ph, bw, style.block_size)

        local _ = menu.state ~= "GAME" and menu.draw(gx, gy, pw, ph, bw)
    end

    push:apply("end")
end

function love.update(dt)
    win.resizeTimer = win.resizeTimer + dt
    if win.resizeTimer >= win.resizeInterval then
        win.resizeTimer = win.resizeTimer - win.resizeInterval
        local currentW, currentH = love.window.getMode()
        if currentW ~= win.W or currentH ~= win.H then
            win.W, win.H = currentW, currentH
            love.resize(currentW, currentH)
        end
    end

    bg.update(dt)

    if console.visible then
        if not core.exists(1) or core.take_close_request() then
            launcher.toggle()
            return
        end
        console.update(dt)
        sfx.update()
        return
    end

    if menu.state == "GAME" then
        if not game.started then
            game.start(playfield, modes[menu.selected_mode], menu.selected_mode)
            input.reset()
        end
        game.update(dt)
    else
        BGM = "korobeiniki2"
    end
    sfx.update()
    -- print(dt)
end

local function is_settings_menu()
    return menu.state:match("^MENU_SETTINGS")
end

function love.keypressed(key)
    if key == "f4" then
        push:switchFullscreen()
        Settings.display.fullscreen = love.window.getFullscreen()
        return
    end

    if console.visible then
        if key == "escape" or (key == "t" and (love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl"))) then
            launcher.toggle()
            return
        end
        cio.push_key(key)
        core.poll_input()
        return
    end

    if is_settings_menu() and key == "t" and (love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl")) then
        launcher.toggle()
        return
    end

    if menu.state == "GAME" then
        if game.cleared then
            if key == "escape" then
                game.stop()
                menu.back()
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
                    menu.back()
                end
            elseif key == "escape" then
                game.stop()
                menu.back()
            end
            return
        end
        if game.modal_active then
            if key == "escape" then
                game.close_modal()
            elseif key == "up" then
                sfx.play("menu_move")
                game.modal_move(-1)
            elseif key == "down" then
                sfx.play("menu_move")
                game.modal_move(1)
            elseif key == "return" or key == "space" then
                local choice = game.modal_choose()
                sfx.play("menu_confirm")

                if choice == "quit" then
                    game.stop()
                    menu.back()
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

function love.textinput(text)
    if console.visible then
        cio.push_key(nil, text)
        core.poll_input()
    end
end

function love.resize(w, h)
    win.W, win.H = w, h
    push:resize(w, h)
end

function love.quit()
    save.flush()
end

function love.run()
    if love.math then
        love.math.setRandomSeed(os.time())
    end

    if love.load then love.load() end

    if love.timer then love.timer.step() end

    local fixed_dt = 1 / 60
    local accumulator = 0
    local max_step = 0.25

    local dt = 0

    return function()
        if love.event then
            love.event.pump()
            for name, a, b, c, d, e, f in love.event.poll() do
                if name == "quit" then
                    if not love.quit or not love.quit() then
                        return a or 0
                    end
                end
                love.handlers[name](a, b, c, d, e, f)
            end
        end

        if love.timer then
            love.timer.step()
            dt = love.timer.getDelta()
        end

        if Settings and Settings.display and Settings.display.fixed_step then
            if dt > max_step then dt = max_step end
            accumulator = accumulator + dt
            while accumulator >= fixed_dt do
                if love.update then love.update(fixed_dt) end
                accumulator = accumulator - fixed_dt
            end
        else
            if love.update then love.update(dt) end
        end

        if love.graphics and love.graphics.isActive() then
            love.graphics.origin()
            love.graphics.clear(love.graphics.getBackgroundColor())
            if love.draw then love.draw() end
            love.graphics.present()
        end

        if love.timer then love.timer.sleep(0.001) end
    end
end
