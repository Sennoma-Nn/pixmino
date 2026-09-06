-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local push     = require("lib.push")
local core     = require("src.debug.core")
local cio      = require("src.debug.console_io")
local console  = require("src.debug.console")

local launcher = {}

local function apply_console_resolution(on)
    if on then
        push:setupScreen(
            320 * 2, 180 * 2,
            320 * 4, 180 * 4,
            {
                pixelperfect = true,
                resizable = true,
                canvas = true
            }
        )
    else
        push:setupScreen(
            320 * 1, 180 * 1,
            320 * 4, 180 * 4,
            {
                pixelperfect = true,
                resizable = true,
                canvas = true
            }
        )
    end
end

function launcher.toggle()
    if console.visible then
        console.visible = false
        love.keyboard.setKeyRepeat(false)
        core.reset()
        apply_console_resolution(false)
    else
        console.visible = true
        love.keyboard.setKeyRepeat(true)
        cio.clear()
        core.boot("SHELL")
        BGM = nil
        apply_console_resolution(true)
    end
end

return launcher
