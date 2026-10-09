-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local fontprint = require("src.utils.font_print")
local game = require("src.game.game")
local utils = require("src.utils.utils")
local menu = require("src.menu.menu")
local locale = require("src.utils.locale")
local input = require("src.game.input")
local skin = require("src.game.skin")

local render = {}

local next_count = 3

local empty_link = { false, false, false, false, false, false, false, false }

local function get_link_ls(is_solid)
    return {
        is_solid(0, 1), is_solid(0, -1), is_solid(-1, 0), is_solid(1, 0),
        is_solid(-1, 1), is_solid(1, 1), is_solid(-1, -1), is_solid(1, -1),
    }
end

local function solid(m, n, r, c)
    return r >= 1 and r <= n and c >= 1 and c <= n and m[r][c] ~= 0
end

local function matrix_link(m, r, c)
    local n = #m
    return {
        solid(m, n, r - 1, c), solid(m, n, r + 1, c), solid(m, n, r, c - 1), solid(m, n, r, c + 1),
        solid(m, n, r - 1, c - 1), solid(m, n, r - 1, c + 1), solid(m, n, r + 1, c - 1), solid(m, n, r + 1, c + 1),
    }
end

local function draw_block(px, py, bs, color, transparent, link)
    local c = color
    if transparent then c = utils.color_blend(utils.strip_a(color), { 0, 0, 0, 0 }, 0.5) end
    skin.base(px, py, bs, link or empty_link, c)
end

local function has_same_block(x, y, id, drop_count)
    if y > game.pf.height then
        return false
    end

    local row = game.pf_data[y]
    local r = true
    r = r and row and row[x]
    r = r and row[x].id == id

    if id > 0 and game.active_settings.display.split_minos then
        r = r and row[x].drop_count == drop_count
    end

    return not not r
end

local function pf_cell_link(x, y, id)
    local drop_count = game.pf_data[y][x].drop_count
    local func = function(dx, dy) return has_same_block(x + dx, y + dy, id, drop_count) end
    return get_link_ls(func)
end

local function draw_goal_lines(gx, gy, pw, ph, bs)
    local mode_state = game.mode_state
    if not mode_state or not mode_state.goal_lines then return end
    if not game.pf then return end

    for _, m in ipairs(mode_state.goal_lines) do
        local remaining = m.line - game.clears
        if remaining >= 1 and remaining <= game.pf.height then
            local py = gy + ph - remaining * bs
            m.text = m.text or ""
            love.graphics.setColor(unpack(m.color))
            love.graphics.rectangle("fill", gx, py, pw, 1)
            fontprint.print(Fonts.comment, m.text, gx, py + 1, 1, Colors.goal_lines_comment)
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
                local cell = row[x]
                if cell then
                    draw_block(gx + (x - 1) * bs, py, bs, cell.color, false, pf_cell_link(x, y, cell.id))
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
                    local border_color = utils.color_blend(utils.strip_a(cell.color), utils.strip_a(Colors.mino_border),
                        Colors.mino_border[4])

                    skin.borders(px, py, bs, pf_cell_link(x, y, cell.id), border_color)
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

                skin.borders(px, py, bs, matrix_link(m, r, c), border_color)
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

    local cells = game.piece_cells(p)
    local cell_set = {}
    for _, cell in ipairs(cells) do
        cell_set[cell.x] = cell_set[cell.x] or {}
        cell_set[cell.x][cell.y] = true
    end
    local cell_links = {}
    for i, cell in ipairs(cells) do
        cell_links[i] = get_link_ls(function(dx, dyy)
            local col = cell_set[cell.x + dx]
            return (col and col[cell.y + dyy]) or false
        end)
    end

    local ghost_ox, ghost_oy = gx + (p.x - 2) * bs, gy + ph - (p.y + dy + 1) * bs
    for i, cell in ipairs(cells) do
        local gy2 = cell.y + dy
        if gy2 >= 1 and gy2 <= game.pf.height then
            local ghost_color = utils.strip_a(color)
            ghost_color[4] = 0.25
            draw_block(gx + (cell.x - 1) * bs, gy + ph - gy2 * bs, bs, ghost_color, false, cell_links[i])
        end
    end
    draw_matrix_borders(m, ghost_ox, ghost_oy, bs, color, Colors.ghost_border)

    local ox, oy = gx + (p.x - 2) * bs, gy + ph - (p.y + 1) * bs
    for i, cell in ipairs(cells) do
        if cell.y >= 1 and cell.y <= game.pf.height then
            draw_block(gx + (cell.x - 1) * bs, gy + ph - cell.y * bs, bs, color, false, cell_links[i])
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
            fontprint.print(Fonts.bold_font, tostring(cell.label), px, py, 1, Colors.gray)
        end
    end
end

