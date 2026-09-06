local utils = require("src.utils.utils")

local sfx = {}

local sources = {}

local bgm_source = nil
local bgm_current = nil
local bgm_volume = 0.4
local sfx_volume = 1.0
local bgm_files = {}
local volume_scale = {
}

local function scan_dir(dir, out)
    local it = love.filesystem.getDirectoryItems(dir)
    for _, filename in ipairs(it) do
        local base = filename:match("^(.*)%.[^.]+$") or filename
        if not out[base] then
            out[base] = dir .. "/" .. filename
        end
    end
end

function sfx.load()
    local sfx_files = {}
    scan_dir("assets/sfx", sfx_files)
    for name, path in pairs(sfx_files) do
        local ok, src = pcall(love.audio.newSource, path, "static")
        if ok then
            src:setVolume(sfx_volume)
            sources[name] = src
        end
    end
    bgm_files = {}
    scan_dir("assets/bgm", bgm_files)
end

function sfx.play(name)
    local src = sources[name]
    if src then
        src:stop()
        src:setVolume(sfx_volume * (volume_scale[name] or 1))
        src:play()
    end
end

function sfx.set_bgm_volume(v)
    bgm_volume = utils.clamp(v, 0, 1)
    if bgm_source then
        bgm_source:setVolume(bgm_volume)
    end
end

function sfx.get_bgm_volume()
    return bgm_volume
end

function sfx.set_sfx_volume(v)
    sfx_volume = utils.clamp(v, 0, 1)
end

function sfx.get_sfx_volume()
    return sfx_volume
end

function sfx.update()
    local name = BGM
    if name == bgm_current then return end

    if bgm_source then
        bgm_source:stop()
        bgm_source = nil
    end
    bgm_current = name

    if not name then return end

    local path = bgm_files[name]
    if not path then
        bgm_current = nil
        return
    end

    local ok, src = pcall(love.audio.newSource, path, "stream")
    if not ok then
        bgm_current = nil
        return
    end

    src:setLooping(true)
    src:setVolume(bgm_volume)
    bgm_source = src
    bgm_source:play()
end

return sfx
