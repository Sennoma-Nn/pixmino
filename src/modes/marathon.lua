-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local lv = 0

return {
    get_info = {
        bgm          = "korobeiniki1",
        level        = function(game) return lv end,
        gravity      = function(game)
            local i = game.level - 1
            local time_per_cell = (0.8 - (i * 0.007)) ^ i
            return 1.0 / (60.0 * time_per_cell)
        end,
        lock_delay   = function(game)
            return math.max(2 ^ (-(lv - 1) / 14 * 8) * 60, 30)
        end,
        lock_wait    = 6,
        clear_wait   = 15,
        save_on_over = true,
        goal_lines   = {
            { text = "50L",  line = 50,  color = { 1, 1, 1, 0.25 } },
            { text = "100L", line = 100, color = { 1, 1, 1, 0.5 } },
            { text = "END",  line = 150, color = { 1, 0, 0, 1 } },
        },
        settings     = {
            input = {
                das = 9,
                arr = 2,
                drop_arr = 2,
            },
        },
    },
    hooks = {
        update_start = function(game)
            lv = math.floor(game.clears / 10) + 1
        end,
        update_end = function(game)
            if game.clears >= 150 then
                game.set_cleared()
            end
        end,
        on_game_end = function(game)
            game.set_result({ "SCORES", game.scores })
        end,
        on_game_cleared = function(game)
            local old = game.save.get_record("marathon")
            if old == nil or game.scores > old then
                game.save_record("marathon", game.scores)
            end
        end,
        on_game_over = function(game)
            local old = game.save.get_record("marathon")
            if old == nil or game.scores > old then
                game.save_record("marathon", game.scores)
            end
        end,
    },
}
