-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local push = require("lib.push")

local dream = {}

local gradient_top = {0.1, 0.1, 0.2}
local gradient_bottom = {0.2, 0.1, 0.2}

local particles = {}
local w, h = 0, 0
local t = 0

local function random_range(a, b)
    return a + love.math.random() * (b - a)
end

local function spawn(p, initial)
    p.x = love.math.random() * w
    p.y = initial and love.math.random() * h or h + random_range(2, 12)
    p.vx = random_range(-4, 4)
    p.vy = -random_range(3, 14)
    p.size = love.math.random() < 0.5 and 3 or 1
    p.sway_amp = random_range(1, 6)
    p.sway_speed = random_range(0.3, 1.4)
    p.sway_phase = love.math.random() * math.pi * 2
    p.twinkle_speed = random_range(0.8, 3.0)
    p.twinkle_phase = love.math.random() * math.pi * 2
    p.alpha = random_range(0.18, 0.65)
    local key = Settings.mino_color_keys[love.math.random(#Settings.mino_color_keys)]
    p.color = Settings.display.block_color[key]
    return p
end

local function rebuild()
    w, h = push:getDimensions()
    particles = {}

    local count = math.max(48, math.floor(w * h / 700))
    for i = 1, count do
        particles[i] = spawn({}, true)
    end
end

function dream.update(dt)
    t = t + dt

    local nw, nh = push:getDimensions()
    if nw ~= w or nh ~= h then
        rebuild()
    end

    for i = 1, #particles do
        local p = particles[i]
        p.x = p.x + (p.vx + math.sin(t * p.sway_speed + p.sway_phase) * p.sway_amp) * dt
        p.y = p.y + p.vy * dt

        if p.x < -4 then
            p.x = w + 4
        elseif p.x > w + 4 then
            p.x = -4
        end

        if p.y < -4 then
            spawn(p, false)
        end
    end
end

local function draw_gradient(width, height)
    love.graphics.setBlendMode("alpha")
    for y = 0, height - 1 do
        local k = height > 1 and y / (height - 1) or 0
        love.graphics.setColor(
            gradient_top[1] + (gradient_bottom[1] - gradient_top[1]) * k,
            gradient_top[2] + (gradient_bottom[2] - gradient_top[2]) * k,
            gradient_top[3] + (gradient_bottom[3] - gradient_top[3]) * k,
            1
        )
        love.graphics.rectangle("fill", 0, y, width, 1)
    end
end

function dream.draw()
    local nw, nh = push:getDimensions()
    if #particles == 0 or nw ~= w or nh ~= h then
        rebuild()
    end

    draw_gradient(nw, nh)

    love.graphics.setBlendMode("add")
    for i = 1, #particles do
        local p = particles[i]
        local twinkle = 0.55 + 0.45 * math.sin(t * p.twinkle_speed + p.twinkle_phase)
        local alpha = p.alpha * twinkle
        local r, g, b = p.color[1], p.color[2], p.color[3]
        local x, y = math.floor(p.x), math.floor(p.y)
        local s = p.size

        love.graphics.setColor(r, g, b, alpha)
        love.graphics.rectangle("fill", x, y, s, s)

        if s >= 2 then
            love.graphics.setColor(r, g, b, alpha * 0.55)
            love.graphics.rectangle("fill", x - 1, y + math.floor(s / 2), s + 2, 1)
            love.graphics.rectangle("fill", x + math.floor(s / 2), y - 1, 1, s + 2)
        end
    end
    love.graphics.setBlendMode("alpha")
    love.graphics.setColor(1, 1, 1, 1)
end

return dream
