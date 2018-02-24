require "SoldierActions"
require "FiniteStateMachine"
require "SoldierEvaluators"

local function IdleAction(userData)
    return Action.new(
        "idle",
        SoldierActions_IdleInitialize,
        SoldierActions_IdleUpdate,
        SoldierActions_IdleCleanUp,
        userData
    )
end


local function DieAction(userData)
    return Action.new(
        "die",
        SoldierActions_DieInitialize,
        SoldierActions_DieUpdate,
        SoldierActions_DieCleanUp,
        userData
    )
end

function SoldierLogic_FiniteStateMachine(userData)
    local fsm = FiniteStateMachine.new(userData)
    fsm:AddState("idle",IdleAction(userData))
    fsm:AddState("die",    DieAction(userData))

    fsm:AddTransition("idle","die",SoldierEvaluators_True)
    fsm:AddTransition("die","idle",SoldierEvaluators_True)

    fsm:SetState('idle')

    return fsm
end
