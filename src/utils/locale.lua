-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local locale = {}

locale.current = "en"
locale.langs = {}
locale.names = {}

locale.t = {}

local function load_i18n()
    local dir = "src/i18n"
    local files = love.filesystem.getDirectoryItems(dir)
    for i, f in ipairs(files) do
        if f:match("%.lua$") then
            local basename = f:gsub("%.lua$", "")
            local ok, mod = pcall(require, "src.i18n." .. basename)
            if ok and type(mod) == "table" and mod.info and mod.text then
                local id = mod.info.id
                locale.names[id] = mod.info.name
                locale.t[id] = mod.text
                locale.langs[#locale.langs + 1] = id
            end
        end
    end
end

load_i18n()
table.sort(locale.langs)

function locale.get(key, lang)
    local entry = lang and locale.t[lang] or locale.t[locale.current]
    if not entry then return key end
    return entry[key] or key
end

return locale
