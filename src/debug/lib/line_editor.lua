-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local console = require("src.debug.console")
local cio = require("src.debug.console_io")

local line_editor = {}

local fg_prompt = cio.fg(14)

local UTF8_CHAR = "[%z\1-\127\194-\244][\128-\191]*"

local function split_chars(s)
    local t = {}
    for m in s:gmatch(UTF8_CHAR) do
        t[#t + 1] = m
    end
    return t
end

local function join_chars(t)
    return table.concat(t)
end

function line_editor.new(history)
    local self = setmetatable({}, { __index = line_editor })
    self.history = history or {}
    return self
end

function line_editor:read_line(cio, prompt_text)
    local cx, cy = cio.get_cursor()
    local buf_chars = {}
    local cursor = 1
    local hist_idx
    local draft

    local function join_buf()
        return join_chars(buf_chars)
    end

    local function render()
        cio.clear_line(cy)
        cio.write(0, cy - 1, prompt_text, fg_prompt)
        cio.write(#prompt_text, cy - 1, join_buf())
    end

    local function set_cursor()
        local col = math.min(#prompt_text + cursor, console.W)
        cio.set_cursor(col, cy)
    end

    local function render_and_cursor()
        render()
        set_cursor()
    end

    local function set_buf(text)
        buf_chars = split_chars(text)
        cursor = #buf_chars + 1
        render_and_cursor()
    end

    render()
    set_cursor()

    while true do
        local key, ch = cio.getchar()

        if key == "return" then
            break
        elseif key == "left" then
            if cursor > 1 then
                cursor = cursor - 1
                set_cursor()
            end
        elseif key == "right" then
            if cursor <= #buf_chars then
                cursor = cursor + 1
                set_cursor()
            end
        elseif key == "up" then
            if #self.history > 0 then
                if hist_idx == nil then
                    draft = join_buf()
                    hist_idx = #self.history
                    set_buf(self.history[hist_idx])
                elseif hist_idx > 1 then
                    hist_idx = hist_idx - 1
                    set_buf(self.history[hist_idx])
                end
            end
        elseif key == "down" then
            if hist_idx == nil then
            elseif hist_idx < #self.history then
                hist_idx = hist_idx + 1
                set_buf(self.history[hist_idx])
            else
                hist_idx = nil
                set_buf(draft or "")
            end
        elseif key == "backspace" then
            if cursor > 1 then
                table.remove(buf_chars, cursor - 1)
                cursor = cursor - 1
                render_and_cursor()
            end
        elseif key == "delete" then
            if cursor <= #buf_chars then
                table.remove(buf_chars, cursor)
                render_and_cursor()
            end
        elseif ch then
            if #buf_chars < console.W - #prompt_text then
                table.insert(buf_chars, cursor, ch)
                cursor = cursor + 1
                render_and_cursor()
            end
        end
    end

    local line = join_buf()

    if cy + 1 > console.H then
        cio.scroll()
        cio.set_cursor(1, console.H)
    else
        cio.set_cursor(1, cy + 1)
    end

    if line ~= "" and self.history[#self.history] ~= line then
        self.history[#self.history + 1] = line
    end

    return line
end

return line_editor
