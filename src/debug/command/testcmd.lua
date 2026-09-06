-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local cio      = require("src.debug.console_io")

local testcmd  = {}

testcmd.name   = "TESTCMD"

local fg_value = cio.fg(2)
local fg_note  = cio.fg(15)

function testcmd.run(cio, args)
    cio.print_line("ARGC " .. tostring(#(args or {})), fg_note)
    for i, a in ipairs(args or {}) do
        cio.print_line(string.format("%d: %s", i, tostring(a)), fg_value)
    end
end

return testcmd
