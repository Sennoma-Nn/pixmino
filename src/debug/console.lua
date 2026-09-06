-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local vgafont         = require("lib.vgafont")

local console         = {}

console.W             = 80
console.H             = 45
console.cursor_height = 2
console.visible       = false

console.grid          = {}

console.cursor_x      = 1
console.cursor_y      = 1

local font            = nil
local image           = nil
local quads           = nil
local code_cache      = {}
local phase           = 0

local fg_def          = { 1, 1, 1, 1 }
local bg_cell         = { 0, 0, 0, 0 }

local function blank()
    return {
        char  = " ",
        fg    = { fg_def[1], fg_def[2], fg_def[3], fg_def[4] },
        bg    = { bg_cell[1], bg_cell[2], bg_cell[3], bg_cell[4] },
        blink = false,
    }
end

for y = 1, console.H do
    console.grid[y] = {}
    for x = 1, console.W do
        console.grid[y][x] = blank()
    end
end

function console.load()
    font = vgafont.load("assets/font/PUFFBUB.F08", "cp437")
    if not font then return end

    image = font.image
    quads = font.quads

    code_cache = {}
    for c = 0, 255 do
        local ch = string.char(c)
        code_cache[ch] = c
    end
end

function console.update(dt)
    phase = phase + dt
end

function console.draw(x0, y0)
    if not console.visible then return end
    if not font or not quads or not image then return end

    love.graphics.setColor(unpack(bg_cell))
    love.graphics.rectangle("fill", x0, y0, console.W * 8, console.H * 8)

    local blink_on = (math.floor(phase * 2) % 2 == 0)

    for y = 1, console.H do
        local row = console.grid[y]
        local py = y0 + (y - 1) * 8
        for x = 1, console.W do
            local cell = row[x]
            local px = x0 + (x - 1) * 8

            local bg = cell.bg
            if bg[4] > 0 then
                love.graphics.setColor(unpack(bg))
                love.graphics.rectangle("fill", px, py, 8, 8)
            end

            local ch = cell.char
            if ch ~= " " then
                local code = code_cache[ch]
                local quad = code and quads and quads[code]
                if quad and not (cell.blink and not blink_on) then
                    love.graphics.setColor(unpack(cell.fg))
                    love.graphics.draw(image, quad, px, py)
                end
            end
        end
    end

    if blink_on then
        local cx = x0 + (console.cursor_x - 1) * 8
        local cy = y0 + (console.cursor_y - 1) * 8 + (8 - console.cursor_height)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.rectangle("fill", cx, cy, 8, console.cursor_height)
    end
end

return console
