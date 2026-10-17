-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

return {
    get_info = {
        bgm          = "katyusha",
        level        = 1,
        gravity      = 1 / 64,
        lock_delay   = math.huge,
        lock_resets  = math.huge,
        lock_wait    = 0,
        clear_wait   = 0,
        save_on_over = false,
        goal_lines   = {
            { text = "1/2", line = 20, color = { 1, 1, 1, 0.5 } },
            { text = "CLEAR", line = 40, color = { 1, 0, 0, 1 } },
        },
        settings     = {
            input = {
                preop = false,
                keys = {
                    left = false,
                    right = false,
                },
            },
        },
    },
    hooks = {
        update_end = function(game)
            if game.clears >= 40 then
                game.set_cleared()
            end
        end,
        on_game_end = function(game)
            game.set_result({ "TIME", game.utils.format_time(game.time) })
        end,
        on_game_cleared = function(game)
            local old = game.save.get_record("no_move")
            if old == nil or game.time < old then
                game.save_record("no_move", game.time)
            end
        end,
    },
}
