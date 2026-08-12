local utils = require("src.utils.utils")

local mode = {
    marathon = function(time, clears, scores, level, ren, b2b, gravity, old_record)
        local lv = math.floor(clears / 10) + 1
        local i = level - 1
        local time_per_cell = (0.8 - (i * 0.007)) ^ i

        local update
        if old_record == nil then
            update = true
        else
            update = scores > old_record
        end

        return {
            level = lv,
            gravity = 1.0 / (60.0 * time_per_cell),
            target = clears >= 150,
            record = scores,
            result = { "SCORES", scores },
            record_update = update,
            save_on_over = true,
            lock_delay = math.max(2 ^ (-(lv - 1) / 14 * 8) * 60, 30),
            lock_wait = 6,
            clear_wait = 15,
            goal_lines = {
                { line = 50,  color = { 1, 1, 1, 0.25 } },
                { line = 100, color = { 1, 1, 1, 0.5 } },
                { line = 150, color = { 1, 0, 0, 1 } },
            },
            settings = {
                input = {
                    das = 9,
                    arr = 2,
                    drop_arr = 2,
                },
            },
        }
    end,

    sprint = function(time, clears, scores, level, ren, b2b, gravity, old_record)
        local time_str = utils.format_time(time)

        local update
        if old_record == nil then
            update = true
        else
            update = time < old_record
        end

        return {
            level = 1,
            gravity = 1 / 64,
            target = clears >= 40,
            record = time,
            result = { "TIME", time_str },
            record_update = update,
            save_on_over = false,
            lock_delay = 30,
            lock_wait = 0,
            clear_wait = 0,
            goal_lines = {
                { line = 20, color = { 1, 1, 1, 0.5 } },
                { line = 40, color = { 1, 0, 0, 1 } },
            },
        }
    end,

    master = function(time, clears, scores, level, ren, b2b, gravity, old_record)
        local lv = math.floor(clears / 10) + 1

        local update
        if old_record == nil then
            update = true
        else
            update = clears > old_record
        end

        local lock_delay = 30 - 0.75 * (lv - 1)
        local das = 10 - 0.2 * (lv - 1)
        local arr = lv > 15 and 2 or 1
        local clear_wait = 15 - 0.4 * (lv - 1)
        local bone = lv > 25

        return {
            level = lv,
            gravity = 1200,
            target = clears >= 300,
            record = clears,
            result = { "LINES", clears },
            record_update = update,
            save_on_over = true,
            lock_delay = lock_delay,
            lock_wait = 6,
            clear_wait = clear_wait,
            lock_resets = 20,
            bone = bone,
            goal_lines = {
                { line = 75, color = { 1, 1, 1, 0.25 } },
                { line = 150, color = { 1, 1, 1, 0.5 } },
                { line = 225, color = { 1, 1, 1, 0.25 } },
                { line = 250, color = { 0, 1, 0, 0.5 } },
                { line = 300, color = { 1, 0, 0, 1 } },
            },
            settings = {
                input = {
                    das = das,
                    arr = arr,
                },
            },
        }
    end,
}

return mode
