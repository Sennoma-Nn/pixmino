-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local vgafont = require("lib.vgafont")
local game = require("game")
local utils = require("utils")
local menu = require("menu")
local locale = require("locale")

local render = {}

local next_count = 3

local function draw_block(px, py, bs, color)
    love.graphics.setColor(unpack(color))
    love.graphics.rectangle("fill", px, py, bs, bs)
end

local function has_same_id(x, y, id)
    local row = game.pf_data[y]
    return row and row[x] and row[x].id == id
end

local function draw_playfield_cells(gx, gy, ph, bs)
    if not game.pf then return end
    for y = 1, game.pf.height do
        local row = game.pf_data[y]
        if row then
            local py = gy + ph - y * bs
            for x = 1, game.pf.width do
                if row[x] then
                    draw_block(gx + (x - 1) * bs, py, bs, row[x].color)
                end
            end
        end
    end
end

local function draw_mino_borders(gx, gy, ph, bs)
    if not game.pf then return end
    love.graphics.setColor(unpack(Colors.mino_border))
    for y = 1, game.pf.height do
        local row = game.pf_data[y]
        if row then
            local py = gy + ph - y * bs
            for x = 1, game.pf.width do
                local cell = row[x]
                if cell then
                    local px = gx + (x - 1) * bs
                    local id = cell.id

                    if not has_same_id(x, y + 1, id) then
                        love.graphics.rectangle("fill", px + 1, py, bs - 2, 1)
                    end
                    if not has_same_id(x, y - 1, id) then
                        love.graphics.rectangle("fill", px + 1, py + bs - 1, bs - 2, 1)
                    end
                    if not has_same_id(x - 1, y, id) then
                        love.graphics.rectangle("fill", px, py + 1, 1, bs - 2)
                    end
                    if not has_same_id(x + 1, y, id) then
                        love.graphics.rectangle("fill", px + bs - 1, py + 1, 1, bs - 2)
                    end

                    love.graphics.rectangle("fill", px, py, 1, 1)
                    love.graphics.rectangle("fill", px + bs - 1, py, 1, 1)
                    love.graphics.rectangle("fill", px, py + bs - 1, 1, 1)
                    love.graphics.rectangle("fill", px + bs - 1, py + bs - 1, 1, 1)
                end
            end
        end
    end
end

local function draw_matrix_borders(m, origin_px, origin_py, bs, border_color)
    local n = #m
    love.graphics.setColor(unpack(border_color or Colors.mino_border))
    for r = 1, n do
        for c = 1, n do
            if m[r][c] ~= 0 then
                local px = origin_px + (c - 1) * bs
                local py = origin_py + (r - 1) * bs

                if r - 1 < 1 or m[r - 1][c] == 0 then
                    love.graphics.rectangle("fill", px + 1, py, bs - 2, 1)
                end
                if r + 1 > n or m[r + 1][c] == 0 then
                    love.graphics.rectangle("fill", px + 1, py + bs - 1, bs - 2, 1)
                end
                if c - 1 < 1 or m[r][c - 1] == 0 then
                    love.graphics.rectangle("fill", px, py + 1, 1, bs - 2)
                end
                if c + 1 > n or m[r][c + 1] == 0 then
                    love.graphics.rectangle("fill", px + bs - 1, py + 1, 1, bs - 2)
                end

                love.graphics.rectangle("fill", px, py, 1, 1)
                love.graphics.rectangle("fill", px + bs - 1, py, 1, 1)
                love.graphics.rectangle("fill", px, py + bs - 1, 1, 1)
                love.graphics.rectangle("fill", px + bs - 1, py + bs - 1, 1, 1)
            end
        end
    end
end

local function draw_piece(gx, gy, ph, bs)
    if not game.piece then return end
    local p = game.piece
    local m = game.get_matrix(p.shape, p.dir)
    local dy = game.drop_y(p) - p.y

    local ghost_ox, ghost_oy = gx + (p.x - 2) * bs, gy + ph - (p.y + dy + 1) * bs
    for _, cell in ipairs(game.piece_cells(p)) do
        local gy2 = cell.y + dy
        if gy2 >= 1 and gy2 <= game.pf.height then
            local ghost_color = { p.color[1], p.color[2], p.color[3], 0.25 }
            draw_block(gx + (cell.x - 1) * bs, gy + ph - gy2 * bs, bs, ghost_color)
        end
    end
    draw_matrix_borders(m, ghost_ox, ghost_oy, bs, Colors.ghost_border)

    local ox, oy = gx + (p.x - 2) * bs, gy + ph - (p.y + 1) * bs
    for _, cell in ipairs(game.piece_cells(p)) do
        if cell.y >= 1 and cell.y <= game.pf.height then
            draw_block(gx + (cell.x - 1) * bs, gy + ph - cell.y * bs, bs, p.color)
        end
    end
    draw_matrix_borders(m, ox, oy, bs, Colors.piece_border)
end

local function draw_preview(shape, px, py, bs)
    local mino = game.shapes[shape]
    local m = mino.shapes
    local color = mino.color
    local pv = mino.preview
    local ox = px + pv.offset[1] * bs
    local oy = py - pv.offset[2] * bs
    local n = #m
    for r = 1, n do
        for c = 1, n do
            if m[r][c] ~= 0 then
                draw_block(ox + (c - 1) * bs, oy + (r - 1) * bs, bs, color)
            end
        end
    end
    draw_matrix_borders(m, ox, oy, bs)
    return pv.width
