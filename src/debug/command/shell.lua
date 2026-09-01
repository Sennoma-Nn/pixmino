-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local biom            = require("src.debug.basic_IO_module")
local core            = require("src.debug.core")
local le              = require("src.debug.lib.line_editor")

local shell           = {}

shell.name            = "SHELL"

local fg_out          = biom.fg(2)
local fg_err          = biom.fg(4)
local fg_note         = biom.fg(15)
local fg_warn         = biom.fg(6)

local prompt_locked   = "Cmd> "
local prompt_unlocked = "Dbg> "
local history         = {}
local editor          = le.new(history)

local function tokenize(line)
    local tokens = {}
    local cur = ""
    local i = 1
    local n = #line
    while i <= n do
        local c = line:sub(i, i)
        if c == " " or c == "\t" then
            if cur ~= "" then
                tokens[#tokens + 1] = cur
                cur = ""
            end
            i = i + 1
        elseif c == "/" then
            if cur ~= "" then
                tokens[#tokens + 1] = cur
                cur = ""
            end
            tokens[#tokens + 1] = line:sub(i, i + 1)
            i = i + 2
        else
            cur = cur .. c
            i = i + 1
        end
    end
    if cur ~= "" then
        tokens[#tokens + 1] = cur
    end
    return tokens
end

function shell.run(biom, args)
    biom.print_line("PIXMINO Debug Shell - COMMAND-style commands", fg_note)
    biom.print_line("Type `EXIT` to quit", fg_note)
    biom.print_line("", fg_note)

    while true do
        local prompt = Settings.debug.unlock and prompt_unlocked or prompt_locked
        local line = editor:read_line(biom, prompt)
        local argv = tokenize(line)

        if #argv > 0 then
            local name_raw = argv[1]
            local name = name_raw and string.upper(name_raw) or ""
            local rest = {}
            for i = 2, #argv do
                rest[#rest + 1] = argv[i]
            end
            if name == "EXIT" then
                return
            elseif name == "/?" then
                biom.print_line("SHELL    : Start Debug Shell", fg_note)
                biom.print_line("SHELL /? : This help", fg_note)
            elseif name == "PID" then
                biom.print_line(tostring(core.getpid()), fg_out)
            else
                local ok, why = core.run(name, rest)
                if not ok and why == "locked" then
                    biom.print_line("This is a dangerous command.", fg_warn)
                    biom.print_line("If you know what you are doing, use `UNLOCK` to unlock", fg_warn)
                elseif not ok then
                    biom.print_line("Command not found: " .. tostring(name_raw or ""), fg_err)
                end
            end
            biom.print_line("", fg_note)
        end
    end
end

return shell
