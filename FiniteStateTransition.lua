FiniteStateTransition = {}

function FiniteStateTransition.new(toStateName,evaluator)
    local transition = {}

    -- 状态转换条件的数据
    transition.evaluator_ = evaluator
    transition.toStateName_ = toStateName

    return transition
end