end

local function draw_next_hold(font, gx, gy, pw, ph, bw, bs)
    if not game.started then return end
    local ix = gx + pw + bw + 8

    vgafont.print_outlined(font, "NEXT", ix, gy - 2, 1, Colors.white, Colors.out_line)
    local py = gy + 10
    local px = ix
    for i = 1, next_count do
        if game.next[i] then
            local w = draw_preview(game.next[i], px, py, bs)
            px = px + w * bs + 8
        end
    end

    local hold_y = py + 4 * bs
    vgafont.print_outlined(font, "HOLD", ix, hold_y, 1, Colors.white, Colors.out_line)
    if game.hold then
        draw_preview(game.hold, ix, hold_y + 12, bs)
    end
end

local function draw_game_info(font, gx, gy, pw, ph, bw)
    local ix = gx + pw + bw + 8
    local iy = gy + ph + bw - 8


    local sign = game.time < 0 and "-" or " "

    local info = {
        scores = string.format("SCORES %d", game.scores),
        clears = string.format("CLEARS %d", game.clears),
        level  = string.format("LEVEL  %d", game.level),
        ren    = (game.ren >= 0) and string.format("REN    %d", game.ren) or string.format("REN   %d", game.ren),
        b2b    = string.format("B2B    %d", game.b2b),

        time   = string.format("TIME  %s%s", sign, utils.format_time(game.time)),
    }

    local total = game.lock_resets_total
    local left = (game.piece and game.piece.lock_resets) or 0

    if game.notify and game.notify.time > 0 and game.notify.text then
        local show_color = utils.color_blend(game.notify.color, Colors.white, 0.4)
        vgafont.print_outlined(font, game.notify.text, ix, iy - 8 * 9, 1, show_color, Colors.out_line)
    end

    local ren_color = (game.ren > 0) and Colors.yellow or Colors.white
    local b2b_color = (game.b2b > 0) and Colors.yellow or Colors.white

    vgafont.print_outlined(font, info.scores, ix, iy - 8 * 7, 1, Colors.white, Colors.out_line)
    vgafont.print_outlined(font, info.clears, ix, iy - 8 * 6, 1, Colors.white, Colors.out_line)
    vgafont.print_outlined(font, info.level, ix, iy - 8 * 5, 1, Colors.white, Colors.out_line)
    vgafont.print_outlined(font, info.ren, ix, iy - 8 * 4, 1, ren_color, Colors.out_line)
    vgafont.print_outlined(font, info.b2b, ix, iy - 8 * 3, 1, b2b_color, Colors.out_line)
    vgafont.print_outlined(font, info.time, ix, iy - 8 * 1, 1, Colors.white, Colors.out_line)
    vgafont.print_outlined(font, string.rep("♦", total), ix, iy - 8 * 0, 1, Colors.gray, Colors.out_line)
    vgafont.print_outlined(font, string.rep("♦", left), ix, iy - 8 * 0, 1, Colors.white, Colors.out_line)
end

function render.draw(gx, gy, pw, ph, bw, bs)
    love.graphics.clear(unpack(Colors.background))

    love.graphics.setColor(unpack(Colors.playfield_bg))
    love.graphics.rectangle("fill", gx, gy, pw, ph)

    love.graphics.setColor(unpack(Colors.white))
    love.graphics.rectangle("fill", gx - bw, gy - bw, pw + bw * 2, bw)
    love.graphics.rectangle("fill", gx - bw, gy + ph, pw + bw * 2, bw)
    love.graphics.rectangle("fill", gx - bw, gy, bw, ph)
    love.graphics.rectangle("fill", gx + pw, gy, bw, ph)

    draw_playfield_cells(gx, gy, ph, bs)
    draw_mino_borders(gx, gy, ph, bs)
    draw_piece(gx, gy, ph, bs)
    draw_next_hold(Fonts.bold_font, gx, gy, pw, ph, bw, bs)
    draw_game_info(Fonts.bold_font, gx, gy, pw, ph, bw)

    if game.cleared then
        love.graphics.setColor(0, 0, 0, 0.6)
        love.graphics.rectangle("fill", gx, gy, pw, ph)

        vgafont.print(Fonts.ui_fonts, locale.get("BACK_TIP"), gx + 4, gy + 4, 1, Colors.gray)

        local label = "CLEAR"
        local lw = utils.utf8_len(label) * 8
        local cy = gy + ph / 2 - 16
        vgafont.print(Fonts.bold_font, label, gx + (pw - lw) / 2, cy, 1, Colors.white)

        local y = gy + ph / 2
        for _, item in ipairs(game.result) do
            local text = tostring(item)
            local w = utils.utf8_len(text) * 8
            vgafont.print(Fonts.bold_font, text, gx + (pw - w) / 2, y, 1, Colors.white)
            y = y + 8
        end
    end

    if game.time < 0 and menu.state == "GAME" then
        local label
        if game.time < -0.5 then
            label = "READY"
        else
            label = "GO"
        end
        local lw = utils.utf8_len(label) * 8
        vgafont.print(Fonts.bold_font, label, gx + (pw - lw) / 2, gy + (ph - 8) / 2, 1, Colors.white)
    end
end

return render
