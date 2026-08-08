local mode = {
    marathon = function(time, clears, scores, level, ren, b2b, gravity)
        local lv = math.floor(clears / 10) + 1
        local i = level - 1
        local time_per_cell = (0.8 - (i * 0.007)) ^ i
        return {
            level = lv,
            gravity = 1.0 / (60.0 * time_per_cell),
            target = clears >= 150,
            record = scores,
            result = { "SCORES", scores }
        }
    end,
    sprint = function(time, clears, scores, level, ren, b2b, gravity)
        local time_str = string.format("%02d:%02d.%02d",
            math.floor(time / 60),
            math.floor(time % 60),
            math.floor(time * 100) % 100)

        return {
            level = 1,
            gravity = 1 / 64,
            target = clears >= 40,
            record = time,
            result = { "TIME", time_str }
        }
    end,
}

return mode
