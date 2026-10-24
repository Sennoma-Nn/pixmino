-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local vgafont = require("lib.vgafont")
local push = require("lib.push")

local matrix = {}

local font_897
local font_bpmf
local charset = {}

local cols = {}
local w, h = 0, 0

local function load_font()
    if font_897 and font_bpmf then return end

    font_897 = font_897 or vgafont.load("assets/font/QUADBM/CP897.F08", "jisx0201")
    if font_897 then
        for i = 0x30, 0x39 do
            charset[#charset + 1] = string.char(i)
        end

        for i = 0x3F, 0x5A do
            charset[#charset + 1] = string.char(i)
        end

        for i = 0x23, 0x26 do
            charset[#charset + 1] = string.char(i)
        end

        charset[#charset + 1] = string.char(0x5C)

        for i = 0xB1, 0xDD do
            local c = font_897.to_utf8[i]
            charset[#charset + 1] = c
        end
    end

    -- font_bpmf = font_bpmf or vgafont.load("assets/font/QUADBM/ext/BPMF.F08", "bpmf")
    -- if font_bpmf then
    --     for i = 0x80, 0xA4 do
    --         local c = font_bpmf.to_utf8[i]
    --         if c then charset[#charset + 1] = c end
    --     end
    -- end
end

local function new_col(x)
    return {
        x = x,
        head = -love.math.random(0, 24),
        timer = 0,
        interval = love.math.random(1.0, 3.0) / 10,
        len = love.math.random(4, 16),
        chars = {},
    }
end

local function rebuild()
    w, h = push:getDimensions()
    cols = {}
    for x = 0, w - 1, 8 * 2 do
        cols[#cols + 1] = new_col(x)
    end
end

local function grow(col)
    col.head = col.head + 1
    col.chars[#col.chars + 1] = charset[love.math.random(#charset)]
    if #col.chars > col.len then
        table.remove(col.chars, 1)
    end
end

local SHADOW = 48
local function draw_vignette()
    for y = 0, SHADOW - 1 do
        love.graphics.setColor(0, 0, 0, 1 - y / SHADOW)
        love.graphics.rectangle("fill", 0, y, w, 1)
    end
    for y = 0, SHADOW - 1 do
        love.graphics.setColor(0, 0, 0, y / SHADOW)
        love.graphics.rectangle("fill", 0, h - SHADOW + y, w, 1)
    end
end

function matrix.update(dt)
    for i, col in ipairs(cols) do
        col.timer = col.timer + dt
        while col.timer >= col.interval do
            col.timer = col.timer - col.interval
            grow(col)
        end
        if col.head * 8 > h + col.len * 8 then
            cols[i] = new_col(col.x)
        end
    end
end

function matrix.draw()
    load_font()

    local nw, nh = push:getDimensions()
    if #cols == 0 or nw ~= w or nh ~= h then rebuild() end

    love.graphics.clear(0, 0.05, 0)
    draw_vignette()

    for j, col in ipairs(cols) do
        for i, ch in ipairs(col.chars) do
            local y = (col.head - (#col.chars - i)) * 8
            if y >= -8 and y <= h then
                local t = i / #col.chars
                vgafont.draw_char({ font_897, font_bpmf }, col.x, y, ch, 1, { t, 1, t, 0.3 + 0.7 * t })
            end
        end
    end
end

return matrix
