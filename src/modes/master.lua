-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local lv = 0

return {
    get_info = {
        record_key   = "master",
        bast_format  = function(i) return i end,
        bgm          = "katyusha",
        level        = function(game) return lv end,
        gravity      = 1200,
        lock_delay   = function(game)
            return 30 - 0.75 * (lv - 1)
        end,
        lock_resets  = 20,
        lock_wait    = function(game)
            return 12 - 0.2 * (lv - 1)
        end,
        clear_wait   = function(game)
            return 16 - 0.2 * (lv - 1)
        end,
        bone         = function(game)
            return lv > 25
        end,
        save_on_over = true,
        goal_lines   = {
            { text = "1/4",   line = 75,  color = { 1, 1, 1, 0.25 } },
            { text = "1/2",   line = 150, color = { 1, 1, 1, 0.5 } },
            { text = "3/4",   line = 225, color = { 1, 1, 1, 0.25 } },
            { text = "???",   line = 250, color = { 1.0, 0.7, 0.0, 0.5 } },
            { text = "CLEAR", line = 300, color = { 1, 0, 0, 1 } },
        },
        settings     = {
            input = {
                das = function(game)
                    return 10 - 0.2 * (lv - 1)
                end,
                arr = function(game)
                    return lv > 15 and 2 or 1
                end,
            },
        },
    },
    hooks = {
        update_start = function(game)
            lv = math.floor(game.clears / 10) + 1
        end,
        update_end = function(game)
            if game.clears >= 300 then
                game.set_cleared()
            end
        end,
        on_game_end = function(game)
            game.set_result({ "LINES", game.clears })
        end,
        on_game_cleared = function(game)
            local old = game.save.get_record("master")
            if old == nil or game.clears > old then
                game.save_record("master", game.clears)
            end
        end,
        on_game_over = function(game)
            local old = game.save.get_record("master")
            if old == nil or game.clears > old then
                game.save_record("master", game.clears)
            end
        end,
    },
}
