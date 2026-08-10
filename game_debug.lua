-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local debug = {}

local load_code = loadstring or load

local function supports_syntax(code)
    return load_code(code) ~= nil
end

function debug.detect_features()
    return {
        goto_forward  = supports_syntax("goto a ::a::"),
        goto_backward = supports_syntax("::b:: goto b"),
        bit_shift     = supports_syntax("return 1 << 1"),
        idiv          = supports_syntax("return 5 // 2"),
    }
end

debug.flags = {
    piece = false,
    pf_data = false,
    wallkick = false,
    reset = false,
    spin = false,
    score = false,
}

function debug.piece(action, p)
    if not (debug.flags.piece and p) then return end
    print(action
        .. " id=" .. p.id
        .. " shape=" .. p.shape
        .. " dir=" .. p.dir
        .. " x=" .. p.x
        .. " y=" .. p.y
        .. " color=" .. table.concat(p.color, ",")
        .. " lock_delay=" .. p.lock_delay
        .. " lock_resets=" .. p.lock_resets
        .. " drop_sum=" .. p.drop_sum)
end

function debug.pf_data(pf, pf_data)
    if not debug.flags.pf_data then return end
    local out = {}
    for y = pf.height, 1, -1 do
        local row = pf_data[y]
        local line = {}
        for x = 1, pf.width do
            line[x] = (row and row[x]) and tostring(row[x].id) or "."
        end
        out[#out + 1] = table.concat(line, " ")
    end
    print(table.concat(out, "\n"))
end

function debug.spin_mask(shape, dir, mask)
    if not debug.flags.spin then return end
    local parts = {}
    for label, count in pairs(mask) do
        parts[#parts + 1] = label .. "=" .. count
    end
    table.sort(parts)
    print(string.format("SPIN MASK: shape=%s dir=%s {%s}", shape, dir, table.concat(parts, ",")))
end

function debug.mini_spin(p)
    if not debug.flags.spin then return end
    print(string.format("MINI SPIN: id=%d shape=%s dir=%s clears=1", p.id, p.shape, p.dir))
end

function debug.spin(p, is_mini)
    if not debug.flags.spin then return end
    print(string.format("SPIN: shape=%s dir=%s mini=%s", p.shape, p.dir, tostring(is_mini)))
end

function debug.reset(piece)
    if not debug.flags.reset then return end
    print(string.format("RESET: resets=%d delay=%.2f", piece.lock_resets, piece.lock_delay))
end

function debug.score(cleared, base, level, total, is_spin, is_mini, is_perfect, b2b_eligible)
    if not debug.flags.score then return end
    print(string.format(
        "CALC SCORE: cleared=%d base=%d level=%d gained=%d spin=%s mini=%s perfect=%s b2b_eligible=%s",
        cleared, base, level, total,
        tostring(is_spin), tostring(is_mini), tostring(is_perfect), tostring(b2b_eligible)))
end

function debug.wallkick(from, nd, i, off)
    if not debug.flags.wallkick then return end
    print(string.format("WALLKICK %s>%s: test %d (%+d,%+d)", from, nd, i, off[1], off[2]))
end

return debug
