local push = require("lib.push")
local vgafont = require("lib.vgafont")

local style = {
    block_size = 8,
    playfield_width = 2
}

local playfield = {
    width = 10,
    height = 20
}

local ui_font = nil
local bold_font = nil

local is_in_game = false
local time = 0
local lines = 0

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")

    push:setupScreen(
        320 * 1, 180 * 1,
        320 * 4, 180 * 4,
        {
            pixelperfect = true,
            resizable = true,
            canvas = true
        }
    )

    ui_font = vgafont.load("font/QUADBM.F08", "cp437")
    bold_font = vgafont.load("font/IB-FULL.F08", "cp437")
end

function love.draw()
    push:apply("start")

    love.graphics.clear(0.1, 0.1, 0.15)

    local pw = playfield.width * style.block_size
    local ph = playfield.height * style.block_size
    local gy = (push:getHeight() - ph) / 2
    local gx = gy
    local bw = style.playfield_width
    local ix = gx + pw + bw + 8
    local iy = gy + ph + bw - 8

    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", gx, gy, pw, ph)

    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", gx - bw, gy - bw, pw + bw * 2, bw)
    love.graphics.rectangle("fill", gx - bw, gy + ph, pw + bw * 2, bw)
    love.graphics.rectangle("fill", gx - bw, gy, bw, ph)
    love.graphics.rectangle("fill", gx + pw, gy, bw, ph)

    local info = {
        color = {
            text     = {1, 1, 1, 1},
            out_line = {0, 0, 0, 1}
        },
        time = string.format(
            "%02d:%02d.%02d",
            math.floor(time / 60),
            math.floor(time % 60),
            math.floor((time * 100) % 100)
        ),
        lines = string.format("%dl",   lines),
    }

    vgafont.print_outlined(bold_font, info.time,  ix, iy - 12 * 0, 1, info.color.text, info.color.out_line)
    vgafont.print_outlined(bold_font, info.lines, ix, iy - 12 * 1, 1, info.color.text, info.color.out_line)

    push:apply("end")
end

function love.update(dt)
    if is_in_game then
        time = time + dt
    end
end

function love.keypressed(key)
    if key == "f4" then
        push:switchFullscreen()
    end
end

function love.resize(w, h)
    push:resize(w, h)
end
