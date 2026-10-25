-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local skin = {}

local impl

local custom_skins = {}

function skin.register_custom(customs)
    for name, mod in pairs(customs) do
        if not custom_skins[name] then
            custom_skins[name] = mod
        end
    end
end

function skin.load(name)
    local ok, mod = pcall(require, "src.skin." .. name)
    if ok and type(mod) == "table" then
        impl = mod
        return impl
    end
    impl = custom_skins[name]
    return impl
end

function skin.base(px, py, bs, link, color)
    return impl.base(px, py, bs, link, color)
end

function skin.borders(px, py, bs, link, color)
    return impl.borders(px, py, bs, link, color)
end

function skin.get_list()
    local names = {}
    local seen = {}
    for i, item in ipairs(love.filesystem.getDirectoryItems("src/skin")) do
        if item:match("%.lua$") and item ~= "skin.lua" then
            local basename = item:gsub("%.lua$", "")
            names[#names + 1] = basename
            seen[basename] = true
        end
    end
    for name in pairs(custom_skins) do
        if seen[name] then
            print("custom skin conflict: " .. name)
        else
            names[#names + 1] = name
        end
    end
    table.sort(names)
    return names
end

return skin
