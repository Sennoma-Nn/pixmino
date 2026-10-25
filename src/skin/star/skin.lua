-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local skin = {}

local bit = require("bit")

local function hash(x, y)
    local n = x * 374761393 + y * 668265263
    n = bit.bxor(n, bit.rshift(n, 13)) * 1274126177
    n = bit.bxor(n, bit.rshift(n, 16))
    return (n % 100000) / 100000
end

function skin.base(px, py, bs, link, color)
    local a = color[4] or 1

    love.graphics.setColor(color[1] * 0.1, color[2] * 0.1, color[3] * 0.1, a)
    love.graphics.rectangle("fill", px, py, bs, bs)

    local t = love.timer.getTime()
    local count = 3

    for i = 0, count - 1 do
        local hx = hash(px, py + i * 7)
        local hy = hash(px + i * 13, py)
        local seed = hash(px + i, py - i)

        local sx = px + 1 + math.floor(hx * (bs - 2))
        local sy = py + 1 + math.floor(hy * (bs - 2))

        local dx = math.floor(math.sin(t * 0.6 + seed * 6.28) * 1.5)
        local dy = math.floor(math.cos(t * 0.5 + seed * 6.28) * 1.5)
        sx = sx + dx
        sy = sy + dy

        if sx >= px + 1 and sx <= px + bs - 2 and sy >= py + 1 and sy <= py + bs - 2 then
            local tw = 0.4 + 0.6 * (0.5 + 0.5 * math.sin(t * 2.0 + i * 2.1 + seed * 6.28))
            love.graphics.setColor(color[1] + 0.4, color[2] + 0.4, color[3] + 0.4, a * tw)
            love.graphics.rectangle("fill", sx, sy, 1, 1)
        end
    end
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
