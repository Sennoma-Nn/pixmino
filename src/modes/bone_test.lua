-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

return {
    get_info = {
        bgm          = "katyusha",
        level        = 1,
        gravity      = 1 / 64,
        lock_delay   = 30,
        lock_wait    = 0,
        clear_wait   = 0,
        save_on_over = false,
        bone         = true,
        goal_lines   = {
            { text = "1/2", line = 20, color = { 1, 1, 1, 0.5 } },
            { text = "END", line = 40, color = { 1, 0, 0, 1 } },
        },
        settings     = {
            input = {
                preop = false,
            },
        },
    },
    hooks = {
        update_end = function(game)
            if not game.cleared and game.clears >= 40 then
                local old = game.save.get_record("bone_test")
                game.finish({ "TIME", game.utils.format_time(game.time) })
                if old == nil or game.time < old then
                    game.save_record("bone_test", game.time)
                end
            end
        end,
    },
}
