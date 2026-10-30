-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local quan = {}

local SLOT_W = 8
local SLOT_H = 8
local PER_ROW = 128
local BDF_PATH = "assets/font/quan.bdf"

local DEFAULT_ASCENT = 6
local DEFAULT_DESCENT = 2

local raw_data = nil
local cached_font = nil

local BYTE_BITS = {}
for byte = 0, 255 do
    local bits = {}
    local value = byte
    for i = 7, 0, -1 do
        local weight = 2 ^ i
        if value >= weight then
            bits[#bits + 1] = 1
            value = value - weight
        else
            bits[#bits + 1] = 0
        end
    end
    BYTE_BITS[byte] = bits
end

local function utf8_encode(codepoint)
    if codepoint < 0x80 then
        return string.char(codepoint)
    elseif codepoint < 0x800 then
        return string.char(0xC0 + math.floor(codepoint / 0x40), 0x80 + codepoint % 0x40)
    elseif codepoint < 0x10000 then
        return string.char(
            0xE0 + math.floor(codepoint / 0x1000),
            0x80 + math.floor(codepoint / 0x40) % 0x40,
            0x80 + codepoint % 0x40
        )
    end

    return string.char(
        0xF0 + math.floor(codepoint / 0x40000),
        0x80 + math.floor(codepoint / 0x1000) % 0x40,
        0x80 + math.floor(codepoint / 0x40) % 0x40,
        0x80 + codepoint % 0x40
    )
end

local function finalize_char(raw)
    if not raw then
        return nil
    end

    local encoding = raw.encoding
    local w, h = raw.w, raw.h
    if not encoding or encoding < 0 then
        return nil
    end
    if not w or not h or w <= 0 or h <= 0 then
        return nil
    end
    if not raw.rows then
        return nil
    end

    return {
        char = utf8_encode(encoding),
        w = w,
        h = h,
        xoff = raw.xoff or 0,
        yoff = raw.yoff or 0,
        dwidth = raw.dwidth,
        rows = raw.rows
    }
end

local function parse_bdf(data)
    local ascent = DEFAULT_ASCENT
    local descent = DEFAULT_DESCENT
    local entries = {}

    local current = nil
    local in_bitmap = false

    for line in (data .. "\n"):gmatch("([^\n]*)\n") do
        line = line:gsub("\r$", "")

        if in_bitmap then
            if line == "ENDCHAR" then
                in_bitmap = false
                local entry = finalize_char(current)
                if entry then
                    entries[#entries + 1] = entry
                end
                current = nil
            elseif current and current.rows then
                current.rows[#current.rows + 1] = line
            end
        elseif line == "BITMAP" then
            in_bitmap = true
            current = current or {}
            current.rows = {}
        else
            local key, value = line:match("^(%u[%u_]*)%s+(.*)$")
            if key == "ENCODING" then
                current = current or {}
                current.encoding = tonumber(value:match("^-?%d+"))
            elseif key == "DWIDTH" then
                current = current or {}
                current.dwidth = tonumber(value:match("^%d+"))
            elseif key == "BBX" then
                local w, h, xo, yo = value:match("^(%-?%d+)%s+(%-?%d+)%s+(%-?%d+)%s+(%-?%d+)")
                if w then
                    current = current or {}
                    current.w, current.h = tonumber(w), tonumber(h)
                    current.xoff, current.yoff = tonumber(xo), tonumber(yo)
                end
            elseif key == "FONT_ASCENT" then
                ascent = tonumber(value:match("^%d+")) or ascent
            elseif key == "FONT_DESCENT" then
                descent = tonumber(value:match("^%d+")) or descent
            end
        end
    end

    return entries, ascent, descent
end

local function blit_glyph(image_data, entry, slot_x, slot_y)
    local bytes_per_row = math.ceil(entry.w / 8)

    for row = 0, entry.h - 1 do
        local hex = entry.rows[row + 1]
        if hex then
            for byte_index = 0, bytes_per_row - 1 do
                local byte = tonumber(hex:sub(byte_index * 2 + 1, byte_index * 2 + 2), 16) or 0
                local bits = BYTE_BITS[byte]

                for bit = 0, 7 do
                    local px = byte_index * 8 + bit
                    if bits[bit + 1] == 1 and px < entry.w and px < SLOT_W and row < SLOT_H then
                        image_data:setPixel(slot_x + px, slot_y + row, 1, 1, 1, 1)
                    end
                end
            end
        end
    end
end

local function build_font(entries, ascent, descent)
    local row_count = math.ceil(#entries / PER_ROW)
    local atlas_w = PER_ROW * SLOT_W
    local atlas_h = row_count * SLOT_H
    local image_data = love.image.newImageData(atlas_w, atlas_h)

    local glyphs = {}

    for index, entry in ipairs(entries) do
        local slot_x = ((index - 1) % PER_ROW) * SLOT_W
        local slot_y = math.floor((index - 1) / PER_ROW) * SLOT_H

        blit_glyph(image_data, entry, slot_x, slot_y)

        glyphs[entry.char] = {
            quad = love.graphics.newQuad(slot_x, slot_y, SLOT_W, SLOT_H, atlas_w, atlas_h),
            ox = entry.xoff,
            oy = ascent - (entry.yoff + entry.h),
            dwidth = entry.dwidth or SLOT_W
        }
        -- print(entry.char .. "\t" .. entry.xoff)
    end

    local image = love.graphics.newImage(image_data)
    image:setFilter("nearest", "nearest")

    return {
        image = image,
        glyphs = glyphs,
        height = ascent + descent,
        ascent = ascent
    }
end

local function read_bdf()
    if raw_data == nil then
        raw_data = love.filesystem.read(BDF_PATH)
    end
    return raw_data
end

local function load_font()
    local data = read_bdf()
    if not data or #data == 0 then
        return nil
    end

    local entries, ascent, descent = parse_bdf(data)
    if #entries == 0 then
        return nil
    end

    return build_font(entries, ascent, descent)
end

function quan.get()
    if cached_font == nil then
        cached_font = load_font()
    end
    return cached_font
end

local function release_font()
    local image = cached_font and cached_font.image
    if image and image.release then
        pcall(image.release, image)
    end
end

function quan.load_file(path)
    local file, open_err = io.open(path, "rb")
    if not file then
        return false, open_err
    end

    local data = file:read("*a")
    file:close()

    if not data or #data == 0 then
        return false, "empty BDF file: " .. tostring(path)
    end

    local entries, ascent, descent = parse_bdf(data)
    if #entries == 0 then
        return false, "no usable glyphs in BDF: " .. tostring(path)
    end

    local font = nil
    if love and love.graphics then
        local built, result = pcall(build_font, entries, ascent, descent)
        if not built then
            return false, tostring(result)
        end
        font = result
    end

    release_font()
    raw_data = data
    cached_font = font

    return true
end

function quan.reset()
    release_font()
    raw_data = nil
    cached_font = nil
end

return quan
