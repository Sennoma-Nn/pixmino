-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local game        = {}

local SRS_JLSTZ   = {
    ["0>R"] = { { 0, 0 }, { -1, 0 }, { -1, 1 }, { 0, -2 }, { -1, -2 } },
    ["R>0"] = { { 0, 0 }, { 1, 0 }, { 1, -1 }, { 0, 2 }, { 1, 2 } },
    ["R>2"] = { { 0, 0 }, { 1, 0 }, { 1, -1 }, { 0, 2 }, { 1, 2 } },
    ["2>R"] = { { 0, 0 }, { -1, 0 }, { -1, 1 }, { 0, -2 }, { -1, -2 } },
    ["2>L"] = { { 0, 0 }, { 1, 0 }, { 1, 1 }, { 0, -2 }, { 1, -2 } },
    ["L>2"] = { { 0, 0 }, { -1, 0 }, { -1, -1 }, { 0, 2 }, { -1, 2 } },
    ["L>0"] = { { 0, 0 }, { -1, 0 }, { -1, -1 }, { 0, 2 }, { -1, 2 } },
    ["0>L"] = { { 0, 0 }, { 1, 0 }, { 1, 1 }, { 0, -2 }, { 1, -2 } },

    ["0>2"] = { { 0, 0 }, { 0, 1 }, { 1, 1 }, { -1, 1 }, { 1, 0 }, { -1, 0 } },
    ["2>0"] = { { 0, 0 }, { 0, -1 }, { -1, -1 }, { 1, -1 }, { -1, 0 }, { 1, 0 } },
    ["R>L"] = { { 0, 0 }, { 1, 0 }, { 1, 2 }, { 1, 1 }, { 0, 2 }, { 0, 1 } },
    ["L>R"] = { { 0, 0 }, { -1, 0 }, { -1, 2 }, { -1, 1 }, { 0, 2 }, { 0, 1 } },
}

local SRS_I       = {
    ["0>R"] = { { 0, 0 }, { -2, 0 }, { 1, 0 }, { -2, -1 }, { 1, 2 } },
    ["R>0"] = { { 0, 0 }, { 2, 0 }, { -1, 0 }, { 2, 1 }, { -1, -2 } },
    ["R>2"] = { { 0, 0 }, { -1, 0 }, { 2, 0 }, { -1, 2 }, { 2, -1 } },
    ["2>R"] = { { 0, 0 }, { 1, 0 }, { -2, 0 }, { 1, -2 }, { -2, 1 } },
    ["2>L"] = { { 0, 0 }, { 2, 0 }, { -1, 0 }, { 2, 1 }, { -1, -2 } },
    ["L>2"] = { { 0, 0 }, { -2, 0 }, { 1, 0 }, { -2, -1 }, { 1, 2 } },
    ["L>0"] = { { 0, 0 }, { 1, 0 }, { -2, 0 }, { 1, -2 }, { -2, 1 } },
    ["0>L"] = { { 0, 0 }, { -1, 0 }, { 2, 0 }, { -1, 2 }, { 2, -1 } },
}

local minos       = {
    I = {
        shapes = {
            { 0, 0, 0, 0 },
            { 1, 1, 1, 1 },
            { 0, 0, 0, 0 },
            { 0, 0, 0, 0 }
        },
        color = { 0.2, 0.8, 1.0, 1 },
        preview = {
            width = 4,
            offset = { 0, 0 }
        },
        spawn = { 0, 1 },
        wallkick = { srs = SRS_I },
    },
    O = {
        shapes = {
            { 0, 0, 0, 0 },
            { 0, 1, 1, 0 },
            { 0, 1, 1, 0 },
            { 0, 0, 0, 0 }
        },
        color = { 1.0, 0.9, 0.4, 1 },
        preview = {
            width = 2,
            offset = { -1, 1 }
        },
        spawn = { 0, 1 },
    },
    T = {
        shapes = {
            { 0, 1, 0 },
            { 1, 1, 1 },
            { 0, 0, 0 }
        },
        color = { 0.7, 0.4, 1.0, 1 },
        preview = {
            width = 3,
            offset = { 0, 0 }
        },
        wallkick = { srs = SRS_JLSTZ },
    },
    S = {
        shapes = {
            { 0, 1, 1 },
            { 1, 1, 0 },
            { 0, 0, 0 }
        },
        color = { 0.2, 0.9, 0.5, 1 },
        preview = {
            width = 3,
            offset = { 0, 0 }
        },
        wallkick = { srs = SRS_JLSTZ },
    },
    Z = {
        shapes = {
            { 1, 1, 0 },
            { 0, 1, 1 },
            { 0, 0, 0 }
        },
        color = { 1.0, 0.4, 0.4, 1 },
        preview = {
            width = 3,
            offset = { 0, 0 }
        },
        wallkick = { srs = SRS_JLSTZ },
    },
    J = {
        shapes = {
            { 1, 0, 0 },
            { 1, 1, 1 },
            { 0, 0, 0 }
        },
        color = { 0.3, 0.5, 1.0, 1 },
        preview = {
            width = 3,
            offset = { 0, 0 }
        },
        wallkick = { srs = SRS_JLSTZ },
    },
    L = {
        shapes = {
            { 0, 0, 1 },
            { 1, 1, 1 },
            { 0, 0, 0 }
        },
        color = { 1.0, 0.6, 0.3, 1 },
        preview = {
            width = 3,
            offset = { 0, 0 }
        },
        wallkick = { srs = SRS_JLSTZ },
    },
}

