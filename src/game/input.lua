-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local game = require("src.game.game")
local utils = require("src.utils.utils")

local input = {}

local function active_settings()
    if game.active_settings then
        return game.active_settings
    end
    return Settings
end

input.old = {
    left = false,
    right = false,
    soft_drop = false,
    cw = false,
    ccw = false,
    rot180 = false,
    hold = false,
    hard_drop = false,
}
input.now = {
    left = false,
    right = false,
    soft_drop = false,
    cw = false,
    ccw = false,
    rot180 = false,
    hold = false,
    hard_drop = false,
}
input.rep = {
    left      = { active = false, das_t = 0, arr_t = 0, das_done = false },
    right     = { active = false, das_t = 0, arr_t = 0, das_done = false },
    soft_drop = { active = false, arr_t = 0 },
}

local function tap_action(now, old, action)
    if now and not old then
        action()
    end
end

local function key_down(k)
    if not k then return false end
    return love.keyboard.isDown(k)
end

function input.apply_preinput()
    local s = active_settings()
    if not s.input.preop then return end
    local k           = s.input.keys
    local old         = input.old
    local rep         = input.rep

    local hold_down   = key_down(k.hold)
    local cw_down     = key_down(k.cw)
    local ccw_down    = key_down(k.ccw)
    local rot180_down = key_down(k.rot180)
    local left_down   = key_down(k.left)
    local right_down  = key_down(k.right)

    if hold_down then
        game.do_hold()
        old.hold = true
    end

    if cw_down and ccw_down then
        game.rotate_180(true)
    elseif cw_down then
        game.rotate_cw(true)
    elseif ccw_down then
        game.rotate_ccw(true)
    elseif rot180_down then
        game.rotate_180(true)
    end

    if cw_down then old.cw = true end
    if rot180_down then old.rot180 = true end
    if ccw_down then old.ccw = true end

    if left_down then
        old.left = true
        if not rep.left.active then
            rep.left.active = true
            rep.left.das_t = 0
            rep.left.arr_t = 0
            rep.left.das_done = false
        end
    end
    if right_down then
        old.right = true
        if not rep.right.active then
            rep.right.active = true
            rep.right.das_t = 0
            rep.right.arr_t = 0
            rep.right.das_done = false
        end
    end
    if left_down then
        game.move_left()
    elseif right_down then
        game.move_right()
    end
end

local function axis_move(rep, now, old, ms, move_fn)
    if not now then
        rep.active = false
        rep.das_t = 0
        rep.arr_t = 0
        rep.das_done = false
        return
    end
    if not old then
        rep.active = true
        rep.das_t = 0
        rep.arr_t = 0
        rep.das_done = false
        move_fn()
        return
    end
    if not rep.active then return end
    local s = active_settings()
    local ds = utils.frame_ms(s.input.das)
    local ar = utils.frame_ms(s.input.arr)

    if not rep.das_done then
        rep.das_t = rep.das_t + ms
        if rep.das_t >= ds then
            rep.das_done = true
            rep.arr_t = 0
            if move_fn() and ar <= 0 then
                while move_fn() do end
            end
        end
        return
    end

    if ar <= 0 then
        while move_fn() do end
        return
    end

    rep.arr_t = rep.arr_t + ms
    while rep.arr_t >= ar do
        rep.arr_t = rep.arr_t - ar
        if not move_fn() then
            rep.arr_t = 0
            break
        end
    end
end

local function soft_drop_rep(rep, now, old, ms)
    if not now then
        rep.active = false
        rep.arr_t = 0
        return
    end
    if not old then
        rep.active = true
        rep.arr_t = 0
        local ar0 = utils.frame_ms(active_settings().input.drop_arr)
        if ar0 <= 0 then
            while game.soft_drop() do end
            return
        end
        game.soft_drop()
        return
    end
    if not rep.active then return end
    local ar = utils.frame_ms(active_settings().input.drop_arr)
    if ar <= 0 then
        while game.soft_drop() do end
        return
    end
    rep.arr_t = rep.arr_t + ms
    while rep.arr_t >= ar do
        rep.arr_t = rep.arr_t - ar
        if not game.soft_drop() then
            rep.arr_t = 0
            break
        end
    end
end

function input.update(dt)
    local k       = active_settings().input.keys
    local now     = input.now
    local old     = input.old
    local rep     = input.rep
    local ms      = dt * 1000

    now.left      = key_down(k.left)
    now.right     = key_down(k.right)
    now.soft_drop = key_down(k.soft_drop)
    now.cw        = key_down(k.cw)
    now.ccw       = key_down(k.ccw)
    now.rot180    = key_down(k.rot180)
    now.hold      = key_down(k.hold)
    now.hard_drop = key_down(k.hard_drop)

    if now.left and now.right then
        local left_just_pressed  = now.left and not old.left
        local right_just_pressed = now.right and not old.right

        if right_just_pressed and not left_just_pressed then
            rep.left.active   = false
            rep.left.das_t    = 0
            rep.left.arr_t    = 0
            rep.left.das_done = false
        elseif left_just_pressed and not right_just_pressed then
            rep.right.active   = false
            rep.right.das_t    = 0
            rep.right.arr_t    = 0
            rep.right.das_done = false
        end
    end

    tap_action(now.rot180, old.rot180, game.rotate_180)
    tap_action(now.cw, old.cw, game.rotate_cw)
    tap_action(now.ccw, old.ccw, game.rotate_ccw)
    tap_action(now.hold, old.hold, game.do_hold)
    tap_action(now.hard_drop, old.hard_drop, game.hard_drop)

    axis_move(rep.left, now.left, old.left, ms, game.move_left)
    axis_move(rep.right, now.right, old.right, ms, game.move_right)
    soft_drop_rep(rep.soft_drop, now.soft_drop, old.soft_drop, ms)

    for key in pairs(now) do
        old[key] = now[key]
    end
end

function input.reset()
    for _, tbl in ipairs({ input.old, input.now, input.rep }) do
        for k in pairs(tbl) do
            local v = tbl[k]
            if type(v) == "boolean" then
                tbl[k] = false
            elseif type(v) == "table" then
                v.active = false
                v.das_t = 0
                v.arr_t = 0
                v.das_done = false
            end
        end
    end
end

return input
