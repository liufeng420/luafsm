package.path = package.path..';.\\testFsm\\?.lua;.\\FSM\\?.lua'
local SoldierLogic = require("SoldierLogic")
print(0)
-- local breakSocketHandle, debugXpCall = require("LuaDebug")("localhost", 7003)

function main( ... )
    local soldierFsm = SoldierLogic.new("SoldierLogic")
    for i = 1, 100 do
        print(i, soldierFsm:GetCurrentStateStatus())
        soldierFsm:Update(0.5)
    end
end
main()
