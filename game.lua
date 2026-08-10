-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local utils          = require("utils")
local save           = require("save")
local game_debug     = require("game_debug")

local game           = {}

local PRS_JLSTZ      = {
    ["0>R"] = { { 0, 0 }, { -1, 0 }, { -1, 1 }, { 0, -2 }, { -1, -2 }, { 0, 1 } },
    ["R>0"] = { { 0, 0 }, { 0, -1 }, { 1, 0 }, { 1, -1 }, { 0, 2 }, { 1, 2 } },
    ["R>2"] = { { 0, 0 }, { 1, 0 }, { 1, -1 }, { 0, -1 }, { 0, 2 }, { 1, 2 } },
    ["2>R"] = { { 0, 0 }, { -1, 0 }, { -1, -1 }, { -1, 1 }, { 0, -2 }, { -1, -2 } },
    ["2>L"] = { { 0, 0 }, { 1, 0 }, { 1, -1 }, { 1, 1 }, { 0, -2 }, { 1, -2 } },
    ["L>2"] = { { 0, 0 }, { -1, 0 }, { -1, -1 }, { 0, -1 }, { 0, 2 }, { -1, 2 } },
    ["L>0"] = { { 0, 0 }, { 0, -1 }, { -1, 0 }, { -1, -1 }, { 0, 2 }, { -1, 2 } },
    ["0>L"] = { { 0, 0 }, { 1, 0 }, { 1, 1 }, { 0, -2 }, { 1, -2 }, { 0, 1 } },

    ["0>2"] = { { 0, 0 }, { 1, 0 }, { -1, 0 }, { 2, 0 }, { -2, 0 }, { 0, 1 }, { 1, 1 }, { -1, 1 } },
    ["2>0"] = { { 0, 0 }, { -1, 0 }, { 1, 0 }, { -2, 0 }, { 2, 0 }, { 0, -1 }, { -1, -1 }, { 1, -1 } },
    ["R>L"] = { { 0, 0 }, { 0, -1 }, { 0, -2 }, { 1, 0 }, { 1, 2 }, { 1, 1 }, { 0, 2 }, { 0, 1 } },
    ["L>R"] = { { 0, 0 }, { 0, -1 }, { 0, -2 }, { -1, 0 }, { -1, 2 }, { -1, 1 }, { 0, 2 }, { 0, 1 } },
}

local PRS_I          = {
    ["0>R"] = { { 0, 0 }, { -2, 0 }, { 1, 0 }, { -2, -1 }, { 1, 2 } },
    ["R>0"] = { { 0, 0 }, { 2, 0 }, { -1, 0 }, { 2, 1 }, { -1, -2 } },
    ["R>2"] = { { 0, 0 }, { -1, 0 }, { 2, 0 }, { -1, 2 }, { 2, -1 } },
    ["2>R"] = { { 0, 0 }, { 1, 0 }, { -2, 0 }, { 1, -2 }, { -2, 1 } },
    ["2>L"] = { { 0, 0 }, { 2, 0 }, { -1, 0 }, { 2, 1 }, { -1, -2 } },
    ["L>2"] = { { 0, 0 }, { -2, 0 }, { 1, 0 }, { -2, -1 }, { 1, 2 } },
    ["L>0"] = { { 0, 0 }, { 1, 0 }, { -2, 0 }, { 1, -2 }, { -2, 1 } },
    ["0>L"] = { { 0, 0 }, { -1, 0 }, { 2, 0 }, { -1, 2 }, { 2, -1 } },

    ["0>2"] = { { 0, 0 }, { 1, 0 }, { -1, 0 }, { 0, -1 }, { 0, 1 } },
    ["2>0"] = { { 0, 0 }, { -1, 0 }, { 1, 0 }, { 0, 1 }, { 0, -1 } },
    ["R>L"] = { { 0, 0 }, { 0, -1 }, { 0, 1 }, { 0, -2 }, { 1, 0 } },
    ["L>R"] = { { 0, 0 }, { 0, -1 }, { 0, 1 }, { 0, -2 }, { -1, 0 } },
}

