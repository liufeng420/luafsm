local SoldierLogic = {}

local FiniteAction = require("FiniteAction")
local FiniteStateMachine = require("FiniteStateMachine")

local timer = 0

local function SoldierActions_IdleCleanUp(userData)
    print("SoldierActions_IdleCleanUp data is "..userData)
    timer = 0
end

local function SoldierActions_IdleInitialize(userData)
    print("SoldierActions_IdleInitialize data is "..userData)
    timer = 0
end

local function SoldierActions_IdleUpdate(deltaTimeInMillis,userData)
    print("SoldierActions_IdleUpdate data is "..userData)
    timer = (timer + 1)
    if timer > 3 then
        return FiniteAction.Status.TERMINATED
    end

    return FiniteAction.Status.RUNNING
end

local function SoldierActions_DieCleanUp(userData)
    print("SoldierActions_DieCleanUp data is "..userData)
    timer = 0
end

local function SoldierActions_DieInitialize(userData)
    print("SoldierActions_DieInitialize data is "..userData)
    timer = 0
end

local function SoldierActions_DieUpdate(deltaTimeInMillis,userData)
    print("SoldierActions_DieUpdate data is "..userData)
    timer = (timer + 1)
    if timer > 3 then
        return FiniteAction.Status.TERMINATED
    end

    return FiniteAction.Status.RUNNING
end

local function SoldierEvaluators_True(userData)
    print("SoldierEvaluators_True data is "..userData)
    return true
end

local function SoldierEvaluators_False(userData)
    print("SoldierEvaluators_True data is "..userData)
    return false
end

local function IdleAction(userData)
    return FiniteAction.new(
        "idle",
        SoldierActions_IdleInitialize,
        SoldierActions_IdleUpdate,
        SoldierActions_IdleCleanUp,
        userData
    )
end

local function DieAction(userData)
    return FiniteAction.new(
        "die",
        SoldierActions_DieInitialize,
        SoldierActions_DieUpdate,
        SoldierActions_DieCleanUp,
        userData
    )
end

function SoldierLogic.new(userData)
    local fsm = FiniteStateMachine.new(userData)
    fsm:AddState("idle",IdleAction(userData))
    fsm:AddState("die", DieAction(userData))

    fsm:AddTransition("idle","die",SoldierEvaluators_True)
    fsm:AddTransition("die","idle",SoldierEvaluators_True)

    fsm:SetState('idle')

    return fsm
end

return SoldierLogic
