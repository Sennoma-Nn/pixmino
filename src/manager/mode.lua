-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local mode = {}

local function load_builtin()
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

function mode.load_custom(custom)
    for name, mod in pairs(custom or {}) do
        if mode[name] then
            print("custom mode conflict (ignored): " .. tostring(name))
        else
            mode[name] = mod
        end
    end
end

load_builtin()

return mode