local PRS_O          = {
    ["0>R"] = { { 1, 0 }, { 1, -1 }, { 1, 1 } },
    ["R>2"] = { { 1, 0 }, { 1, -1 }, { 1, 1 } },
    ["2>L"] = { { 1, 0 }, { 1, -1 }, { 1, 1 } },
    ["L>0"] = { { 1, 0 }, { 1, -1 }, { 1, 1 } },

    ["R>0"] = { { -1, 0 }, { -1, -1 }, { -1, 1 } },
    ["2>R"] = { { -1, 0 }, { -1, -1 }, { -1, 1 } },
    ["L>2"] = { { -1, 0 }, { -1, -1 }, { -1, 1 } },
    ["0>L"] = { { -1, 0 }, { -1, -1 }, { -1, 1 } },
}

local minos          = {
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
        wallkick = { prs = PRS_I },
        spin = {
            mask = {
                { 0, 0, 0, 0, 0, 0 },
                { 0, 1, 3, 3, 1, 0 },
                { 2, 0, 0, 0, 0, 2 },
                { 0, 1, 4, 4, 1, 0 },
                { 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0 }
            },
            result = function(mask)
                local is_spin = mask[1] >= 3 and mask[2] == 2
                local is_mini = mask[3] == 0 or mask[4] == 0

                return { spin = is_spin, mini = is_mini }
            end,
        },
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
        wallkick = { prs = PRS_O },
        spin = {
            mask = {
                { 0, 1, 1, 0 },
                { 2, 0, 0, 4 },
                { 2, 0, 0, 4 },
                { 0, 3, 3, 0 }
            },
            result = function(mask)
                local is_spin = true
                is_spin = is_spin and mask[1] > 0
                is_spin = is_spin and mask[2] > 0
                is_spin = is_spin and mask[3] > 0
                is_spin = is_spin and mask[4] > 0

                local is_mini = false
                is_mini = is_mini or mask[1] < 2
                is_mini = is_mini or mask[2] < 2
                is_mini = is_mini or mask[3] < 2
                is_mini = is_mini or mask[4] < 2

                return { spin = is_spin, mini = is_mini }
            end,
        },
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
        wallkick = { prs = PRS_JLSTZ },
        spin = {
            mask = {
                { 2, 0, 2 },
                { 0, 0, 0 },
                { 1, 0, 1 }
            },
            result = function(mask)
                local sum = mask[1] + mask[2]
                local is_spin = sum >= 3
                local is_mini = mask[2] ~= 2

                return { spin = is_spin, mini = is_mini }
            end,
        },
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
        wallkick = { prs = PRS_JLSTZ },
        spin = {
            mask = {
                { 0, 0, 0, 0, 0 },
                { 0, 1, 0, 0, 0 },
                { 2, 0, 0, 1, 0 },
                { 0, 2, 0, 0, 0 },
                { 0, 0, 0, 0, 0 }
            },
            result = function(mask)
                local is_spin = mask[1] == 2 or mask[2] == 2
                local is_mini = mask[2] == 2 and mask[1] ~= 2

                return { spin = is_spin, mini = is_mini }
            end,
        },
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
        wallkick = { prs = PRS_JLSTZ },
        spin = {
            mask = {
                { 0, 0, 0, 0, 0 },
                { 0, 0, 0, 1, 0 },
                { 0, 1, 0, 0, 2 },
                { 0, 0, 0, 2, 0 },
                { 0, 0, 0, 0, 0 }
            },
            result = function(mask)
                local is_spin = mask[1] == 2 or mask[2] == 2
                local is_mini = mask[2] == 2 and mask[1] ~= 2

                return { spin = is_spin, mini = is_mini }
            end,
        },
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
        wallkick = { prs = PRS_JLSTZ },
        spin = {
            mask = {
                { 0, 0, 0, 0, 0 },
                { 3, 0, 2, 1, 0 },
                { 3, 0, 0, 0, 0 },
                { 0, 2, 2, 1, 0 },
                { 0, 0, 0, 0, 0 }
            },
            result = function(mask)
                local is_spin = mask[1] >= 1 and mask[2] >= 2
                local is_mini = mask[3] < 1

                return { spin = is_spin, mini = is_mini }
            end,
        },
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
        wallkick = { prs = PRS_JLSTZ },
        spin = {
            mask = {
                { 0, 0, 0, 0, 0 },
                { 0, 1, 2, 0, 3 },
                { 0, 0, 0, 0, 3 },
                { 0, 1, 2, 2, 0 },
                { 0, 0, 0, 0, 0 }
            },
            result = function(mask)
                local is_spin = mask[1] >= 1 and mask[2] >= 2
                local is_mini = mask[3] < 1

                return { spin = is_spin, mini = is_mini }
            end,
        },
    },
}

