-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local vgafont = require("lib.vgafont")
local game = require("src.game.game")
local utils = require("src.utils.utils")
local menu = require("src.menu.menu")
local locale = require("src.utils.locale")

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

local function draw_goal_lines(gx, gy, pw, ph, bs)
    local mode_state = game.mode_state
    if not mode_state or not mode_state.goal_lines then return end
    if not game.pf then return end

    for _, m in ipairs(mode_state.goal_lines) do
        local remaining = m.line - game.clears
        if remaining >= 1 and remaining <= game.pf.height then
            local py = gy + ph - remaining * bs
            love.graphics.setColor(unpack(m.color))
            love.graphics.rectangle("fill", gx, py, pw, 1)
        end
    end
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
    for y = 1, game.pf.height do
        local row = game.pf_data[y]
        if row then
            local py = gy + ph - y * bs
            for x = 1, game.pf.width do
                local cell = row[x]
                if cell then
                    local px = gx + (x - 1) * bs
                    local id = cell.id
                    local border_color = utils.color_blend(utils.strip_a(cell.color), utils.strip_a(Colors.mino_border),
                        Colors.mino_border[4])
                    love.graphics.setColor(unpack(border_color))

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

local function draw_matrix_borders(m, origin_px, origin_py, bs, color, base_color)
    local n = #m
    for r = 1, n do
        for c = 1, n do
            if m[r][c] ~= 0 then
                local px = origin_px + (c - 1) * bs
                local py = origin_py + (r - 1) * bs
                local border_color = utils.color_blend(utils.strip_a(color), utils.strip_a(base_color), base_color[4])
                love.graphics.setColor(unpack(border_color))

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
    local color = game.bone and game.bone_color or p.color

    local ghost_ox, ghost_oy = gx + (p.x - 2) * bs, gy + ph - (p.y + dy + 1) * bs
    for _, cell in ipairs(game.piece_cells(p)) do
        local gy2 = cell.y + dy
        if gy2 >= 1 and gy2 <= game.pf.height then
            local ghost_color = utils.strip_a(color)
            ghost_color[4] = 0.25
            draw_block(gx + (cell.x - 1) * bs, gy + ph - gy2 * bs, bs, ghost_color)
        end
    end
    draw_matrix_borders(m, ghost_ox, ghost_oy, bs, color, Colors.ghost_border)

    local ox, oy = gx + (p.x - 2) * bs, gy + ph - (p.y + 1) * bs
    for _, cell in ipairs(game.piece_cells(p)) do
        if cell.y >= 1 and cell.y <= game.pf.height then
            draw_block(gx + (cell.x - 1) * bs, gy + ph - cell.y * bs, bs, color)
        end
    end
    draw_matrix_borders(m, ox, oy, bs, color, Colors.piece_border)
end

local function draw_spin_mask(gx, gy, ph, bs)
    if not game.draw_spin_mask then return end
    if not game.piece then return end

    for _, cell in ipairs(game.spin_mask_cells(game.piece)) do
        if cell.y >= 1 and cell.y <= game.pf.height then
            local px = gx + (cell.x - 1) * bs
            local py = gy + ph - cell.y * bs
            vgafont.print(Fonts.bold_font, tostring(cell.label), px, py, 1, Colors.gray)
        end
    end
end

local function draw_preview(shape, px, py, bs)
    local mino = game.shapes[shape]
    local m = mino.shapes
    local color = game.bone and game.bone_color or mino.color
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
    draw_matrix_borders(m, ox, oy, bs, color, Colors.mino_border)
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

local function draw_modal(font, gx, gy, pw, ph, title_key)
    love.graphics.setColor(0, 0, 0, 0.6)
    love.graphics.rectangle("fill", gx, gy, pw, ph)

    local mode_name = locale.get(game.mode_key:upper())
    vgafont.print_outlined(Fonts.ui_fonts, mode_name, gx + 4, gy + 4, 1, Colors.gray, Colors.out_line)

    local items = game.get_modal_items()
    local n = #items
    local content_h = 8 + 10 + (n - 1) * 10 + 8
    local top = math.ceil((ph - content_h) / 2)

    local label = locale.get(title_key or "PAUSE")
    local lw = utils.utf8_len(label) * 8
    vgafont.print_outlined(Fonts.ui_fonts, label, gx + (pw - lw) / 2, gy + top, 1, Colors.white, Colors.out_line)

    for i, key in ipairs(items) do
        local text = locale.get(key)
        local w = utils.utf8_len(text) * 8
        local color = (i == game.modal_selection) and Colors.yellow or Colors.white
        vgafont.print_outlined(Fonts.ui_fonts, text, gx + (pw - w) / 2, gy + top + 8 + 10 + (i - 1) * 10, 1, color,
            Colors.out_line)
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
        vgafont.print_outlined(font, game.notify.text, ix, iy - 8 * 9, 1, utils.strip_a(show_color), Colors.out_line)
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

    draw_goal_lines(gx, gy, pw, ph, bs)
    draw_playfield_cells(gx, gy, ph, bs)
    draw_mino_borders(gx, gy, ph, bs)
    draw_piece(gx, gy, ph, bs)
    draw_spin_mask(gx, gy, ph, bs)
    draw_next_hold(Fonts.bold_font, gx, gy, pw, ph, bw, bs)
    draw_game_info(Fonts.bold_font, gx, gy, pw, ph, bw)

    if game.cleared then
        love.graphics.setColor(0, 0, 0, 0.6)
        love.graphics.rectangle("fill", gx, gy, pw, ph)

        vgafont.print_outlined(Fonts.ui_fonts, locale.get("BACK_TIP"), gx + 4, gy + 4, 1, Colors.gray, Colors.out_line)

        local label = "CLEAR"
        local lw = utils.utf8_len(label) * 8
        local cy = gy + ph / 2 - 16
        vgafont.print_outlined(Fonts.bold_font, label, gx + (pw - lw) / 2, cy, 1, Colors.white, Colors.out_line)

        local y = gy + ph / 2
        for _, item in ipairs(game.result) do
            local text = tostring(item)
            local w = utils.utf8_len(text) * 8
            vgafont.print_outlined(Fonts.bold_font, text, gx + (pw - w) / 2, y, 1, Colors.white, Colors.out_line)
            y = y + 8
        end
    elseif game.over then
        draw_modal(Fonts.bold_font, gx, gy, pw, ph, "GAME_OVER")
    elseif game.modal_active then
        draw_modal(Fonts.bold_font, gx, gy, pw, ph, "PAUSE")
    end

    if game.time < 0 and menu.state == "GAME" and not game.modal_active then
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
