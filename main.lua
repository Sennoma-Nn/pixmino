local push = require("lib.push")
local vgafont = require("lib.vgafont")

local style = {
    block_size = 8;
    playfield_width = 2
}

local playfield = {
    width = 10;
    height = 20;
}

local font = nil

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

    font = vgafont.load("font/IB-FULL.F08", "cp437")
end

function love.draw()
    push:apply("start")

    love.graphics.clear(0.1, 0.1, 0.15)

    local pw = playfield.width * style.block_size
    local ph = playfield.height * style.block_size
    local gx = (push:getWidth() - pw) / 2
    local gy = (push:getHeight() - ph) / 2
    local bw = style.playfield_width

    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", gx, gy, pw, ph)

    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", gx - bw, gy - bw, pw + bw * 2, bw)
    love.graphics.rectangle("fill", gx - bw, gy + ph, pw + bw * 2, bw)
    love.graphics.rectangle("fill", gx - bw, gy, bw, ph)
    love.graphics.rectangle("fill", gx + pw, gy, bw, ph)

    if font then
        love.graphics.setColor(1, 1, 1)
        vgafont.print(font, "√11\r\n♥♦♣♠\r\n◙◙◙◙◙◙◙◙◙◙\r\nHELLO\r\nPIXTRIS", gx, gy, 1)
    end

    push:apply("end")
end

function love.resize(w, h)
    push:resize(w, h)
end