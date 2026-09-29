-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local skin = {}

function skin.base(px, py, bs, link, color)
    local up, down, left, right, up_left, up_right, down_left, down_right = unpack(link)

    love.graphics.setColor(color)

    if not (right and down and not down_right) then
        local right_not_link = right and 0 or 2
        local down_not_link = down and 0 or 2
        love.graphics.rectangle("fill", px, py, bs - right_not_link, bs - down_not_link)
    else
        love.graphics.rectangle("fill", px, py, bs - 2, bs)
        love.graphics.rectangle("fill", px + bs - 2, py, 2, bs - 2)
    end
end

function skin.borders(px, py, bs, link, color)
    local up, down, left, right, up_left, up_right, down_left, down_right = unpack(link)
    local left_space = 0
    local up_space = 0
    local w = 0
    local h = 0
    
    if left and right then
        left_space = -1
        w = bs + 1
    elseif (not left) and (not right) then
        left_space = 1
        w = bs - 3
    elseif left and (not right) then
        left_space = -2
        w = bs
    elseif (not left) and right then
        left_space = 1
        w = bs - 1
    end

    if up and down then
        up_space = -1
        h = bs + 1
    elseif (not up) and (not down) then
        up_space = 1
        h = bs - 3
    elseif up and (not down) then
        up_space = -2
        h = bs
    elseif (not up) and down then
        up_space = 1
        h = bs - 1
    end

    love.graphics.setColor(color)

    if not down then
        love.graphics.rectangle("fill", px + left_space, py + bs - 2, w, 1)
    end

    if not right then
        love.graphics.rectangle("fill", px + bs - 2, py + up_space, 1, h)
    end

    if not down_right then
        love.graphics.rectangle("fill", px + bs - 2, py + bs - 2, 1, 1)
    end
end

return skin
