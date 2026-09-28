-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local skin = {}

function skin.load(name)
    impl = require(string.format("src.game.skin.%s.skin", name))
    return impl
end

function skin.base(px, py, bs, color)
    return impl.base(px, py, bs, color)
end

function skin.borders(px, py, bs, link, color)
    return impl.borders(px, py, bs, link, color)
end

return skin
