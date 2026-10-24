-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local background = {0.1, 0.1, 0.15}

local grid = {}

local t = 0
local burst = 0

local canvas_a
-- local canvas_b

local function ensure_canvas(canvas, w, h)
    if not canvas or canvas:getWidth() ~= w or canvas:getHeight() ~= h then
        return love.graphics.newCanvas(w, h)
    end
    return canvas
end

local function paint_layer(canvas, w, h, spacing, dx, dy)
    love.graphics.setCanvas(canvas)
    love.graphics.clear(0, 0, 0, 0)
    love.graphics.setColor(1, 1, 1, 1)

    for x = 0 - spacing + dx, w, spacing do
        love.graphics.rectangle("fill", x, 0, 1, h)
    end

    for y = 0 - spacing + dy, h, spacing do
        love.graphics.rectangle("fill", 0, y, w, 1)
    end
end

function grid.update(dt)
    if burst > 0 then
        burst = burst * math.exp(-dt * 4)
        if burst < 0.01 then burst = 0 end
    end
    t = t + dt * (1 + burst * 4)
end

function grid.on_line_clear(cleared)
    burst = math.min(1, burst + cleared * 0.5)
end

function grid.draw()
    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()

    love.graphics.clear(unpack(background))

    canvas_a = ensure_canvas(canvas_a, w, h)
    -- canvas_b = ensure_canvas(canvas_b, w, h)

    local ox = math.floor((t * 4) % 32)
    local oy = math.floor((t * 2) % 32)

    local rox = math.floor((-t * 2) % 32) + 16
    local roy = math.floor((-t * 1) % 32) + 16

    local prev_canvas = love.graphics.getCanvas()

    paint_layer(canvas_a, w, h, 32, ox, oy)
    -- paint_layer(canvas_b, w, h, 32, rox, roy)

    love.graphics.setCanvas(prev_canvas)

    love.graphics.setColor(1, 1, 1, 0.1)
    love.graphics.draw(canvas_a, 0, 0)

    love.graphics.setColor(1, 1, 1, 0.05)
    -- love.graphics.draw(canvas_b, 0, 0)
end

return grid
