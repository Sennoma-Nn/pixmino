-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local console  = require("src.debug.console")

local cio      = {}

cio._key_queue = {}

local function v(c)
    return c / 255
end

cio.palette = {
    [00] = { v(000), v(000), v(000) },
    [01] = { v(000), v(000), v(170) },
    [02] = { v(000), v(170), v(000) },
    [03] = { v(000), v(170), v(170) },
    [04] = { v(170), v(000), v(000) },
    [05] = { v(170), v(000), v(170) },
    [06] = { v(170), v(085), v(000) },
    [07] = { v(170), v(170), v(170) },
    [08] = { v(085), v(085), v(085) },
    [09] = { v(085), v(085), v(255) },
    [10] = { v(085), v(255), v(085) },
    [11] = { v(085), v(255), v(255) },
    [12] = { v(255), v(085), v(085) },
    [13] = { v(255), v(085), v(255) },
    [14] = { v(255), v(255), v(085) },
    [15] = { v(255), v(255), v(255) },
}

function cio.fg(index)
    local p = cio.palette[index]
    return { p[1], p[2], p[3], 1 }
end

function cio.bg(index)
    local p = cio.palette[index]
    return { p[1], p[2], p[3], 1 }
end

function cio.push_key(key, char)
    cio._key_queue[#cio._key_queue + 1] = { key = key, char = char }
end

function cio.read_key()
    local entry = table.remove(cio._key_queue, 1)
    if not entry then return nil end
    return entry.key, entry.char
end

function cio.flush_keys()
    cio._key_queue = {}
end

function cio.put(x, y, char, fg, bg, blink)
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

function cio.write(x, y, str, fg, bg, blink)
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

        cio.put(x - 1, y - 1, ch, fg, bg, blink)

        x = x + 1
        i = i + len
    end
end

local function blank_cell()
    return { char = " ", fg = { 1, 1, 1, 1 }, bg = { 0, 0, 0, 0 }, blink = false }
end

function cio.scroll(n)
    n = n or 1
    for i = 1, n do
        for y = 1, console.H - 1 do
            console.grid[y] = console.grid[y + 1]
        end
        console.grid[console.H] = {}
        for x = 1, console.W do
            console.grid[console.H][x] = blank_cell()
        end
    end
end

function cio.print_line(str, fg)
    cio.write(0, console.cursor_y - 1, str, fg)
    console.cursor_y = console.cursor_y + 1
    if console.cursor_y > console.H then
        cio.scroll()
        console.cursor_y = console.H
    end
end

function cio.clear()
    for y = 1, console.H do
        for x = 1, console.W do
            console.grid[y][x] = blank_cell()
        end
    end
    console.cursor_x = 1
    console.cursor_y = 1
end

function cio.clear_line(y)
    if y < 1 or y > console.H then return end
    for x = 1, console.W do
        console.grid[y][x] = blank_cell()
    end
end

function cio.set_cursor(x, y)
    console.cursor_x = math.max(1, math.min(x, console.W))
    console.cursor_y = math.max(1, math.min(y, console.H))
end

function cio.get_cursor()
    return console.cursor_x, console.cursor_y
end

function cio.get_console_size()
    return console.W, console.H
end

function cio.getchar()
    local key, char = coroutine.yield("getchar")
    return key, char
end

return cio
