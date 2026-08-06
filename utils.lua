-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local utils = {}

function utils.utf8_len(text)
    local count = 0
    local i = 1
    while i <= #text do
        local byte = string.byte(text, i)
        local len
        if byte < 128 then len = 1
        elseif byte < 192 then len = 1
        elseif byte < 224 then len = 2
        elseif byte < 240 then len = 3
        else len = 4
        end
        count = count + 1
        i = i + len
    end
    return count
end

return utils
