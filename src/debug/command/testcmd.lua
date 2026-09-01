-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local biom = require("src.debug.basic_IO_module")

local testcmd = {}

testcmd.name = "TESTCMD"

local fg_value = biom.fg(2)
local fg_note  = biom.fg(15)

function testcmd.run(biom, args)
    biom.print_line("ARGC " .. tostring(#(args or {})), fg_note)
    for i, a in ipairs(args or {}) do
        biom.print_line(string.format("%d: %s", i, tostring(a)), fg_value)
    end
end

return testcmd
