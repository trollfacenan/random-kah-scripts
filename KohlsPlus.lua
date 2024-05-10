-- Aliases are temporarily disabled because they were bugging the script.

local function GetPlayer(text)
	for _,Player in game:GetService("Players"):GetPlayers() do
		if string.sub(string.lower(Player.Name),1,string.len(text)) == string.lower(text) then
			return Player
		end
	end
end
local settingsTable = {
	perm = not game:GetService("MarketplaceService"):PlayerOwnsAsset(game:GetService("Players").LocalPlayer, 66254), -- this is not the gamepass checker, it's for the pad grabber
	prefix = "-",
	firsttimenotification = true,
	banned = {},
	connections = {},
	no = {"9gn", "Not_Wojtek"},
	actor_missing = true -- always true
}

if not game:GetService("RunService"):IsStudio() then
	assert(game:GetService("HttpService"):JSONDecode(request({Url = "https://raw.githubusercontent.com/trollfacenan/random-kah-scripts/main/run.json", Method = "GET"}).Body).works, "Kohls+ is under maintenance, please try again later.")
	if KohlsPlus then
		return
	end
	getgenv().KohlsPlus = true
	getgenv().syn = nil
end

local function run(message)
	game:GetService("Players"):Chat(message)
end

pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/trollfacenan/random-kah-scripts/main/AntiFling.lua"))() end)

local firetouchinterestc = function(part, touchedby, idk)
	if not identifyexecutor():find("Solara") then
		firetouchtransmitter(part, touchedby, idk)
		return
	end
	assert(part, "firetouchinterest: Missing argument #1 (part to touch)")
	assert(typeof(part) == "Instance", "Argument #1 must be an Instance")
	assert(touchedby, "firetouchinterest: Missing argument #2 (part that will touch the target)")
	assert(typeof(touchedby) == "Instance", "Argument #2 must be an Instance")
	--assert(idk, "firetouchinterest: Missing argument #3 (integer)")
	assert(part:IsA("BasePart") or part:IsA("TouchTransmitter"), "firetouchinterest: Argument #1 must be a BasePart or a TouchTransmitter!")
	if part:IsA("BasePart") then
		assert(part:FindFirstChildOfClass("TouchTransmitter"), "firetouchinterest: BasePart must have a TouchTransmitter")
	end
	local fakeclone
	if part:IsA("BasePart") then
		pcall(function()
			local oldt = part.Transparency
			part.Archivable = true
			local fake = part:Clone()
			fake.Name = math.random()
			fake.Parent = part.Parent
			part.Transparency = 1
			local old = part:GetPivot()
			local olda = part.Anchored
			local oldc = part.CanCollide
			part.Anchored = true
			part.CanCollide = false
			part:PivotTo(touchedby.CFrame)
			task.wait()
			part.Anchored = olda
			part.CanCollide = oldc
			part:PivotTo(old)
			olda = nil
			oldc = nil
			part.Transparency = oldt
			fake:Destroy()
			fake = nil
		end)
	elseif part:IsA("TouchTransmitter") then
		local basepart
		repeat
			basepart = part.Parent
			task.wait()
		until basepart:IsA("BasePart")
		part = basepart
		pcall(function()
			local oldt = part.Transparency
			part.Archivable = true
			local fake = part:Clone()
			fake.Name = math.random()
			fake.Parent = part.Parent
			part.Transparency = 1
			local old = part:GetPivot()
			local olda = part.Anchored
			local oldc = part.CanCollide
			part.Anchored = true
			part.CanCollide = false
			part:PivotTo(touchedby.CFrame)
			task.wait()
			part.Anchored = olda
			part.CanCollide = oldc
			part:PivotTo(old)
			olda = nil
			oldc = nil
			part.Transparency = oldt
			fake:Destroy()
			fake = nil
		end)
	end
end

local recursive_loop
local running = false
recursive_loop = function(func, ...)
	if running then task.desynchronize()
		task.defer(recursive_loop, func, ...)
		task.synchronize()
		func(...) end
