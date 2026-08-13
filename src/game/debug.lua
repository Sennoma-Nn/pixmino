-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local game_debug = {}

local load_code = loadstring or load

local function supports_syntax(code)
    return load_code(code) ~= nil
end

function game_debug.detect_features()
    return {
        goto_forward  = supports_syntax("goto a ::a::"),
        goto_backward = supports_syntax("::b:: goto b"),
        bit_operator  = supports_syntax("return 1 << 1"),
        idiv_operator = supports_syntax("return 5 // 2"),
    }
end

game_debug.flags = {
    piece = true,
    pf_data = false,
    wallkick = false,
    reset = false,
    spin = false,
    score = false,
}

function game_debug.piece(action, p)
    if not (game_debug.flags.piece and p) then return end
    print("\027[33;1m" .. "PIECE" .. "\027[0m" ..
        "\n\027[32maction:      \027[0m" .. action ..
        "\n\027[32mid:          \027[0m" .. p.id ..
        "\n\027[32mshape:       \027[0m" .. p.shape ..
        "\n\027[32mdir:         \027[0m" .. p.dir ..
        "\n\027[32mx:           \027[0m" .. p.x ..
        "\n\027[32my:           \027[0m" .. p.y ..
        "\n\027[32mcolor:       \027[0m" .. table.concat(p.color, ", ") ..
        "\n\027[32mlock_delay:  \027[0m" .. p.lock_delay ..
        "\n\027[32mlock_resets: \027[0m" .. p.lock_resets ..
        "\n\027[32mdrop_sum:    \027[0m" .. p.drop_sum .. "\n"
    )
end

function game_debug.pf_data(pf, pf_data)
    if not game_debug.flags.pf_data then return end
    local out = {}
    for y = pf.height, 1, -1 do
        local row = pf_data[y]
        local line = {}
        for x = 1, pf.width do
            line[x] = (row and row[x]) and tostring(row[x].id) or "."
        end
        out[#out + 1] = table.concat(line, " ")
    end
    print("\027[33;1mPF_DATA\027[0m\n" .. table.concat(out, "\n") .. "\n")
end

function game_debug.spin_mask(shape, dir, mask)
    if not game_debug.flags.spin then return end
    local parts = {}
    for label, count in pairs(mask) do
        parts[#parts + 1] = label .. "=" .. count
    end
    table.sort(parts)
    print("\027[33;1mSPIN MASK\027[0m" ..
        "\n\027[32mshape: \027[0m" .. shape ..
        "\n\027[32mdir:   \027[0m" .. dir ..
        "\n\027[32mmask:  \027[0m" .. table.concat(parts, ", ") .. "\n"
    )
end

function game_debug.mini_spin(p)
    if not game_debug.flags.spin then return end
    print("\027[33;1mMINI SPIN\027[0m" ..
        "\n\027[32mid:     \027[0m" .. p.id ..
        "\n\027[32mshape:  \027[0m" .. p.shape ..
        "\n\027[32mdir:    \027[0m" .. p.dir ..
        "\n\027[32mclears: \027[0m" .. 1 .. "\n"
    )
end

function game_debug.spin(p, is_mini)
    if not game_debug.flags.spin then return end
    print("\027[33;1mSPIN\027[0m" ..
        "\n\027[32mshape: \027[0m" .. p.shape ..
        "\n\027[32mdir:   \027[0m" .. p.dir ..
        "\n\027[32mmini:  \027[0m" .. tostring(is_mini) .. "\n"
    )
end

function game_debug.reset(action, piece)
    if not game_debug.flags.reset then return end
    print("\027[33;1mRESET\027[0m" ..
        "\n\027[32maction:      \027[0m" .. action ..
        "\n\027[32mlock_resets: \027[0m" .. piece.lock_resets ..
        "\n\027[32mlock_delay:  \027[0m" .. piece.lock_delay .. "\n"
    )
end

function game_debug.score(cleared, base, level, total, is_spin, is_mini, is_perfect, b2b_eligible)
    if not game_debug.flags.score then return end
    print("\027[33;1mCALC SCORE\027[0m" ..
        "\n\027[32mcleared:      \027[0m" .. cleared ..
        "\n\027[32mbase:         \027[0m" .. base ..
        "\n\027[32mlevel:        \027[0m" .. level ..
        "\n\027[32mgained:       \027[0m" .. total ..
        "\n\027[32mspin:         \027[0m" .. tostring(is_spin) ..
        "\n\027[32mmini:         \027[0m" .. tostring(is_mini) ..
        "\n\027[32mperfect:      \027[0m" .. tostring(is_perfect) ..
        "\n\027[32mb2b_eligible: \027[0m" .. tostring(b2b_eligible) .. "\n"
    )
end

function game_debug.wallkick(from, nd, i, off)
    if not game_debug.flags.wallkick then return end
    print("\027[33;1mWALLKICK\027[0m" ..
        "\n\027[32mfrom: \027[0m" .. from ..
        "\n\027[32mto:   \027[0m" .. nd ..
        "\n\027[32mtest: \027[0m" .. i ..
        "\n\027[32moff:  \027[0m" .. string.format("(%+d,%+d)", off[1], off[2]) .. "\n"
    )
end

return game_debug
