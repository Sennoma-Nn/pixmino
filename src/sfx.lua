local sfx = {}

local sources = {}

local names = {
    "clear",
    "hard_drop",
    "level_up",
    "lock",
    "perfect_clear",
    "spin",
}

function sfx.load()
    for _, name in ipairs(names) do
        sources[name] = love.audio.newSource("assets/sfx/" .. name .. ".wav", "static")
    end
end

function sfx.play(name)
    local src = sources[name]
    if src then
        src:stop()
        src:play()
    end
end

return sfx
