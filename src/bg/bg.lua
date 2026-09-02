-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local bg = {}

local impls = {
    grid = require("src.bg.grid"),
}

function bg.update(dt)
    local impl = BG and impls[BG]
    if impl and impl.update then
        impl.update(dt)
    end
end

function bg.draw()
    local impl = BG and impls[BG]
    if impl and impl.draw then
        impl.draw()
    else
        love.graphics.clear(unpack(Colors.background))
    end
end

return bg