local lock_delay  = 0.5
local lock_resets = 15
local next_count  = 3

game.pf_data      = {}
game.bag          = {}
game.next         = {}
game.hold         = nil
game.can_hold     = true
game.piece        = nil
game.piece_id     = 0
game.started      = false
game.pf           = nil
game.debug_flags  = {}

game.time         = 0
game.clears       = 0
game.scores       = 0
game.level        = 0
game.ren          = -1
game.b2b          = -1

local cw          = { ["0"] = "R", ["R"] = "2", ["2"] = "L", ["L"] = "0" }
local ccw         = { ["0"] = "L", ["L"] = "2", ["2"] = "R", ["R"] = "0" }
local half        = { ["0"] = "2", ["2"] = "0", ["R"] = "L", ["L"] = "R" }

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
    game.time   = 0
    game.clears = 0
    game.scores = 0
    game.level  = 0
    game.ren    = -1
    game.b2b    = -1
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
    local m = minos[shape].shapes
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

    return cleared
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

    local cleared = clear_lines()
    if cleared > 0 then
        game.ren = game.ren + 1
    else
        game.ren = -1
    end
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
        color = minos[shape].color,
        lock_delay = 0,
        lock_resets = lock_resets,
        drop = 0,
    }
end

local function spawn_pos(shape)
    local s = minos[shape].spawn or { 0, 0 }
    return math.floor(game.pf.width / 2) + s[1], game.pf.height - 1 + s[2]
end

function game.spawn()
    if #game.next == 0 then
        game.ensure_next()
    end
    local shape = table.remove(game.next, 1)
    local x, y = spawn_pos(shape)
    game.piece = new_piece(shape, x, y)
    game.can_hold = true
    game.ensure_next()
    dbg("SPAWN")
end

function game.do_hold()
    if not game.piece or not game.can_hold then return end
    local held = game.hold
    game.hold = game.piece.shape
    if held then
        local x, y = spawn_pos(held)
        game.piece = new_piece(held, x, y)
    else
        game.spawn()
    end
    game.can_hold = false
    dbg("HOLD")
end

function game.move_left()
    local p = game.piece
    if not p then return false end
    if not collides(p, p.x - 1, p.y, p.dir) then
        p.x = p.x - 1
        if is_grounded(p) then reset_lock(p) end
        dbg("LEFT")
        return true
    end
    return false
end

function game.move_right()
    local p = game.piece
    if not p then return false end
    if not collides(p, p.x + 1, p.y, p.dir) then
        p.x = p.x + 1
        if is_grounded(p) then reset_lock(p) end
        dbg("RIGHT")
        return true
    end
    return false
end

local function try_wallkick(piece, nd)
    local from = piece.dir
    local srs = minos[piece.shape].wallkick and minos[piece.shape].wallkick.srs
    local moves = srs and srs[from .. ">" .. nd]
    if not moves then return false end

    for i, off in ipairs(moves) do
        local nx = piece.x + off[1]
        local ny = piece.y + off[2]
        if not collides(piece, nx, ny, nd) then
            piece.x, piece.y = nx, ny
            piece.dir = nd
            if game.debug_flags and game.debug_flags.wallkick then
                print(string.format("WALLKICK %s>%s: test %d (%+d,%+d)", from, nd, i, off[1], off[2]))
            end
            return true
        end
    end
    return false
end

local function rotate_to(nd)
    local p = game.piece
    if not p or nd == p.dir then return end

    if try_wallkick(p, nd) then
        if is_grounded(p) then reset_lock(p) end
        dbg("ROT")
        return
    end

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
    if not p then return false end
    if not collides(p, p.x, p.y - 1, p.dir) then
        p.y = p.y - 1
        dbg("SOFT")
        return true
    end
    return false
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

game.shapes = minos
game.lock_resets_total = lock_resets
game.get_matrix = get_matrix
game.drop_y = drop_y
game.piece_cells = piece_cells

return game
