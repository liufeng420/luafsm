local FiniteAction = require("FiniteAction")
local FiniteState = require("FiniteState")
local FiniteStateTransition = require("FiniteStateTransition")

local FiniteStateMachine = {}

function FiniteStateMachine.new(userData)
    local fsm = {}

    -- 状态机的数据
    fsm.currentState_ = nil
    fsm.states_ = {}
    fsm.transition_ = {}
    fsm.userData_ = userData

    fsm.AddState = FiniteStateMachine.AddState
    fsm.AddTransition = FiniteStateMachine.AddTransition
    fsm.ContainState = FiniteStateMachine.ContainState
    fsm.ContainTransition = FiniteStateMachine.ContainTransition
    fsm.GetCurrentStateName = FiniteStateMachine.GetCurrentStateName
    fsm.GetCurrentStateStatus = FiniteStateMachine.GetCurrentStateStatus
    fsm.SetState = FiniteStateMachine.SetState
    fsm.Update = FiniteStateMachine.Update

    return fsm
end


function FiniteStateMachine.ContainState(self,stateName)
    return self.states_[stateName] ~= nil
end

function FiniteStateMachine.ContainTransition(self,fromStateName,toStateName)
    return self.transition_[fromStateName] ~= nil and
        self.transition_[fromStateName][toStateName] ~= nil
end

function FiniteStateMachine.GetCurrentStateName(self)
    if self.currentState_ then
        return self.currentState_.name_
    end
end

function FiniteStateMachine.GetCurrentStateStatus(self)
    if self.currentState_ then
        return self.currentState_.action_.status_
    end
end


function FiniteStateMachine.SetState(self,stateName)
    if self:ContainState(stateName) then
        if self.currentState_ then
            self.currentState_.action_:CleanUp()
        end

        self.currentState_ = self.states_[stateName]
        self.currentState_.action_:Initialize()
    end
end
function FiniteStateMachine.AddState(self,name,action)
    self.states_[name] = FiniteState.new(name,action)
end

function FiniteStateMachine.AddTransition(self,fromStateName,toStateName,evaluator)
    if self:ContainState(fromStateName) and
        self:ContainState(toStateName) then

        if self.transition_[fromStateName] == nil then
            self.transition_[fromStateName] = {}
        end

        table.insert(
            self.transition_[fromStateName],
            FiniteStateTransition.new(toStateName,evaluator)
        )

    end
end
local function EvaluateTransitions(self,transitions)
    for index = 1 , #transitions do
        if transitions[index].evaluator_(self.userData_) then
            return transitions[index].toStateName_;
        end
    end
end
function FiniteStateMachine.Update(self,deltaTimeInMillis)
    if self.currentState_ then
        local status = self:GetCurrentStateStatus()

        if status == FiniteAction.Status.RUNNING then
            self.currentState_.action_:Update(deltaTimeInMillis)
        elseif status == FiniteAction.Status.TERMINATED then
            local toStateName = EvaluateTransitions(self,self.transition_[self.currentState_.name_])

            if self.states_[toStateName] ~= nil then
                self.currentState_.action_:CleanUp()
                self.currentState_ = self.states_[toStateName]
                self.currentState_.action_:Initialize()
            end
        end
    end
end

return FiniteStateMachine
