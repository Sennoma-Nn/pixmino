-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local vgafont = require("lib.vgafont")

local game = {}

local shapes = {
    I = {
        {0,0,0,0},
        {1,1,1,1},
        {0,0,0,0},
        {0,0,0,0}
    },
    O = {
        {0,0,0,0},
        {0,1,1,0},
        {0,1,1,0},
        {0,0,0,0}
    },
    T = {
        {0,1,0},
        {1,1,1},
        {0,0,0}
    },
    S = {
        {0,1,1},
        {1,1,0},
        {0,0,0}
    },
    Z = {
        {1,1,0},
        {0,1,1},
        {0,0,0}
    },
    J = {
        {1,0,0},
        {1,1,1},
        {0,0,0}
    },
    L = {
        {0,0,1},
        {1,1,1},
        {0,0,0}
    },
}

local shape_colors = {
    I = { 0.2, 0.8, 1.0, 1 },
    O = { 1.0, 0.9, 0.4, 1 },
    T = { 0.7, 0.4, 1.0, 1 },
    S = { 0.2, 0.9, 0.5, 1 },
    Z = { 1.0, 0.4, 0.4, 1 },
    J = { 0.3, 0.5, 1.0, 1 },
    L = { 1.0, 0.6, 0.3, 1 },
}

local lock_delay = 0.5
local lock_resets = 30
local next_count = 3

game.pf_data = {}
game.bag = {}
game.next = {}
game.hold = nil
game.can_hold = true
game.piece = nil
game.piece_id = 0
game.started = false
game.pf = nil
game.debug_flags = {}

game.time = 0
game.clears = 0
game.scores = 0
game.level = 0

local cw    = { ["0"] = "R", ["R"] = "2", ["2"] = "L", ["L"] = "0" }
local ccw   = { ["0"] = "L", ["L"] = "2", ["2"] = "R", ["R"] = "0" }
local half  = { ["0"] = "2", ["2"] = "0", ["R"] = "L", ["L"] = "R" }

local function dbg(action)
    if not (game.debug_flags and game.debug_flags.piece) then return end
    local p = game.piece
    if p then
        print(action
            .. " id=" .. p.id
            .. " shape=" .. p.shape
            .. " dir=" .. p.dir
            .. " x=" .. p.x
            .. " y=" .. p.y
            .. " color=" .. table.concat(p.color, ",")
            .. " lock_delay=" .. p.lock_delay
            .. " lock_resets=" .. p.lock_resets
            .. " drop=" .. p.drop)
    end
end

function game.reset()
    game.time = 0
    game.clears = 0
    game.scores = 0
    game.level = 0
end

function game.stop()
    game.started = false
    game.pf = nil
    game.piece = nil
end

function game.set_debug(flags)
    game.debug_flags = flags
end

local function rot90(m)
    local n = #m
    local out = {}
    for r = 1, n do
        out[r] = {}
        for c = 1, n do
            out[r][c] = m[n - c + 1][r]
        end
    end
    return out
end

local function get_matrix(shape, dir)
    local m = shapes[shape]
    local rotations = { ["0"] = 0, ["R"] = 1, ["2"] = 2, ["L"] = 3 }
    for _ = 1, rotations[dir] do
        m = rot90(m)
    end
    return m, #m
end

local function piece_cells(piece)
    local m, n = get_matrix(piece.shape, piece.dir)
    local cr = 2
    local cells = {}
    for r = 1, n do
        for c = 1, n do
            if m[r][c] ~= 0 then
                cells[#cells + 1] = {
                    x = piece.x + (c - cr),
                    y = piece.y + (cr - r),
                }
            end
        end
    end
    return cells
end

local function collides(piece, x, y, dir)
    local m, n = get_matrix(piece.shape, dir)
    local cr = 2
    for r = 1, n do
        for c = 1, n do
            if m[r][c] ~= 0 then
                local cx = x + (c - cr)
                local cy = y + (cr - r)
                if cx < 1 or cx > game.pf.width or cy < 1 then
                    return true
                end
                local row = game.pf_data[cy]
                if row and row[cx] then
                    return true
                end
            end
        end
    end
    return false
end

local function is_grounded(piece)
    return collides(piece, piece.x, piece.y - 1, piece.dir)
end

local function drop_y(piece)
    local y = piece.y
    while not collides(piece, piece.x, y - 1, piece.dir) do
        y = y - 1
    end
    return y
end

local function reset_lock(piece)
    if piece.lock_resets <= 0 then return end
    piece.lock_resets = piece.lock_resets - 1
    piece.lock_delay = lock_delay
end

