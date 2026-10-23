-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local skin = {}

function skin.base(px, py, bs, link, color)
    love.graphics.setColor(color)
    love.graphics.rectangle("fill", px, py, bs, bs)
end

function skin.borders(px, py, bs, link, color)
    local up, down, left, right, up_left, up_right, down_left, down_right = unpack(link)

    love.graphics.setColor(color)

    if not up then
        love.graphics.rectangle("fill", px, py, bs, 1)
    end

    if not down then
        love.graphics.rectangle("fill", px, py + bs - 1, bs, 1)
    end

    if not left then
        love.graphics.rectangle("fill", px, py, 1, bs)
    end

    if not right then
        love.graphics.rectangle("fill", px + bs - 1, py, 1, bs)
    end

    if up and left and (not up_left) then
        love.graphics.rectangle("fill", px, py, 1, 1)
    end

    if up and right and (not up_right) then
        love.graphics.rectangle("fill", px + bs - 1, py, 1, 1)
    end

    if down and left and (not down_left) then
        love.graphics.rectangle("fill", px, py + bs - 1, 1, 1)
    end

    if down and right and (not down_right) then
        love.graphics.rectangle("fill", px + bs - 1, py + bs - 1, 1, 1)
    end
end

return skin
