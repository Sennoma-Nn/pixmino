-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local game = require("game")
local utils = require("utils")

local input = {}

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
    left      = { active = false, das_t = 0, arr_t = 0 },
    right     = { active = false, das_t = 0, arr_t = 0 },
    soft_drop = { active = false, arr_t = 0 },
}

local function tap_action(now, old, action)
    if now and not old then
        action()
    end
end

local function axis_move(rep, now, old, ms, move_fn)
    if not now then
        rep.active = false
        rep.das_t = 0
        rep.arr_t = 0
        return
    end
    if not old then
        rep.active = true
        rep.das_t = 0
        rep.arr_t = 0
        move_fn()
        return
    end
    if not rep.active then return end
    local ds = utils.frame_ms(Settings.input.das)
    local ar = utils.frame_ms(Settings.input.arr)
    rep.das_t = rep.das_t + ms
    if rep.das_t >= ds then
        rep.arr_t = rep.arr_t + ms
        while rep.arr_t >= ar do
            rep.arr_t = rep.arr_t - ar
            if not move_fn() then
                rep.arr_t = 0
                break
            end
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
        local ar0 = utils.frame_ms(Settings.input.drop_arr)
        if ar0 <= 0 then
            while game.soft_drop() do end
            return
        end
        game.soft_drop()
        return
    end
    if not rep.active then return end
    local ar = utils.frame_ms(Settings.input.drop_arr)
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
    local k       = Settings.keys
    local now     = input.now
    local old     = input.old
    local rep     = input.rep
    local ms      = dt * 1000

    now.left      = love.keyboard.isDown(k.left)
    now.right     = love.keyboard.isDown(k.right)
    now.soft_drop = love.keyboard.isDown(k.soft_drop)
    now.cw        = love.keyboard.isDown(k.cw)
    now.ccw       = love.keyboard.isDown(k.ccw)
    now.rot180    = love.keyboard.isDown(k.rot180)
    now.hold      = love.keyboard.isDown(k.hold)
    now.hard_drop = love.keyboard.isDown(k.hard_drop)

    if now.left and now.right then
        local left_just_pressed  = now.left and not old.left
        local right_just_pressed = now.right and not old.right

        if right_just_pressed and not left_just_pressed then
            rep.left.active = false
            rep.left.das_t  = 0
            rep.left.arr_t  = 0
        elseif left_just_pressed and not right_just_pressed then
            rep.right.active = false
            rep.right.das_t  = 0
            rep.right.arr_t  = 0
        end
    end

    axis_move(rep.left, now.left, old.left, ms, game.move_left)
    axis_move(rep.right, now.right, old.right, ms, game.move_right)

    soft_drop_rep(rep.soft_drop, now.soft_drop, old.soft_drop, ms)

    tap_action(now.rot180, old.rot180, game.rotate_180)
    tap_action(now.cw, old.cw, game.rotate_cw)
    tap_action(now.ccw, old.ccw, game.rotate_ccw)
    tap_action(now.hold, old.hold, game.do_hold)
    tap_action(now.hard_drop, old.hard_drop, game.hard_drop)

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
            end
        end
    end
end

return input