end
local recursive_loop1
recursive_loop1 = function(func, ...)
	task.desynchronize()
	task.defer(recursive_loop1, func, ...)
	task.synchronize()
	func(...)
end
loadstring(game:HttpGet("https://raw.githubusercontent.com/Tech-187/Temp/main/pm%20stuff"))()
local spamming = ""
local fastspamming = ""
local antipmkickv = true
local commands
commands = {
	["cmds"] = {
		name = "cmds",
		action = function()
			if settingsTable.firsttimenotification then
				settingsTable.firsttimenotification = false
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Commands printed!",
					Text = "Press F9 or type /console in the chat to see the commands."
				})
			end
			print("Kohls+ Commands List")
			for i, v in commands do
				if v.name ~= "cmds" and v.name ~= "test" then
					if v.aliases then
						local function getalia_()
							local aliases = ""
							local exist = #v.aliases
							local done = 0
							for a, b in v.aliases do
								if exist == done then
									done = 0
									aliases = aliases..b.."."
								elseif exist > done then
									done += 1
									aliases = aliases..b..", "
								end
							end
							return aliases
						end
						print(v.name.." - "..v.desc.." - Aliases: "..getalia_())
					else
						print(v.name.." - "..v.desc)
					end
				end
			end
		end,
		desc = "",
		aliases = {"commands"}
	},
	["test"] = {
		name = "test",
		action = function()
			print("test")
		end,
		desc = "Hello :)"
	},
	["ban"] = {
		name = "ban",
		action = function(who: string)
			if not who then
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Error",
					Text = "Please specify a player"
				})
				return
			end
			if settingsTable.banned[GetPlayer(who)] then
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Error",
					Text = "Player is already banned"
				})
				return
			end
			if GetPlayer(who) ~= game:GetService("Players").LocalPlayer then
				run("pm "..GetPlayer(who).Name.." You have been banned.")
				table.insert(settingsTable.banned, GetPlayer(who).UserId)
			else
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Huh?",
					Text = "Why are you trying to ban yourself?"
				})
			end
		end,
		desc = "Makes the player unable to join the server until unbanned."
	},
	["unban"] = {
		name = "unban",
		action = function(who : string)
			if not who then
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Error",
					Text = "Please specify a player"
				})
				return
			end
			if GetPlayer(who) ~= game:GetService("Players").LocalPlayer and settingsTable.banned[GetPlayer(who)] then
				run("respawn "..GetPlayer(who).Name)
				run("pm "..GetPlayer(who).Name.." You have been unbanned 🙂")
				settingsTable.banned[GetPlayer(who).UserId] = nil
			else
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Cannot unban player",
					Text = "This player isn't banned or she/he is blacklisted by the owner."
				})
			end
		end,
		desc = "Opposite of "..settingsTable.prefix.."ban"
	},
	["kick"] = {
		name = "kick",
		action = function(who : string)
			if not who then
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Error",
					Text = "Please specify a player"
				})
				return
			end
			if GetPlayer(who) ~= game:GetService("Players").LocalPlayer then
				local plr = GetPlayer(who)
				local name = plr.Name
				run("pm "..who.." You have been kicked via Kohls+")
				settingsTable.connections["Kick"..name] = plr.CharacterAdded:Connect(function()
					repeat
						run("punish "..name)
						run("explode "..name)
						run("name "..name.." Dangerous creature")
						task.wait()
					until game:GetService("Lighting"):FindFirstChild(plr.Name)
				end)
				run("punish "..name)
				run("explode "..name)
				run("name "..name.." Dangerous creature")
				task.defer(function()
					while task.wait() do -- cba to use .PlayerRemoving
						if not game:GetService("Players"):FindFirstChild(name) then
							settingsTable.connections["Kick"..name]:Disconnect()
							break
						end
					end
				end)
			elseif settingsTable.banned[GetPlayer(who)] or settingsTable.no[GetPlayer(who)] then
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Error",
					Text = "Cannot kick a banned player."
				})
			end
		end,
		desc = "Makes the player unable to respawn until they rejoin."
	},
	["rj"] = {
		name = "rejoin",
		action = function()
			game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game:GetService("Players").LocalPlayer)
		end,
		desc = "Rejoins the server",
		aliases = {"rj"}
	},
	["shop"] = {
		name = "serverhop",
		action = function()
			if identifyexecutor():find("Solara") then
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Bad executor",
					Text = "Can't run this command, please use a different executor."
				})
				return "Failed"
			end
			local httprequest = http and http.request or http_request or request or function()
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Bad executor",
					Text = "Can't run this command, please use a different executor."
				})
				return "Failed"
			end
			local servers = {}
			local req = httprequest({Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", PlaceId)})
			local body = game:GetService("HttpService"):JSONDecode(req.Body)

			if body and body.data then
				for i, v in next, body.data do
					if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= game.JobId then
						table.insert(servers, 1, v.id)
					end
				end
			end

			if #servers > 0 then
				game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], game:GetService("Players").LocalPlayer)
			else
				return game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "No other server",
					Text = "This is the only server at the moment, please try again later."
				})
			end
		end,
		desc = "Joins another server",
		aliases = {"shop"}
	},
	["perm"] = {
		name = "perm",
		action = function()
			if game:GetService("MarketplaceService"):PlayerOwnsAsset(game:GetService("Players").LocalPlayer, 66254) then
				return game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "You already have Perm",
					Text = "Can't disable Perm because you own the gamepass."
				})
			end
			settingsTable.perm = not settingsTable.perm
		end,
		desc = "Gives you permanent admin pad (Use this command to toggle Perm)",
	},
	["shutdown"] = {
		name = "shutdown",
		action = function(method : string?)
			if method and method:lower() == "vg" or not method then
				if game:GetService("Players").LocalPlayer.Character.Parent ~= workspace then
					return game:GetService("StarterGui"):SetCore("SendNotification", {
						Title = "Error",
						Text = "Cannot crash while punished, please use \"-shutdown dog\" to crash."
					})
				end
				run("gear me 94794847")
				repeat task.wait() until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("VampireVanquisher")
				game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("VampireVanquisher").Parent = game:GetService("Players").LocalPlayer.Character
				for i = 1, 3 do
					run("unsize me me me")
					task.wait()
				end
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("VampireVanquisher") then
					game:GetService("StarterGui"):SetCore("SendNotification", {
						Title = "Success",
						Text = "Crashed server"
					})
				else
					game:GetService("StarterGui"):SetCore("SendNotification", {
						Title = "Failed",
						Text = "Failed to crash server, anticrash is possibly enabled"
					})
				end
			elseif method == "dog" then
				for i = 1, 512 do
					run("dog all all all")
					run("clone all all all")
				end
			end
		end,
		desc = "Shutdowns/crashes the server you are on.",
		aliases = {"crash", "stopserver"}
	},
	["kick2"] = {
		name = "seedkick",
		action = function(target: string)
			if not target then
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Error",
					Text = "Please specify a player"
				})
				return
			end
			if GetPlayer(target) == game:GetService("Players").LocalPlayer then
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Error",
					Text = "Cannot kick yourself"
				})
				return
			end
			-- not mine (made by digitality)
			run("blind "..GetPlayer(target))
			run("walkspeed "..GetPlayer(target).Name.." 0")
			local kicked = false
			task.wait()
			game:GetService("Players").LocalPlayer.Character:PivotTo(GetPlayer(target).Character:GetPivot())
			task.wait(.3)
			task.defer(function()
				for _, v in game:GetService("Players").LocalPlayer:FindFirstChildOfClass("Backpack"):GetChildren() do
					if v.Name == "BitePlant" then v.Parent = game:GetService("Players").LocalPlayer.Character
					task.wait(0)
					v:Activate() end
				end 
			end)
			run("punish me")
			task.wait(.5)
			run("unpunish me")
			kicked = true
		end,
		desc = "Another way of kicking, you need to spam \"gear me 1645056094\""
	},
	["nok"] = {
		name = "nok",
		action = function()
			for i, v in workspace.Terrain._Game.Workspace.Obby:GetDescendants() do
				if v:IsA("TouchTransmitter") then
					v:Destroy()
				end
			end
		end,
		desc = "Makes you immune to obby killbricks. *Stays until you rejoin*",
		aliases = {"noobbykill"}
	},
	["pmkick"] = {
		name = "pmkick",
		action = function(target: string)
			if not target or not GetPlayer(target) then
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Error",
					Text = "Please specify a player"
				})
				return
			end
			if GetPlayer(target) == game:GetService("Players").LocalPlayer then
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Error",
					Text = "Cannot kick yourself"
				})
				return
			end
			running = true
			task.defer(function() repeat task.wait() until not GetPlayer(target) running = false end)
			local player = GetPlayer(target).Name
			-- This message is logged from SCV3-Var so credits to Tech (SCV3-Var developer)
			recursive_loop(function()
				run("pm "..player.." "..shared.pmstuff2)
			end)
		end,
		desc = "Crashes the player via private messages."
	},
	["antifling"] = {
		name = "antifling",
		action = function()
			shared.antifling = not shared.antifling
		end,
		desc = "Prevents you from being flinged. (Use this command to toggle Anti-fling)"
	},
	["antipmkick"] = {
		name = "antipmkick",
		action = function()
			antipmkickv = not antipmkickv
		end,
		desc = "Prevents you from being crashed via pmkick (Use this command to toggle Anti PM-Kick)"
	},
	["punish2"] = {
		name = "punish2",
		action = function(target: string)
			run("gear me 139578207")
			repeat task.wait() until game.Players.LocalPlayer.Backpack:FindFirstChild("TriLaserGun")
			task.wait()
			game.Players.LocalPlayer.Backpack:FindFirstChild("TriLaserGun").Parent = game.Players.LocalPlayer.Character
			local removed = false
			local kahcon
			local kahcon2
			local TargetPlayer = GetPlayer(target)
			if not TargetPlayer or TargetPlayer == game:GetService("Players").LocalPlayer then
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Error",
					Text = "Please specify a valid player"
				})
				kahcon, kahcon2, TargetPlayer, removed = nil, nil, nil, true
				return
			end
			local name = TargetPlayer.Name
			kahcon = workspace.ChildAdded:Connect(function(v)
				if v.Name == "Effect" then
					task.defer(function()
						repeat 
							task.wait() 
							firetouchinterestc(v, TargetPlayer.Character.HumanoidRootPart)
							firetouchinterestc(v, TargetPlayer.Character.HumanoidRootPart)
						until v.Parent ~= workspace or removed or not kahcon
					end)
				end
			end)
			kahcon2 = TargetPlayer.Character.HumanoidRootPart.ChildAdded:Connect(function(Child)
				if Child.Name == "SelectionBox" and not removed then
					removed = true
					task.wait(.4)
					run("punish "..name)
				end
			end)
			game.Players.LocalPlayer.Character.TriLaserGun.Click:FireServer(TargetPlayer.Character.HumanoidRootPart.Position)
			repeat task.wait() until removed


			kahcon:Disconnect()
			kahcon2:Disconnect()
		end,
		desc = "Alternate punish. Makes the player unable to respawn. Sometimes fails"
	},
	["stop"] = {
		name = "stop",
		action = function()
			running = false
			spamming = ""
			fastspamming = ""
		end,
		desc = "Stops spamming commands (exclusions: kick, ban)"
	},
	["spam"] = {
		name = "spam",
		action = function(command: string)
			if not command then
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Error",
					Text = "No command provided"
				})
				return
			end
			spamming = command
		end,
		desc = "Spams the command that you want to."
	},
	["fastspam"] = {
		name = "fastspam",
		action = function(command: string)
			if not command then
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Error",
					Text = "No command provided"
				})
				return
			end
			fastspamming = command
		end,
		desc = "Spams the command that you want to but faster."
	},
	["prefix"] = {
		name = "prefix",
		action = function(command: string)
			if not command then
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Error",
					Text = "No prefix provided"
				})
				return
			end
			settingsTable.prefix = command
		end,
		desc = "Changes your command prefix."
	}
}
game:GetService("Players").LocalPlayer.Chatted:Connect(function(msg)
	local user = msg:split(" ")
	for i, v in commands do
		if msg:find(settingsTable.prefix..v.name) and user[2] and msg:match(settingsTable.prefix.."fastspam") then
			fastspamming = msg:sub(11)
		elseif msg:find(settingsTable.prefix..v.name) and user[2] and msg:match(settingsTable.prefix.."spam") then
			fastspamming = msg:sub(7)
		elseif msg:find(settingsTable.prefix..v.name) and user[2] then
			v.action(user[2])
		elseif msg:find(settingsTable.prefix..v.name) and not user[2] then
			v.action()
		end
	end
end)
local function antirkick(character)
	character.ChildAdded:Connect(function(rocket)
		if rocket.Name == "Rocket" then
			task.wait(.3)
			rocket:Destroy()
		end
	end)