local function draw_spawn_marker(gx, gy, ph, bs)
    if not game.started then return end
    if not game.pf then return end
    if not game.active_settings or not game.active_settings.display.spawn_indicator then return end
    if not game.next[1] then return end

    local shape = game.next[1]
    local x0, y0 = game.spawn_point(shape)
    local m = game.get_matrix(shape, "0")
    local n = #m
    local cr = 2

    for r = 1, n do
        for c = 1, n do
            if m[r][c] ~= 0 then
                local cx = x0 + (c - cr)
                local cy = y0 + (cr - r)
                if cy >= 1 and cy <= game.pf.height then
                    local px = gx + (cx - 1) * bs
                    local py = gy + ph - cy * bs
                    fontprint.print(Fonts.bold_font, "▒", px, py, 1, Colors.gray)
                end
            end
        end
    end
end

local function draw_preview(shape, px, py, bs, transparent)
    local mino = game.shapes[shape]
    local m = mino.shapes
    local color = game.bone and game.bone_color or utils.get_value_if_func_call(mino.color)
    local pv = mino.preview
    local ox = px + pv.offset[1] * bs
    local oy = py - pv.offset[2] * bs
    local n = #m
    for r = 1, n do
        for c = 1, n do
            if m[r][c] ~= 0 then
                draw_block(ox + (c - 1) * bs, oy + (r - 1) * bs, bs, color, transparent, matrix_link(m, r, c))
            end
        end
    end
    draw_matrix_borders(m, ox, oy, bs, color, Colors.mino_border)
    return pv.width
end

local function draw_next_hold(font, gx, gy, pw, ph, bw, bs)
    if not game.started then return end
    local ix = gx + pw + bw + 8

    fontprint.print_outlined(font, "NEXT", ix, gy - 2, 1, Colors.white, Colors.out_line)
    local py = gy + 10
    local px = ix
    for i = 1, next_count do
        if game.next[i] then
            local w = draw_preview(game.next[i], px, py, bs)
            px = px + w * bs + 8
        end
    end

    local hold_y = py + 4 * bs
    fontprint.print_outlined(font, "HOLD", ix, hold_y, 1, Colors.white, Colors.out_line)
    if game.hold then
        draw_preview(game.hold, ix, hold_y + 12, bs, not game.can_hold)
    end
end

local function draw_modal(font, gx, gy, pw, ph, title_key)
    love.graphics.setColor(0, 0, 0, 0.6)
    love.graphics.rectangle("fill", gx, gy, pw, ph)

    local mode_name = locale.get(game.mode_key:upper())
    menu.print_with_dim(mode_name, gx + 4, gy + 4, 1, Colors.gray, Colors.out_line, menu.get_dim_config("gray"))

    local items = game.get_modal_items()
    local n = #items
    local content_h = 8 + 10 + (n - 1) * 10 + 8
    local top = math.ceil((ph - content_h) / 2)

    local label = locale.get(title_key or "PAUSE")
    local lw = utils.utf8_len(label) * 8
    menu.print_with_dim(label, gx + (pw - lw) / 2, gy + top, 1, Colors.white, Colors.out_line,
        menu.get_dim_config("white"))

    for i, key in ipairs(items) do
        local text = locale.get(key)
        local w = utils.utf8_len(text) * 8
        if i == game.modal_selection then
            menu.print_with_dim(text, gx + (pw - w) / 2, gy + top + 8 + 10 + (i - 1) * 10, 1, Colors.yellow,
                Colors.out_line, menu.get_dim_config("yellow"))
        else
            menu.print_with_dim(text, gx + (pw - w) / 2, gy + top + 8 + 10 + (i - 1) * 10, 1, Colors.white,
                Colors.out_line, menu.get_dim_config("white"))
        end
    end
end

