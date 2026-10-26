-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local skin = {}

function skin.base(px, py, bs, link, color)
    local down, right, down_right = link[2], link[4], link[8]

    love.graphics.setColor(color)

    if right and down and not down_right then
        love.graphics.rectangle("fill", px + 1, py + 1, bs - 2, bs)
        love.graphics.rectangle("fill", px + 1 + bs - 2, py + 1, 2, bs - 2)
    else
        love.graphics.rectangle("fill", px + 1, py + 1, right and bs or bs - 2, down and bs or bs - 2)
    end
end

function skin.borders(px, py, bs, link, color)
    local up, down, left, right, down_right = link[1], link[2], link[3], link[4], link[8]

    local left_space = left and (right and -1 or -2) or 1
    local w = left and (right and bs + 1 or bs) or (right and bs - 1 or bs - 3)
    local up_space = up and (down and -1 or -2) or 1
    local h = up and (down and bs + 1 or bs) or (down and bs - 1 or bs - 3)

    love.graphics.setColor(color)

    if not down then
        love.graphics.rectangle("fill", px + 1 + left_space, py + 1 + bs - 2, w, 1)
    end

    if not right then
        love.graphics.rectangle("fill", px + 1 + bs - 2, py + 1 + up_space, 1, h)
    end

    -- 不知道為什麼但是這樣就是對的並且不重複繪製角，我試出來的哈哈哈
    if (not down_right and right and down) or not (right or down) then
        -- if not down_right and not (right or down) then
        --     love.graphics.setColor(1, 1, 0)
        -- elseif (not down_right and right and down) then
        --     love.graphics.setColor(1, 0, 0)
        -- elseif not (right or down) then
        --     love.graphics.setColor(0, 1, 0)
        -- end

        if not (not down_right and right and down) then
            love.graphics.rectangle("fill", px + 1 + bs - 2, py + 1 + bs - 2, 1, 1)
        else
            -- 這裏是為了讓四向連接的 O 塊內部的邊框能正常顯示
            love.graphics.rectangle("fill", px + 1 + bs - 2, py + 1 + bs - 2, 2, 1)
            love.graphics.rectangle("fill", px + 1 + bs - 2, py + 2 + bs - 2, 1, 1)
        end
    end
end

return skin
