-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local cio            = require("src.debug.console_io")
local settings       = require("src.menu.settings")

local core           = {}

core.stack           = {}
core.commands        = {}
core.close_requested = false

local next_pid       = 1
local free_pids      = {}

function core.load()
    local dir = "src/debug/command"
    local files = love.filesystem.getDirectoryItems(dir)
    for _, f in ipairs(files) do
        if f:sub(-4) == ".lua" then
            local path = dir .. "/" .. f:sub(1, -5)
            local ok, cmd = pcall(require, path)
            if ok and cmd and cmd.name then
                core.commands[string.upper(cmd.name)] = cmd
            end
        end
    end
end

local function alloc_pid()
    local pid = table.remove(free_pids)
    if pid then return pid end
    local p = next_pid
    next_pid = next_pid + 1
    return p
end

local function release_pid(pid)
    if pid then
        free_pids[#free_pids + 1] = pid
    end
end

local function allowed(cmd)
    if cmd.danger and not settings.debug.unlock then
        return false
    end
    return true
end

function core.boot(name, args)
    core.close_requested = false
    core.stack = {}
    next_pid = 1
    free_pids = {}
    cio.flush_keys()
    local c = core.commands[string.upper(name or "SHELL")]
    if not c then return false end
    core.stack[#core.stack + 1] = {
        pid = alloc_pid(),
        co  = coroutine.create(function()
            c.run(cio, args or {})
        end),
    }
    core.pump()
    return true
end

function core.run(name, args)
    local c = core.commands[string.upper(name or "")]
    if not c then
        return false
    end
    if not allowed(c) then
        return false, "locked"
    end
    coroutine.yield("invoke", name, args or {})
    return true
end

function core.busy()
    return #core.stack > 0
end

function core.getpid()
    local top = core.stack[#core.stack]
    if not top then return nil end
    return top.pid
end

function core.exists(pid)
    for _, p in ipairs(core.stack) do
        if p.pid == pid then
            return true
        end
    end
    return false
end

local function step(...)
    local top = core.stack[#core.stack]
    if not top then return true, "idle" end

    local ok, r1, r2, r3, r4 = coroutine.resume(top.co, ...)
    if not ok then
        core.stack[#core.stack] = nil
        release_pid(top.pid)
        return false, r1
    elseif coroutine.status(top.co) == "dead" then
        core.stack[#core.stack] = nil
        release_pid(top.pid)
        return true, "exit", r1
    else
        return true, r1, r2, r3, r4
    end
end

local function spawn_named(name, args)
    local c = core.commands[string.upper(name or "")]
    if not c then return false end
    if not allowed(c) then return false end
    core.stack[#core.stack + 1] = {
        pid = alloc_pid(),
        co  = coroutine.create(function()
            c.run(cio, args or {})
        end),
    }
    return true
end

local function pump_from(ok, sig, a, b)
    while ok do
        if sig == "idle" then
            return
        elseif sig == "getchar" then
            local key, char = cio.read_key()
            if key == nil and char == nil then
                return
            end
            ok, sig, a, b = step(key, char)
        elseif sig == "invoke" then
            if spawn_named(a, b) then
                ok, sig, a, b = step()
            else
                ok, sig, a, b = step(nil)
            end
        elseif sig == "exit" then
            if core.busy() then
                ok, sig, a, b = step()
            else
                return
            end
        else
            return
        end
    end
end

function core.pump()
    local _ = core.busy() and pump_from(step())
end

function core.poll_input()
    if not core.busy() then return end
    local key, char = cio.read_key()
    if key == nil and char == nil then return end
    pump_from(step(key, char))
end

function core.reset()
    core.close_requested = false
    core.stack = {}
    next_pid = 1
    free_pids = {}
    cio.flush_keys()
end

function core.request_close()
    core.close_requested = true
end

function core.take_close_request()
    local r = core.close_requested
    core.close_requested = false
    return r
end

return core
