local push = require("lib.push")

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
end

function love.draw()
    push:apply("start")

    love.graphics.clear(0.1, 0.1, 0.15)

    push:apply("end")
end

function love.resize(w, h)
    push:resize(w, h)
end