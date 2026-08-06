-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local vgafont = require("lib.vgafont")

local game = {}

game.time = 0
game.clears = 0
game.scores = 0
game.level = 0

function game.reset()
    game.time = 0
    game.clears = 0
    game.scores = 0
    game.level = 0
end

function game.update(dt)
    game.time = game.time + dt
end

local function draw_game_info(font, colors, gx, gy, pw, ph, bw)
    local ix = gx + pw + bw + 8
    local iy = gy + ph + bw - 8

    local info = {
        scores = string.format("SCORES %d", game.scores),
        clears = string.format("CLEARS %d", game.clears),
        level  = string.format("LEVEL  %d", game.level),
        time   = string.format("TIME   %02d:%02d.%02d",
            math.floor(game.time / 60),
            math.floor(game.time % 60),
            math.floor((game.time * 100) % 100)
        ),
    }

    vgafont.print_outlined(font, info.scores, ix, iy - 8 * 3, 1, colors.white, colors.out_line)
    vgafont.print_outlined(font, info.clears, ix, iy - 8 * 2, 1, colors.white, colors.out_line)
    vgafont.print_outlined(font, info.level,  ix, iy - 8 * 1, 1, colors.white, colors.out_line)
    vgafont.print_outlined(font, info.time,   ix, iy - 8 * 0, 1, colors.white, colors.out_line)
end

function game.draw(font, colors, gx, gy, pw, ph, bw)
    love.graphics.clear(unpack(colors.background))

    love.graphics.setColor(unpack(colors.playfield_bg))
    love.graphics.rectangle("fill", gx, gy, pw, ph)

    love.graphics.setColor(unpack(colors.white))
    love.graphics.rectangle("fill", gx - bw, gy - bw, pw + bw * 2, bw)
    love.graphics.rectangle("fill", gx - bw, gy + ph, pw + bw * 2, bw)
    love.graphics.rectangle("fill", gx - bw, gy, bw, ph)
    love.graphics.rectangle("fill", gx + pw, gy, bw, ph)

    draw_game_info(font, colors, gx, gy, pw, ph, bw)
end

return game
