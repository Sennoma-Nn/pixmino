-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local console   = require("src.debug.console")

local biom      = {}

biom._key_queue = {}

local function v(c)
    return c / 255
end

biom.palette = {
    [0] = { v(0), v(0), v(0) },
    [1] = { v(0), v(0), v(170) },
    [2] = { v(0), v(170), v(0) },
    [3] = { v(0), v(170), v(170) },
    [4] = { v(170), v(0), v(0) },
    [5] = { v(170), v(0), v(170) },
    [6] = { v(170), v(85), v(0) },
    [7] = { v(170), v(170), v(170) },
    [8] = { v(85), v(85), v(85) },
    [9] = { v(85), v(85), v(255) },
    [10] = { v(85), v(255), v(85) },
    [11] = { v(85), v(255), v(255) },
    [12] = { v(255), v(85), v(85) },
    [13] = { v(255), v(85), v(255) },
    [14] = { v(255), v(255), v(85) },
    [15] = { v(255), v(255), v(255) },
}

function biom.fg(index)
    local p = biom.palette[index]
    return { p[1], p[2], p[3], 1 }
end

function biom.bg(index)
    local p = biom.palette[index]
    return { p[1], p[2], p[3], 1 }
end

function biom.push_key(key, char)
    biom._key_queue[#biom._key_queue + 1] = { key = key, char = char }
end

function biom.read_key()
    local entry = table.remove(biom._key_queue, 1)
    if not entry then return nil end
    return entry.key, entry.char
end

function biom.flush_keys()
    biom._key_queue = {}
end

function biom.put(x, y, char, fg, bg, blink)
    x = x + 1
    y = y + 1
    if y < 1 or y > console.H then return end
    if x < 1 or x > console.W then return end

    local cell = console.grid[y][x]
    cell.char = char
    if fg then cell.fg = fg end
    if bg then cell.bg = bg end
    if blink ~= nil then cell.blink = blink end
end

function biom.write(x, y, str, fg, bg, blink)
    x = x + 1
    y = y + 1
    if y < 1 or y > console.H then return end

    local i = 1
    local n = #str
    while i <= n do
        local byte = string.byte(str, i)
        local len = 1
        if byte >= 128 then
            if byte < 224 then
                len = 2
            elseif byte < 240 then
                len = 3
            else
                len = 4
            end
        end
        local ch = str:sub(i, i + len - 1)

        biom.put(x - 1, y - 1, ch, fg, bg, blink)

        x = x + 1
        i = i + len
    end
end

local function blank_cell()
    return { char = " ", fg = { 1, 1, 1, 1 }, bg = { 0, 0, 0, 0 }, blink = false }
end

function biom.scroll(n)
    n = n or 1
    for _ = 1, n do
        for y = 1, console.H - 1 do
            console.grid[y] = console.grid[y + 1]
        end
        console.grid[console.H] = {}
        for x = 1, console.W do
            console.grid[console.H][x] = blank_cell()
        end
    end
end

function biom.print_line(str, fg)
    biom.write(0, console.cursor_y - 1, str, fg)
    console.cursor_y = console.cursor_y + 1
    if console.cursor_y > console.H then
        biom.scroll()
        console.cursor_y = console.H
    end
end

function biom.clear()
    for y = 1, console.H do
        for x = 1, console.W do
            console.grid[y][x] = blank_cell()
        end
    end
    console.cursor_x = 1
    console.cursor_y = 1
end

function biom.clear_line(y)
    if y < 1 or y > console.H then return end
    for x = 1, console.W do
        console.grid[y][x] = blank_cell()
    end
end

function biom.set_cursor(x, y)
    console.cursor_x = math.max(1, math.min(x, console.W))
    console.cursor_y = math.max(1, math.min(y, console.H))
end

function biom.get_cursor()
    return console.cursor_x, console.cursor_y
end

function biom.get_console_size()
    return console.W, console.H
end

function biom.getchar()
    local key, char = coroutine.yield("getchar")
    return key, char
end

return biom