local lock_delay     = 0.5
local lock_resets    = 15
local next_count     = 3

game.pf_data         = {}
game.bag             = {}
game.next            = {}
game.hold            = nil
game.can_hold        = true
game.piece           = nil
game.piece_id        = 0
game.started         = false
game.pf              = nil
game.mode            = nil
game.mode_state      = nil
game.cleared         = false
game.result          = nil
game.modal_active    = false
game.modal_selection = 1
game.mode_key        = nil
game.over            = false

game.time            = 0
game.clears          = 0
game.scores          = 0
game.level           = 1
game.ren             = -1
game.b2b             = 0
game.gravity         = 0

game.notify          = { text = nil, color = nil, time = 0 }

local cw             = { ["0"] = "R", ["R"] = "2", ["2"] = "L", ["L"] = "0" }
local ccw            = { ["0"] = "L", ["L"] = "2", ["2"] = "R", ["R"] = "0" }
local half           = { ["0"] = "2", ["2"] = "0", ["R"] = "L", ["L"] = "R" }

function game.reset()
    game.time   = -1.5
    game.clears = 0
    game.scores = 0
    game.level  = 1
    game.ren    = -1
    game.b2b    = 0
end

function game.stop()
    game.reset()
    game.cleared = false
    game.result = nil
    game.started = false
    game.pf = nil
    game.piece = nil
    game.modal_active = false
    game.modal_selection = 1
    game.mode_key = nil
    game.over = false
end

function game.open_modal()
    if game.cleared then return end
    game.modal_active = true
    game.modal_selection = 1
end

function game.close_modal()
    game.modal_active = false
end

local function modal_items()
    if game.over then
        return { "RESTART", "QUIT" }
    end
    return { "CONTINUE", "RESTART", "QUIT" }
end

function game.get_modal_items()
    return modal_items()
end

function game.modal_move(delta)
    local items = modal_items()
    local n = #items
    game.modal_selection = utils.wrap_index(game.modal_selection + delta, n)
end

function game.modal_choose()
    local items = modal_items()
    local choice = items[game.modal_selection]
    if choice == "RESTART" then
        return "restart"
    elseif choice == "QUIT" then
        return "quit"
    end
    return "continue"
end

function game.set_notify(text, color)
    game.notify.text = text
    game.notify.color = color
    game.notify.time = 2
end

local function get_matrix(shape, dir)
    local m = utils.rotate_matrix(minos[shape].shapes, dir)
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

local function spin_matrix(shape, dir)
    local s = minos[shape].spin
    local m = utils.rotate_matrix(s.mask, dir)
    return m, #m
end

local function check_spin(piece)
    local spin_def = minos[piece.shape].spin
    local m, n = spin_matrix(piece.shape, piece.dir)
    local _, ns = get_matrix(piece.shape, piece.dir)
    local cr = (n - ns) / 2 + 2

    local mask = {}
    for r = 1, n do
        for c = 1, n do
            local label = m[r][c]
            if label ~= 0 then
                local cx = piece.x + (c - cr)
                local cy = piece.y + (cr - r)
                local blocked = (cx < 1 or cx > game.pf.width or cy < 1)
                    or (game.pf_data[cy] and game.pf_data[cy][cx])
                mask[label] = (mask[label] or 0) + (blocked and 1 or 0)
            end
        end
    end

    game_debug.spin_mask(piece.shape, piece.dir, mask)

    local res = spin_def.result(mask)
    return res.spin, res.mini
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
    game_debug.reset("old", piece)

    if piece.lock_resets > 0 then
        piece.lock_resets = piece.lock_resets - 1
        piece.lock_delay = lock_delay
    end

    game_debug.reset("new", piece)
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

