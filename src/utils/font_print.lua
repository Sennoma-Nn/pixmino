-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local vgafont = require("lib.vgafont")
local utils = require("src.utils.utils")

local fontprint = {}

local SLOT_W = 8

local function is_font_list(fonts)
    return fonts[1] ~= nil and fonts.height == nil
end

local function get_bdf(fonts)
    return fonts.bdf
end

local function find_vga(fonts, c)
    if is_font_list(fonts) then
        for _, f in ipairs(fonts) do
            local code = vgafont.char_to_code(f, c)
            if code ~= nil and code >= 0 and code <= 255 then
                return f, code
            end
        end
    else
        local code = vgafont.char_to_code(fonts, c)
        if code ~= nil and code >= 0 and code <= 255 then
            return fonts, code
        end
    end
    return nil
end

local function has_vga_glyph(fonts, c)
    return find_vga(fonts, c) ~= nil
end

local function draw_bdf_glyph(bdf, g, x, y, scale, color, outline)
    love.graphics.setColor(unpack(color))
    local img = bdf.image
    if outline then
        local bx = x + g.ox + 1
        local by = y + g.oy + 1
        for dy = -1, 1 do
            for dx = -1, 1 do
                love.graphics.draw(img, g.quad, bx + dx, by + dy, 0, scale, scale)
            end
        end
    else
        love.graphics.draw(img, g.quad, x + g.ox, y + g.oy, 0, scale, scale)
    end
end

local function print_ex(fonts, text, x, y, scale, color, outline)
    scale = scale or 1
    color = color or {1, 1, 1, 1}

    local fh = vgafont.get_height(fonts)
    local char_w = SLOT_W * scale
    local line_h = fh * scale

    local bdf = get_bdf(fonts)

    local cx = x
    local cy = y
    local i = 1
    local n = #text

    while i <= n do
        local byte = string.byte(text, i)
        local len = utils.utf8_char_len(byte)
        if len == 0 then len = 1 end
        local c = text:sub(i, i + len - 1)

        if c == "\n" then
            cy = cy + line_h
        elseif c == "\r" then
            cx = x
        else
            local matched, code = find_vga(fonts, c)
            if matched then
                local image = outline and matched.image_outline or matched.image
                local quads = outline and matched.quads_outline or matched.quads
                vgafont._draw_char_ex(cx, cy, code, scale, color, image, quads)
            else
                local g = bdf and bdf.glyphs[c]
                if g then
                    draw_bdf_glyph(bdf, g, cx, cy, scale, color, outline)
                end
            end
            cx = cx + char_w
        end

        i = i + len
    end
end

function fontprint.print(fonts, text, x, y, scale, color)
    scale = scale or 1
    color = color or {1, 1, 1, 1}
    print_ex(fonts, text, x, y, scale, color, false)
end

function fontprint.print_outlined(fonts, text, x, y, scale, color, outline_color)
    scale = scale or 1
    color = color or {1, 1, 1, 1}
    outline_color = outline_color or {0, 0, 0, 1}

    print_ex(fonts, text, x - 1, y - 1, scale, outline_color, true)
    print_ex(fonts, text, x, y, scale, color, false)
end

function fontprint.draw_char(fonts, x, y, char, scale, color)
    color = color or {1, 1, 1, 1}
    scale = scale or 1

    if type(char) ~= "number" then
        if not has_vga_glyph(fonts, char) then
            local bdf = get_bdf(fonts)
            local g = bdf and bdf.glyphs[char]
            if g then
                draw_bdf_glyph(bdf, g, x, y, scale, color)
                return
            end
        end
    end

    vgafont.draw_char(fonts, x, y, char, scale, color)
end

function fontprint.get_height(fonts)
    return vgafont.get_height(fonts)
end

return fontprint
