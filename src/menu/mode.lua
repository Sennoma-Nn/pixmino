local mode = {
    marathon = {
        get_info = {
            bgm          = "korobeiniki1",
            level        = function(game) return math.floor(game.clears / 10) + 1 end,
            gravity      = function(game)
                local i = game.level - 1
                local time_per_cell = (0.8 - (i * 0.007)) ^ i
                return 1.0 / (60.0 * time_per_cell)
            end,
            lock_delay   = function(game)
                local lv = math.floor(game.clears / 10) + 1
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
            update_end = function(game)
                if not game.cleared and game.clears >= 150 then
                    local old = game.save.get_record("marathon")
                    game.finish({ "SCORES", game.scores })
                    if old == nil or game.scores > old then
                        game.save_record("marathon", game.scores)
                    end
                end
            end,
            on_game_over = function(game)
                local old = game.save.get_record("marathon")
                if old == nil or game.scores > old then
                    game.save_record("marathon", game.scores)
                end
            end,
        },
    },

    sprint = {
        get_info = {
            bgm          = "katyusha",
            level        = 1,
            gravity      = 1 / 64,
            lock_delay   = 30,
            lock_wait    = 0,
            clear_wait   = 0,
            save_on_over = false,
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
                    local old = game.save.get_record("sprint_40")
                    game.finish({ "TIME", game.utils.format_time(game.time) })
                    if old == nil or game.time < old then
                        game.save_record("sprint_40", game.time)
                    end
                end
            end,
        },
    },

    master = {
        get_info = {
            bgm          = "katyusha",
            level        = function(game) return math.floor(game.clears / 10) + 1 end,
            gravity      = 1200,
            lock_delay   = function(game)
                local lv = math.floor(game.clears / 10) + 1
                return 30 - 0.75 * (lv - 1)
            end,
            lock_resets  = 20,
            lock_wait    = 6,
            clear_wait   = function(game)
                local lv = math.floor(game.clears / 10) + 1
                return 15 - 0.4 * (lv - 1)
            end,
            bone         = function(game)
                local lv = math.floor(game.clears / 10) + 1
                return lv > 25
            end,
            save_on_over = true,
            goal_lines   = {
                { text = "1/4", line = 75,  color = { 1, 1, 1, 0.25 } },
                { text = "1/2", line = 150, color = { 1, 1, 1, 0.5 } },
                { text = "3/4", line = 225, color = { 1, 1, 1, 0.25 } },
                { text = "???", line = 250, color = { 1.0, 0.69, 0.0, 0.5 } },
                { text = "END", line = 300, color = { 1, 0, 0, 1 } },
            },
            settings     = {
                input = {
                    das = function(game)
                        local lv = math.floor(game.clears / 10) + 1
                        return 10 - 0.2 * (lv - 1)
                    end,
                    arr = function(game)
                        local lv = math.floor(game.clears / 10) + 1
                        return lv > 15 and 2 or 1
                    end,
                },
            },
        },
        hooks = {
            update_end = function(game)
                if not game.cleared and game.clears >= 300 then
                    local old = game.save.get_record("master")
                    game.finish({ "LINES", game.clears })
                    if old == nil or game.clears > old then
                        game.save_record("master", game.clears)
                    end
                end
            end,
            on_game_over = function(game)
                local old = game.save.get_record("master")
                if old == nil or game.clears > old then
                    game.save_record("master", game.clears)
                end
            end,
        },
    },

    no_move = {
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
                { text = "END", line = 40, color = { 1, 0, 0, 1 } },
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
                if not game.cleared and game.clears >= 40 then
                    local old = game.save.get_record("no_move")
                    game.finish({ "TIME", game.utils.format_time(game.time) })
                    if old == nil or game.time < old then
                        game.save_record("no_move", game.time)
                    end
                end
            end,
        },
    },

    bone_test = {
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
    },

    debug = {
        get_info = {
            level       = "/",
            gravity     = 0,
            lock_delay  = math.huge,
            lock_resets = math.huge,
            lock_wait   = 0,
            clear_wait  = 0,
        },
    },
}

return mode