local function calc_score(cleared, is_spin, is_mini, is_perfect, b2b_eligible)
    local base
    if is_perfect then
        local pc = { [1] = 800, [2] = 1200, [3] = 1800, [4] = 2000 }
        base = pc[cleared] or 0
        if cleared == 4 and b2b_eligible then
            base = 3200
        end
    elseif is_spin then
        if cleared == 0 then
            base = is_mini and 100 or 400
        else
            local sp = { [1] = 800, [2] = 1200, [3] = 1600, [4] = 2000 }
            base = sp[cleared] or 0
        end
    else
        local ns = { [1] = 100, [2] = 300, [3] = 500, [4] = 800 }
        base = ns[cleared] or 0
    end

    local total = base * game.level
    if not is_perfect and b2b_eligible then
        total = total * 1.5
    end

    game_debug.score(cleared, base, game.level, total, is_spin, is_mini, is_perfect, b2b_eligible)

    return total
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

    game_debug.piece("LOCK", p)
    game_debug.pf_data(game.pf, game.pf_data)

    local cleared = clear_lines()
    if cleared > 0 then
        game.ren = game.ren + 1
    else
        game.ren = -1
    end

    local is_spin = p.spin.activation
    local is_mini = is_spin and p.spin.mini

    local b2b_eligible = game.b2b > 0

    if cleared > 0 then
        if cleared >= 4 or is_spin then
            game.b2b = game.b2b + 1
        else
            game.b2b = 0
        end
    end

    local is_perfect = cleared > 0 and utils.is_empty(game.pf_data)

    game.scores = game.scores + calc_score(cleared, is_spin, is_mini, is_perfect, b2b_eligible)

    local clear_names = { "SINGLE", "DOUBLE", "TRIPLE", "QUAD" }
    if is_perfect then
        local prefix = is_spin and ("%s SPIN "):format(p.shape) or ""
        game.set_notify(prefix .. "PERFECT CLEAR", p.color)
    elseif is_spin then
        local mini = is_mini and "MINI " or ""
        local clear_name = (cleared > 0 and clear_names[cleared]) or "NONE"
        game.set_notify(string.format("%s%s SPIN %s", mini, p.shape, clear_name), p.color)
    elseif cleared > 0 then
        game.set_notify(clear_names[cleared], p.color)
    end

    if is_mini then
        game_debug.mini_spin(p)
    end

    game.piece = nil
end

local function refill_bag()
    local bag = utils.shuffle({ "I", "O", "T", "S", "Z", "J", "L" })
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

local function reset_piece_spin(piece)
    piece.spin.activation = false
    piece.spin.mini = false
end

