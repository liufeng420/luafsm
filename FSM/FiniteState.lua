require "Action"
require "FiniteStateTransition"

FiniteState = {}

function FiniteState.new(name,action)
    local state = {}
    -- 状态的数据
    state.name_ = name
    state.action_ = action

    return state
end
