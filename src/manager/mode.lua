-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local mode = {}

local function load_modes()
    local dir = "src/modes"
    local files = love.filesystem.getDirectoryItems(dir)
    for i, j in ipairs(files) do
        if j:match("%.lua$") then
            local basename = j:gsub("%.lua$", "")
            local ok, mod = pcall(require, "src.modes." .. basename)
            if ok and type(mod) == "table" then
                mode[basename] = mod
            end
        end
    end
end

load_modes()

return mode