local function clear_lines()
    local max_y = 0
    for y in pairs(game.pf_data) do
        if y > max_y then max_y = y end
    end

    local cleared = 0
    local drop = 0
    for y = 1, max_y do
        local row = game.pf_data[y]
        if row then
            local full = true
            for x = 1, game.pf.width do
                if not row[x] then
                    full = false
                    break
                end
            end
            if full then
                cleared = cleared + 1
                drop = drop + 1
                game.pf_data[y] = nil
            elseif drop > 0 then
                game.pf_data[y - drop] = row
                game.pf_data[y] = nil
            end
        end
    end

    if cleared > 0 then
        game.clears = game.clears + cleared
    end
end

local function lock_piece()
    local p = game.piece
    for _, cell in ipairs(piece_cells(p)) do
        local row = game.pf_data[cell.y]
        if not row then
            row = {}
            game.pf_data[cell.y] = row
        end
        row[cell.x] = { color = p.color, id = p.id }
    end

    dbg("LOCK")

    if game.debug_flags and game.debug_flags.pf_data then
        local out = {}
        for y = game.pf.height, 1, -1 do
            local row = game.pf_data[y]
            local line = {}
            for x = 1, game.pf.width do
                line[x] = (row and row[x]) and tostring(row[x].id) or "."
            end
            out[#out + 1] = table.concat(line, " ")
        end
        print(table.concat(out, "\n"))
    end

    clear_lines()
    game.spawn()
end

local function refill_bag()
    local bag = { "I", "O", "T", "S", "Z", "J", "L" }
    for i = #bag, 2, -1 do
        local j = love.math.random(i)
        bag[i], bag[j] = bag[j], bag[i]
    end
    for _, s in ipairs(bag) do
        game.bag[#game.bag + 1] = s
    end
end

local function take_bag()
    if #game.bag == 0 then
        refill_bag()
    end
    return table.remove(game.bag, 1)
end

function game.ensure_next()
    while #game.next < next_count do
        game.next[#game.next + 1] = take_bag()
    end
end

local function get_id()
    game.piece_id = game.piece_id + 1
    return game.piece_id
end

local function new_piece(shape, x, y)
    return {
        id = get_id(),
        shape = shape,
        dir = "0",
        x = x,
        y = y,
        color = shape_colors[shape],
        lock_delay = 0,
        lock_resets = lock_resets,
        drop = 0,
    }
end

local function spawn_pos()
    return math.floor(game.pf.width / 2), game.pf.height - 1
end

function game.spawn()
    if #game.next == 0 then
        game.ensure_next()
    end
    local x, y = spawn_pos()
    game.piece = new_piece(table.remove(game.next, 1), x, y)
    game.can_hold = true
    game.ensure_next()
    dbg("SPAWN")
end

function game.do_hold()
    if not game.piece or not game.can_hold then return end
    local held = game.hold
    game.hold = game.piece.shape
    if held then
        local x, y = spawn_pos()
        game.piece = new_piece(held, x, y)
    else
        game.spawn()
    end
    game.can_hold = false
    dbg("HOLD")
end

function game.move_left()
    local p = game.piece
    if not p then return end
    if not collides(p, p.x - 1, p.y, p.dir) then
        p.x = p.x - 1
        if is_grounded(p) then reset_lock(p) end
        dbg("LEFT")
    end
end

function game.move_right()
    local p = game.piece
    if not p then return end
    if not collides(p, p.x + 1, p.y, p.dir) then
        p.x = p.x + 1
        if is_grounded(p) then reset_lock(p) end
        dbg("RIGHT")
    end
end

local function rotate_to(nd)
    local p = game.piece
    if not p or nd == p.dir then return end
    if not collides(p, p.x, p.y, nd) then
        p.dir = nd
        if is_grounded(p) then reset_lock(p) end
        dbg("ROT")
    end
end

function game.rotate_cw()
    if game.piece then rotate_to(cw[game.piece.dir]) end
end

function game.rotate_ccw()
    if game.piece then rotate_to(ccw[game.piece.dir]) end
end

function game.rotate_180()
    if game.piece then rotate_to(half[game.piece.dir]) end
end

function game.soft_drop()
    local p = game.piece
    if not p then return end
    if not collides(p, p.x, p.y - 1, p.dir) then
        p.y = p.y - 1
        if is_grounded(p) then reset_lock(p) end
        dbg("SOFT")
    end
end

function game.hard_drop()
    local p = game.piece
    if not p then return end
    p.y = drop_y(p)
    lock_piece()
end

function game.start(playfield)
    game.reset()
    game.pf = playfield
    game.pf_data = {}
    game.bag = {}
    game.next = {}
    game.hold = nil
    game.piece_id = 0
    game.started = true
    game.spawn()
end

function game.update(dt)
    game.time = game.time + dt
    if not game.piece then return end

    if collides(game.piece, game.piece.x, game.piece.y - 1, game.piece.dir) then
        if game.piece.lock_resets <= 0 then
            lock_piece()
            return
        end
        if game.piece.lock_delay <= 0 then
            game.piece.lock_delay = lock_delay
        end
        game.piece.lock_delay = game.piece.lock_delay - dt
        if game.piece.lock_delay <= 0 then
            lock_piece()
        end
    else
        game.piece.lock_delay = 0
    end
end

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

local function draw_matrix_borders(m, origin_px, origin_py, bs)
    local n = #m
    love.graphics.setColor(unpack(Colors.mino_border))
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
    local m = get_matrix(p.shape, p.dir)
    local dy = drop_y(p) - p.y

    -- ghost
    local ghost_ox, ghost_oy = gx + (p.x - 2) * bs, gy + ph - (p.y + dy + 1) * bs
    for _, cell in ipairs(piece_cells(p)) do
        local gy2 = cell.y + dy
        if gy2 >= 1 and gy2 <= game.pf.height then
            local ghost_color = { p.color[1], p.color[2], p.color[3], 0.25 }
            draw_block(gx + (cell.x - 1) * bs, gy + ph - gy2 * bs, bs, ghost_color)
        end
    end
    draw_matrix_borders(m, ghost_ox, ghost_oy, bs)

    local ox, oy = gx + (p.x - 2) * bs, gy + ph - (p.y + 1) * bs
    for _, cell in ipairs(piece_cells(p)) do
        if cell.y >= 1 and cell.y <= game.pf.height then
            draw_block(gx + (cell.x - 1) * bs, gy + ph - cell.y * bs, bs, p.color)
        end
    end
    draw_matrix_borders(m, ox, oy, bs)
end

local function draw_preview(shape, px, py, bs)
    local m = shapes[shape]
    local color = shape_colors[shape]
    for r = 1, #m do
        for c = 1, #m do
            if m[r][c] ~= 0 then
                draw_block(px + (c - 1) * bs, py + (r - 1) * bs, bs, color)
            end
        end
    end
    draw_matrix_borders(m, px, py, bs)
end

local function draw_next_hold(font, colors, gx, gy, pw, ph, bw, bs)
    if not game.started then return end
    local ix = gx + pw + bw + 8

    vgafont.print_outlined(font, "NEXT", ix, gy - 2, 1, colors.white, colors.out_line)
    local py = gy + 10
    for i = 1, next_count do
        if game.next[i] then
            draw_preview(game.next[i], ix + (i - 1) * (4 * bs + 4), py, bs)
        end
    end

    local hold_y = py + 4 * bs + 12
    vgafont.print_outlined(font, "HOLD", ix, hold_y, 1, colors.white, colors.out_line)
    if game.hold then
        draw_preview(game.hold, ix, hold_y + 12, bs)
    end
end

local function draw_game_info(font, colors, gx, gy, pw, ph, bw)
    local ix = gx + pw + bw + 8
    local iy = gy + ph + bw - 8

    local info = {
        scores = string.format("SCORES %d", game.scores),
        clears = string.format("CLEARS %d", game.clears),
        level  = string.format("LEVEL  %d", game.level),
        time   = string.format("TIME   %02d:%02d.%02d",
            math.floor(game.time / 60),
            math.floor(game.time % 60),
            math.floor((game.time * 100) % 100)
        ),
    }

    vgafont.print_outlined(font, info.scores, ix, iy - 8 * 3, 1, colors.white, colors.out_line)
    vgafont.print_outlined(font, info.clears, ix, iy - 8 * 2, 1, colors.white, colors.out_line)
    vgafont.print_outlined(font, info.level,  ix, iy - 8 * 1, 1, colors.white, colors.out_line)
    vgafont.print_outlined(font, info.time,   ix, iy - 8 * 0, 1, colors.white, colors.out_line)
end

function game.draw(font, colors, gx, gy, pw, ph, bw, bs)
    love.graphics.clear(unpack(colors.background))

    love.graphics.setColor(unpack(colors.playfield_bg))
    love.graphics.rectangle("fill", gx, gy, pw, ph)

    love.graphics.setColor(unpack(colors.white))
    love.graphics.rectangle("fill", gx - bw, gy - bw, pw + bw * 2, bw)
    love.graphics.rectangle("fill", gx - bw, gy + ph, pw + bw * 2, bw)
    love.graphics.rectangle("fill", gx - bw, gy, bw, ph)
    love.graphics.rectangle("fill", gx + pw, gy, bw, ph)

    draw_playfield_cells(gx, gy, ph, bs)
    draw_mino_borders(gx, gy, ph, bs)
    draw_piece(gx, gy, ph, bs)
    draw_next_hold(font, Colors, gx, gy, pw, ph, bw, bs)
    draw_game_info(font, Colors, gx, gy, pw, ph, bw)
end

return game
