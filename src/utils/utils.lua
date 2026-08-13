-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local utils = {}

function utils.frame_ms(frames)
    return frames * (1000 / 60)
end

function utils.clamp(v, lo, hi)
    if v < lo then return lo end
    if v > hi then return hi end
    return v
end

function utils.color_blend(c1, c2, ratio)
    ratio = math.max(0, math.min(ratio or 0, 1))
    return {
        c1[1] * (1 - ratio) + c2[1] * ratio,
        c1[2] * (1 - ratio) + c2[2] * ratio,
        c1[3] * (1 - ratio) + c2[3] * ratio,
        c1[4] or 1,
    }
end

function utils.strip_a(color)
    return { color[1], color[2], color[3] }
end

function utils.utf8_len(text)
    local count = 0
    local i = 1
    while i <= #text do
        local byte = string.byte(text, i)
        local len
        if byte < 128 then
            len = 1
        elseif byte < 192 then
            len = 1
        elseif byte < 224 then
            len = 2
        elseif byte < 240 then
            len = 3
        else
            len = 4
        end
        count = count + 1
        i = i + len
    end
    return count
end

function utils.format_time(seconds)
    local s = math.abs(seconds)
    return string.format("%02d:%02d.%02d",
        math.floor(s / 60),
        math.floor(s % 60),
        math.floor((s * 100) % 100))
end

function utils.rot90(m)
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

function utils.rotate_matrix(m, dir)
    local rotations = { ["0"] = 0, ["R"] = 1, ["2"] = 2, ["L"] = 3 }
    local out = m
    for _ = 1, rotations[dir] or 0 do
        out = utils.rot90(out)
    end
    return out
end

function utils.shuffle(t)
    for i = #t, 2, -1 do
        local j = love.math.random(i)
        t[i], t[j] = t[j], t[i]
    end
    return t
end

function utils.is_empty(t)
    return next(t) == nil
end

function utils.wrap_index(i, n)
    return ((i - 1) % n) + 1
end

return utils
