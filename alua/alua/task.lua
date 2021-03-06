------------------------------------------------------------------------------
-- Task
--
-- Module to manage the events that the process sends to itself.
--
-- version: 1.1 2010/05/30
-----------------------------------------------------------------------------

module("alua.task", package.seeall)

-----------------------------------------------------------------------------
-- Exported variables
-----------------------------------------------------------------------------
hasdata = false

-----------------------------------------------------------------------------
-- Module variables
-----------------------------------------------------------------------------
local signal = false
local tasks = {}

-----------------------------------------------------------------------------
-- Exported functions
-----------------------------------------------------------------------------

-----------------------------------------------------------------------------
-- Processes the messages (events)
--
-- @return true if events were processed
-----------------------------------------------------------------------------
function process()
    if hasdata then
        local tmp = tasks
        tasks = {}
        hasdata = false
        for _, t in ipairs(tmp) do
            t.func(unpack(t.args))
        end
        return true
    end
end

-----------------------------------------------------------------------------
-- Sends a message (event) to itself
-----------------------------------------------------------------------------
function schedule(f, ...)
    tasks[#tasks+1] = {func = f, args = {...}}
    hasdata = true
end

-----------------------------------------------------------------------------
-- End exported functions
-----------------------------------------------------------------------------