local function new_piece(shape, x, y)
    return {
        id = get_id(),
        shape = shape,
        dir = "0",
        x = x,
        y = y,
        color = minos[shape].color,
        lock_delay = lock_delay,
        lock_resets = lock_resets,
        drop_sum = 0,
        spin = { activation = false, mini = false },
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
    game_debug.piece("SPAWN", game.piece)

    if collides(game.piece, game.piece.x, game.piece.y, game.piece.dir) then
        return false
    end
    return true
end

function game.do_hold()
    if not game.piece or not game.can_hold then return end
    local old_rst = game.piece.lock_resets
    local prev_shape = game.piece.shape
    local held = game.hold
    game.hold = prev_shape

    local new_shape = held or table.remove(game.next, 1)
    local x, y = spawn_pos(new_shape)
    game.piece = new_piece(new_shape, x, y)
    game.piece.lock_resets = math.min(old_rst + 2, lock_resets)
    game.ensure_next()
    game.can_hold = false
    game_debug.piece("HOLD", game.piece)
end

function game.move_left()
    local p = game.piece
    if not p then return false end
    if not collides(p, p.x - 1, p.y, p.dir) then
        if is_grounded(p) then reset_lock(p) end
        p.x = p.x - 1
        reset_piece_spin(p)
        game_debug.piece("LEFT", p)
        return true
    end
    return false
end

function game.move_right()
    local p = game.piece
    if not p then return false end
    if not collides(p, p.x + 1, p.y, p.dir) then
        if is_grounded(p) then reset_lock(p) end
        p.x = p.x + 1
        reset_piece_spin(p)
        game_debug.piece("RIGHT", p)
        return true
    end
    return false
end

local function try_wallkick(piece, nd)
    local from = piece.dir
    local prs = minos[piece.shape].wallkick and minos[piece.shape].wallkick.prs
    local moves = prs and prs[from .. ">" .. nd]
    if not moves then return false, false end

    for i, off in ipairs(moves) do
        local nx = piece.x + off[1]
        local ny = piece.y + off[2]
        if not collides(piece, nx, ny, nd) then
            piece.x, piece.y = nx, ny
            piece.dir = nd
            game_debug.wallkick(from, nd, i, off)
            local wallkicked = (off[1] ~= 0 or off[2] ~= 0)
            return true, wallkicked
        end
    end
    return false, false
end

local function rotate_to(nd)
    local p = game.piece
    if not p or nd == p.dir then return end
    local is_grounded = is_grounded(p)
    local rotated = false
    local wallkicked = false

    reset_piece_spin(p)

    local kicked, wk = try_wallkick(p, nd)
    if kicked then
        rotated = true
        wallkicked = wk
        if is_grounded then reset_lock(p) end
    elseif not collides(p, p.x, p.y, nd) then
        p.dir = nd
        rotated = true
        if is_grounded then reset_lock(p) end
    end

    if rotated then
        game_debug.piece("ROT", p)
        local is_spin, is_mini = check_spin(p)
        p.spin.activation = is_spin
        p.spin.mini = is_mini
        if is_spin then
            game_debug.spin(p, is_mini)
        end
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
        reset_piece_spin(p)
        game_debug.piece("SOFT", p)
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

local function apply_gravity(dt)
    local p = game.piece
    if not p then return end

    if collides(p, p.x, p.y - 1, p.dir) then
        p.drop_sum = 0
        return
    end

    p.drop_sum = p.drop_sum + game.gravity * 60 * dt
    while p.drop_sum >= 1 do
        if collides(p, p.x, p.y - 1, p.dir) then
            p.drop_sum = 0
            break
        end
        p.y = p.y - 1
        reset_piece_spin(p)
        p.drop_sum = p.drop_sum - 1
        game_debug.piece("GRAV", p)
    end
end

function game.start(playfield, mode, mode_key)
    game.reset()
    game.cleared = false
    game.result = nil
    game.mode = mode
    game.mode_key = mode_key
    game.pf = playfield
    game.pf_data = {}
    game.bag = {}
    game.next = {}
    game.hold = nil
    game.piece_id = 0
    game.started = true
    game.piece = nil
    game.over = false
end

function game.update(dt)
    if game.cleared then return end
    if game.modal_active then return end
    if game.over then return end

    game.time = game.time + dt

    if type(game.mode) == "function" then
        local old_record = save.get_record(game.mode_key)
        game.mode_state = game.mode(game.time, game.clears, game.scores, game.level, game.ren, game.b2b, game.gravity,
            old_record)
        if game.mode_state then
            game.level = game.mode_state.level or game.level
            game.gravity = game.mode_state.gravity or game.gravity
            if game.mode_state.target and not game.cleared then
                game.cleared = true
                game.result = game.mode_state.result
                if game.mode_key and game.mode_state.record_update and game.mode_state.record ~= nil then
                    save.update_record(game.mode_key, game.mode_state.record)
                end
                return
            end
        end
    end

    if game.notify.time > 0 then
        game.notify.time = game.notify.time - dt
        if game.notify.time < 0 then
            game.notify.time = 0
        end
    end

    game.ensure_next()

    if game.time >= 0 then
        if not game.piece then
            local is_spawn = game.spawn()
            if not is_spawn then
                game.over = true
                return
            end
        end

        game.input_mod.update(dt)

        apply_gravity(dt)

        if game.piece then
            if collides(game.piece, game.piece.x, game.piece.y - 1, game.piece.dir) then
                game.piece.lock_delay = game.piece.lock_delay - dt
                if game.piece.lock_delay <= 0 then
                    lock_piece()
                end
            else
                if game.piece.lock_resets > 0 then
                    game.piece.lock_delay = lock_delay
                end
            end
        end
    end
end

game.shapes = minos
game.lock_resets_total = lock_resets
game.get_matrix = get_matrix
game.drop_y = drop_y
game.piece_cells = piece_cells

return game