local function draw_game_info(font, gx, gy, pw, ph, bw)
    local ix = gx + pw + bw + 8
    local iy = gy + ph + bw - 8


    local sign = game.time < 0 and "-" or " "

    local info = {
        scores = string.format("SCORE  %d", game.scores),
        clears = string.format("CLEAR  %d", game.clears),
        level  = string.format("LEVEL  %s", game.level),
        ren    = (game.ren >= 0) and string.format("REN    %d", game.ren) or string.format("REN   %d", game.ren),
        b2b    = string.format("B2B    %d", game.b2b),

        time   = string.format("TIME  %s%s", sign, utils.format_time(game.time)),
    }

    local total = game.lock_resets_total
    local left = (game.piece and game.piece.lock_resets) or game.lock_resets_total

    if game.notify and game.notify.time > 0 and game.notify.text then
        local show_color = utils.color_blend(game.notify.color, Colors.white, 0.4)
        fontprint.print_outlined(font, game.notify.text, ix, iy - 8 * 9, 1, utils.strip_a(show_color), Colors.out_line)
    end

    local ren_color = (game.ren > 0) and Colors.yellow or Colors.white
    local b2b_color = (game.b2b > 0) and Colors.yellow or Colors.white

    fontprint.print_outlined(font, info.scores, ix, iy - 8 * 7, 1, Colors.white, Colors.out_line)
    fontprint.print_outlined(font, info.clears, ix, iy - 8 * 6, 1, Colors.white, Colors.out_line)
    fontprint.print_outlined(font, info.level, ix, iy - 8 * 5, 1, Colors.white, Colors.out_line)
    fontprint.print_outlined(font, info.ren, ix, iy - 8 * 4, 1, ren_color, Colors.out_line)
    fontprint.print_outlined(font, info.b2b, ix, iy - 8 * 3, 1, b2b_color, Colors.out_line)
    fontprint.print_outlined(font, info.time, ix, iy - 8 * 1, 1, Colors.white, Colors.out_line)

    if game.lock_resets_total ~= math.huge then
        fontprint.print_outlined(font, string.rep("♦", total), ix, iy - 8 * 0, 1, Colors.gray, Colors.out_line)
        fontprint.print_outlined(font, string.rep("♦", left), ix, iy - 8 * 0, 1, Colors.white, Colors.out_line)
    else
        fontprint.print_outlined(font, "∞", ix, iy - 8 * 0, 1, Colors.white, Colors.out_line)
    end
end

local function draw_key_info(font)
    if not game.active_settings then return end
    if game.active_settings.display.key_info then
        local ix = 320 - 8 * 11 - 2
        local iy = 0
        local game_modal = game.modal_active or game.over or game.cleared

        fontprint.print_outlined(font, "███████████", ix, iy, 1, Colors.white)
        fontprint.print(font, "🠸", ix + 10 * 1, iy, 1,
            (input.now.left and (not game_modal)) and Colors.key or Colors.black)
        fontprint.print(font, "🠺", ix + 10 * 2, iy, 1,
            (input.now.right and (not game_modal)) and Colors.key or Colors.black)
        fontprint.print(font, "🠻", ix + 10 * 3, iy, 1,
            (input.now.soft_drop and (not game_modal)) and Colors.key or Colors.black)
        fontprint.print(font, "🡇", ix + 10 * 4, iy, 1,
            (input.now.hard_drop and (not game_modal)) and Colors.key or Colors.black)
        fontprint.print(font, "⮀", ix + 10 * 5, iy, 1,
            (input.now.hold and (not game_modal)) and Colors.key or Colors.black)
        fontprint.print(font, "↺", ix + 10 * 6, iy, 1,
            (input.now.ccw and (not game_modal)) and Colors.key or Colors.black)
        fontprint.print(font, "↻", ix + 10 * 7, iy, 1, (input.now.cw and (not game_modal)) and Colors.key or Colors
            .black)
        fontprint.print(font, "🗘", ix + 10 * 8, iy, 1,
            (input.now.rot180 and (not game_modal)) and Colors.key or Colors.black)
    end
end

function render.draw(gx, gy, pw, ph, bw, bs)
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
    draw_spawn_marker(gx, gy, ph, bs)
    draw_piece(gx, gy, ph, bs)
    draw_spin_mask(gx, gy, ph, bs)
    draw_next_hold(Fonts.bold_font, gx, gy, pw, ph, bw, bs)
    draw_game_info(Fonts.bold_font, gx, gy, pw, ph, bw)

    local _ = menu.state == "GAME" and draw_key_info(Fonts.ui_fonts)

    if game.cleared then
        love.graphics.setColor(0, 0, 0, 0.6)
        love.graphics.rectangle("fill", gx, gy, pw, ph)

        local tip = locale.get("BACK_TIP")
        menu.print_with_dim(tip, gx + 4, gy + 4, 1, Colors.gray, Colors.out_line, menu.get_dim_config("gray"))

        local label = "CLEAR"
        local lw = utils.utf8_len(label) * 8
        local cy = gy + ph / 2 - 16
        fontprint.print_outlined(Fonts.bold_font, label, gx + (pw - lw) / 2, cy, 1, Colors.white, Colors.out_line)

        local y = gy + ph / 2
        for _, it in ipairs(game.result) do
            local text = tostring(it)
            local w = utils.utf8_len(text) * 8
            fontprint.print_outlined(Fonts.bold_font, text, gx + (pw - w) / 2, y, 1, Colors.white, Colors.out_line)
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
            label = locale.get("READY")
        else
            label = locale.get("GO")
        end
        local lw = utils.utf8_len(label) * 8
        menu.print_with_dim(label, gx + (pw - lw) / 2, gy + (ph - 8) / 2, 1, Colors.white, Colors.out_line,
            menu.get_dim_config("white"))
    end
end

return render
