local skin = {}

function skin.base(px, py, bs)
    love.graphics.rectangle("fill", px, py, bs, bs)
end

function skin.borders(px, py, bs, link)
    local up, down, left, right = unpack(link)

    if not up then
        love.graphics.rectangle("fill", px + 1, py, bs - 2, 1)
    end
    if not down then
        love.graphics.rectangle("fill", px + 1, py + bs - 1, bs - 2, 1)
    end
    if not left then
        love.graphics.rectangle("fill", px, py + 1, 1, bs - 2)
    end
    if not right then
        love.graphics.rectangle("fill", px + bs - 1, py + 1, 1, bs - 2)
    end

    love.graphics.rectangle("fill", px, py, 1, 1)
    love.graphics.rectangle("fill", px + bs - 1, py, 1, 1)
    love.graphics.rectangle("fill", px, py + bs - 1, 1, 1)
    love.graphics.rectangle("fill", px + bs - 1, py + bs - 1, 1, 1)
end

return skin