end
for i, v in game:FindService("Players"):GetPlayers() do
	antirkick(v.Character)
	v.CharacterAdded:Connect(antirkick)
end
game:GetService("Players").PlayerAdded:Connect(function(v)
	antirkick(v.Character)
	v.CharacterAdded:Connect(antirkick)
end)

local assets = workspace:FindFirstChildOfClass("Terrain"):WaitForChild("_Game")
local pads = assets:WaitForChild("Admin"):WaitForChild("Pads")

game:GetService("RunService").Heartbeat:Connect(function(dt)
	for i, v in game:GetService("Players"):GetPlayers() do
		if settingsTable.banned[v.UserId] or settingsTable.no[v.Name] and v.Character.Parent and not v.Character.Parent:IsA("Lighting") then
			local name = v.Name
			run("explode "..name)
			run("punish "..name)
			run("name "..name.." Dangerous creature")
		end
	end
end)
game:GetService("RunService").Heartbeat:Connect(function(dt)
	if game:FindService("Players").LocalPlayer.PlayerGui:FindFirstChild("EFFECTGUIBLIND") then
		game:FindService("Players").LocalPlayer.PlayerGui:FindFirstChild("EFFECTGUIBLIND"):Destroy()
	end
end)
game:GetService("RunService").Heartbeat:Connect(function(dt)
	for i, v in game:FindService("Players"):GetPlayers() do
		if v.Character:FindFirstChild("Rocket") then
			task.wait(.2)
			v.Character.Rocket:Destroy()
		end
	end
end)
game:GetService("RunService").Heartbeat:Connect(function(dt)
	if settingsTable.perm then
		if not pads:FindFirstChild(game.Players.LocalPlayer.Name.."'s admin") and pads:FindFirstChild("Touch to get admin") then
			pcall(function()
				firetouchinterestc(pads:FindFirstChild("Touch to get admin").Head, game.Players.LocalPlayer.Character.Torso, 1337)
			end)
		end
	end
end)
game:GetService("StarterGui"):SetCore("SendNotification", {
	Title = "Welcome to Kohls+",
	Text = "Script loaded successfully"
})
game:GetService("StarterGui"):SetCore("SendNotification", {
	Title = "Aliases disabled",
	Text = "Aliases are temporarily disabled because they were broken."
})

-- Other Loops
spawn(function()
	recursive_loop1(function()
		if fastspamming ~= "" then
			run(fastspamming)
		end
	end)
end)

game:GetService("RunService").Heartbeat:Connect(function(dt)
	if spamming ~= "" then
		run(spamming)
	end
end)
