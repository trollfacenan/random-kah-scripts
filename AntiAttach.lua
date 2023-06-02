shared.antiattach = true
local plrs = game:GetService("Players")
local chatbox = Instance.new("TextBox", workspace)
local function chat(msg)
    chatbox:SetTextFromInput(msg)
    plrs:Chat(msg)
end
local lp = plrs.LocalPlayer
local ws = workspace
game:GetService("RunService").RenderStepped:Connect(function()
	if shared.antiattach == false then wait(20e20*20e20*20696969696969) end
	for a,plr in pairs(plrs:GetPlayers()) do
		if plr.Name ~= lp.Name then
			repeat game:GetService("RunService").RenderStepped:Wait() until ws:FindFirstChild(plr.Name)
			for i,i2 in pairs(plr.Character:GetDescendants()) do
				if i2:IsA"Weld" or i2:IsA"Snap" then
					chat(":refresh "..dsd.Parent.Parent.Name)
				end
				task.wait()
			end
		end
	end
end)
