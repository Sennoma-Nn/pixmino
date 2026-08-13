-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

-- Dedicated decoder for quan.bdf (QuanPixel 8px) only
-- It relies on quan.bdf specific assumptions and is NOT suitable for all BDF font

local quan = {}

local SLOT_W = 8
local SLOT_H = 8
local PER_ROW = 128

---@class quan_glyph
---@field encoding integer?
---@field dwidth integer?
---@field w integer?
---@field h integer?
---@field xoff integer?
---@field yoff integer?
---@field rows string[]?

local byte_bits = {}
for b = 0, 255 do
    local t = {}
    local v = b
    for i = 7, 0, -1 do
        local p = 2 ^ i
        if v >= p then
            t[#t + 1] = 1
            v = v - p
        else
            t[#t + 1] = 0
        end
    end
    byte_bits[b] = t
end

local function utf8_char(cp)
    if cp < 0x80 then
        return string.char(cp)
    elseif cp < 0x800 then
        return string.char(
            0xC0 + math.floor(cp / 0x40),
            0x80 + cp % 0x40)
    elseif cp < 0x10000 then
        return string.char(
            0xE0 + math.floor(cp / 0x1000),
            0x80 + math.floor(cp / 0x40) % 0x40,
            0x80 + cp % 0x40)
    else
        return string.char(
            0xF0 + math.floor(cp / 0x40000),
            0x80 + math.floor(cp / 0x1000) % 0x40,
            0x80 + math.floor(cp / 0x40) % 0x40,
            0x80 + cp % 0x40)
    end
end

function quan.load(path)
    local file = love.filesystem.newFile(path)
    if not file then return nil end
    if not file:open("r") then return nil end

    ---@type number
    local ascent = 6
    ---@type number
    local descent = 2
    local entries = {}
    local in_bitmap = false
    ---@type quan_glyph?
    local cur = nil

    for line in file:lines() do
        line = line:gsub("\r$", "")

        if in_bitmap then
            if line == "ENDCHAR" then
                in_bitmap = false
                if cur and cur.encoding and cur.w > 0 and cur.h > 0 and cur.encoding >= 0 then
                    entries[#entries + 1] = {
                        char   = utf8_char(cur.encoding),
                        w      = cur.w,
                        h      = cur.h,
                        xoff   = cur.xoff,
                        yoff   = cur.yoff,
                        dwidth = cur.dwidth,
                        rows   = cur.rows,
                    }
                end
                cur = nil
            else
                if cur and cur.rows then
                    cur.rows[#cur.rows + 1] = line
                end
            end
        else
            if line == "BITMAP" then
                in_bitmap = true
                cur = cur or {}
                cur.rows = {}
            elseif line:sub(1, 8) == "ENCODING" then
                cur = cur or {}
                cur.encoding = tonumber(line:sub(10))
            elseif line:sub(1, 6) == "DWIDTH" then
                local dw = line:match("%d+")
                if cur and dw then
                    cur.dwidth = tonumber(dw)
                end
            elseif line:sub(1, 3) == "BBX" then
                local w, h, xo, yo = line:match("BBX (%S+) (%S+) (%S+) (%S+)")
                if cur then
                    cur.w    = tonumber(w)
                    cur.h    = tonumber(h)
                    cur.xoff = tonumber(xo)
                    cur.yoff = tonumber(yo)
                end
            elseif line:sub(1, 11) == "FONT_ASCENT" then
                local a = line:match("%d+")
                if a then ascent = tonumber(a) or ascent end
            elseif line:sub(1, 12) == "FONT_DESCENT" then
                local d = line:match("%d+")
                if d then descent = tonumber(d) or descent end
            end
        end
    end
    file:close()

    local n = #entries
    if n == 0 then return nil end

    local rows = math.ceil(n / PER_ROW)
    local atlas_w = PER_ROW * SLOT_W
    local atlas_h = rows * SLOT_H
    local image_data = love.image.newImageData(atlas_w, atlas_h)

    local glyphs = {}

    for i, e in ipairs(entries) do
        local col = (i - 1) % PER_ROW
        local row = math.floor((i - 1) / PER_ROW)
        local slot_x = col * SLOT_W
        local slot_y = row * SLOT_H

        local ox = e.xoff or 0
        local oy = (ascent - (e.yoff + e.h))

        local bytes_per_row = math.ceil(e.w / 8)
        for ry = 0, e.h - 1 do
            local hex = e.rows[ry + 1]
            if hex then
                for bx = 0, bytes_per_row - 1 do
                    local byte = tonumber(hex:sub(bx * 2 + 1, bx * 2 + 2), 16) or 0
                    local bits = byte_bits[byte]
                    local base_x = bx * 8
                    for b = 0, 7 do
                        local px = base_x + b
                        if px < e.w and bits[b + 1] == 1 then
                            local sx = ox + px
                            local sy = oy + ry
                            if sx >= 0 and sx < SLOT_W and sy >= 0 and sy < SLOT_H then
                                image_data:setPixel(slot_x + sx, slot_y + sy, 1, 1, 1, 1)
                            end
                        end
                    end
                end
            end
        end

        e.rows = nil
        glyphs[e.char] = {
            quad   = love.graphics.newQuad(slot_x, slot_y, SLOT_W, SLOT_H, atlas_w, atlas_h),
            ox     = ox,
            oy     = oy,
            dwidth = e.dwidth or SLOT_W,
        }
    end

    local image = love.graphics.newImage(image_data)
    image:setFilter("nearest", "nearest")

    return {
        image  = image,
        glyphs = glyphs,
        height = ascent + descent,
        ascent = ascent,
    }
end

return quan
