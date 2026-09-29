-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local skin = {}

local impl

function skin.load(name)
    impl = require(string.format("src.game.skin.%s.skin", name))
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
    for _, item in ipairs(love.filesystem.getDirectoryItems("src/game/skin")) do
        if love.filesystem.getInfo("src/game/skin/" .. item .. "/skin.lua") then
            names[#names + 1] = item
        end
    end
    table.sort(names)
    return names
end

return skin
