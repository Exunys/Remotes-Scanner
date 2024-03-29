local RemoteEventsCount = 0
local RemoteFunctionsCount = 0
local TimeElapsed = 0

local REC = coroutine.create(function()
    for _, v in next, game:GetDescendants() do
        if v:IsA("RemoteEvent") then
            if v.Parent.Name ~= "DefaultChatSystemChatEvents" or v.Parent.Name ~= "RobloxReplicatedStorage" or v.Name ~= "CharacterSoundEvent" then
                RemoteEventsCount += 1
            end
        end
    end
end)

local RFC = coroutine.create(function()
    for _, v in next, game:GetDescendants() do
        if v:IsA("RemoteFunction") then
            if v.Parent.Name ~= "DefaultChatSystemChatEvents" or v.Parent.Name ~= "RobloxReplicatedStorage" or v.Name ~= "CharacterSoundEvent" then
                RemoteFunctionsCount += 1
            end
        end
    end
end)

coroutine.resume(REC)
coroutine.resume(RFC)

repeat
   wait()
until coroutine.status(REC) == "dead" or coroutine.status(RFC) == "dead"

print()
warn("Remotes scan has started.")

local Scan = coroutine.create(function()
    for _, v in next, game:GetDescendants() do
        if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
            if v.Parent.Name ~= "DefaultChatSystemChatEvents" then
                if v.Parent.Name ~= "RobloxReplicatedStorage" then
                    if v.Parent.Name ~= "DefaultSoundEvents" then
                        if v.Name ~= "CharacterSoundEvent" then
                            print("\n\n        [ "..v.ClassName.." ] :\n           {\n             Name     :   "..v.Name..",\n             Parent   :   "..v.Parent.Name..",\n             Ancestor :   "..v.Parent:FindFirstAncestor(v.Parent.Parent.Name).Name..",\n             Path     :   "..v:GetFullName()..",\n             Type     :   "..tostring(v.ClassName):sub(7, tonumber(string.len(v.ClassName))).."\n           };\n")
                        end
                    end
                end
            end
        end
    end
end)

coroutine.resume(Scan)

repeat 
    wait()
    TimeElapsed = TimeElapsed + wait()
until coroutine.status(Scan) == "dead"

warn("Remotes scan has ended, scan lasted "..TimeElapsed.." seconds.")
game:GetService("TestService"):Message("RemoteEvents Found : "..RemoteEventsCount)
game:GetService("TestService"):Message("RemoteFunctions Found : "..RemoteFunctionsCount)
print()
