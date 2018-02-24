timer = 0

function SoldierActions_IdleCleanUp(userData)
    print("SoldierActions_IdleCleanUp data is "..userData)
    timer = 0
end

function SoldierActions_IdleInitialize(userData)
    print("SoldierActions_IdleInitialize data is "..userData)
    timer = 0
end

function SoldierActions_IdleUpdate(deltaTimeInMillis,userData)
    print("SoldierActions_IdleUpdate data is "..userData)
    timer = (timer + 1)
    if timer > 3 then
        return Action.Status.TERMINATED
    end

    return Action.Status.RUNNING
end


function SoldierActions_DieCleanUp(userData)
    print("SoldierActions_DieCleanUp data is "..userData)
    timer = 0
end

function SoldierActions_DieInitialize(userData)
    print("SoldierActions_DieInitialize data is "..userData)
    timer = 0
end

function SoldierActions_DieUpdate(deltaTimeInMillis,userData)
    print("SoldierActions_DieUpdate data is "..userData)
    timer = (timer + 1)
    if timer > 3 then
        return Action.Status.TERMINATED
    end

    return Action.Status.RUNNING
end
