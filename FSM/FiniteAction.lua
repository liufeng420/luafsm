local FiniteAction = {}

FiniteAction.Status = {
    RUNNING = "RUNNING",
    TERMINATED = "TERMINATED",
    UNINIIALIZED = "UNINIIALIZED"
}

FiniteAction.Type = "FiniteAction"

function FiniteAction.new(name,initializeFunction,updateFunction,cleanUpFunction,userData)

    local action = {}

    action.cleanUpFunction_ = cleanUpFunction
    action.initializeFunction_ = initializeFunction
    action.updateFunction_  = updateFunction
    action.name_ = name or ""
    action.status_ = FiniteAction.Status.UNINIIALIZED
    action.type_ = FiniteAction.Type
    action.userData_ = userData

    action.CleanUp = FiniteAction.CleanUp
    action.Initialize = FiniteAction.Initialize
    action.Update = FiniteAction.Update

    return action
end

function FiniteAction.Initialize(self)
    if self.status_ == FiniteAction.Status.UNINIIALIZED then
        if self.initializeFunction_ then
            self.initializeFunction_(self.userData_)
        end
    end

    self.status_ = FiniteAction.Status.RUNNING
end


function FiniteAction.Update(self,deltaTimeInMillis)
    if self.status_ == FiniteAction.Status.TERMINATED then
        return FiniteAction.Status.TERMINATED
    elseif self.status_ == FiniteAction.Status.RUNNING then
        if self.updateFunction_ then
            self.status_ = self.updateFunction_(deltaTimeInMillis,self.userData_)

            assert(self.status_)
        else
            self.status_ = FiniteAction.Status.TERMINATED
        end
    end

    return self.status_

end
function FiniteAction.CleanUp(self)
    if self.status_ == FiniteAction.Status.TERMINATED then
        if self.cleanUpFunction_ then
            self.cleanUpFunction_(self.userData_)
        end
    end

    self.status_ = FiniteAction.Status.UNINIIALIZED
end

return FiniteAction