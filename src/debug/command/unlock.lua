-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local cio      = require("src.debug.console_io")

local unlock   = {}

unlock.name    = "UNLOCK"

local fg_value = cio.fg(2)
local fg_err   = cio.fg(4)
local fg_warn  = cio.fg(6)
local fg_note  = cio.fg(15)

local function confirm_unlock()
    cio.print_line("Warning: After unlocking, you can use more dangerous commands.", fg_warn)
    cio.print_line("Are you really sure what you are doing?", fg_warn)
    cio.print_line("These commands may corrupt your save data, damage your PC,", fg_warn)
    cio.print_line("Steal your private info, eat your pet rocks, etc.", fg_warn)

    local cx, cy = cio.get_cursor()
    local prompt = "Continue? [Y/n] "
    local prompt_len = #prompt
    cio.write(0, cy - 1, prompt, fg_note)

    while true do
        cio.set_cursor(prompt_len + 1, cy)
        local key, ch = cio.getchar()

        if key == "return" then
            return true
        elseif key == "escape" then
            return false
        end

        if ch and #ch == 1 and ch:match("%a") then
            cio.write(prompt_len, cy - 1, ch:upper())
            cio.set_cursor(prompt_len + 1, cy)
            local c = ch:lower()
            if c == "y" then
                return true
            elseif c == "n" then
                return false
            end
        end
    end
end

function unlock.run(cio, args)
    local arg = args and args[1]
    if arg and arg:upper() == "/U" then
        Settings.debug.unlock = false
        return
    end
    if arg and arg:upper() == "/?" then
        cio.print_line("UNLOCK    : Unlock debug commands (asks confirm)", fg_note)
        cio.print_line("UNLOCK /U : Re-lock debug commands", fg_note)
        cio.print_line("UNLOCK /? : This help", fg_note)
        return
    end

    if Settings.debug.unlock then
        cio.print_line("Debug unlock is already ON.", fg_note)
        return
    end

    if confirm_unlock() then
        Settings.debug.unlock = true
        cio.print_line("", fg_note)
        cio.print_line("Debug unlock ON.", fg_note)
    else
        cio.print_line("", fg_note)
        cio.print_line("Cancelled.", fg_note)
    end
end

return unlock
