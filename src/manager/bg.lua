-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local bg = {}

local impls = {}

local function load_bgs()
    local dir = "src/bg"
    local files = love.filesystem.getDirectoryItems(dir)
    for i, f in ipairs(files) do
        if f:match("%.lua$") then
            local basename = f:gsub("%.lua$", "")
            if basename ~= "bg" then
                local ok, mod = pcall(require, "src.bg." .. basename)
                if ok and type(mod) == "table" then
                    impls[basename] = mod
                end
            end
        end
    end
end

load_bgs()

function bg.get_list()
    local names = {}
    for name in pairs(impls) do
        names[#names + 1] = name
    end
    table.sort(names)
    return names
end

local function get_impl()
    local impl = BG and impls[BG]
    if impl then
        return impl
    end
    return impls[MENU_BG] or impls.dream
end

function bg.update(dt)
    local impl = get_impl()
    if impl and impl.update then
        impl.update(dt)
    end
end

function bg.draw()
    local impl = get_impl()
    if impl and impl.draw then
        impl.draw()
    end
end

return bg
