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
	no = {},
	actor_missing = false
}

local function run(message)
	game:GetService("Players"):Chat(message)
end

if not game:GetService("RunService"):IsStudio() then
	assert(game:GetService("HttpService"):JSONDecode(request({Url = "https://raw.githubusercontent.com/trollfacenan/random-kah-scripts/main/run.json", Method = "GET"}).Body).works, "Kohls+ is under maintenance, please try again later.")
	if KohlsPlus then
		return
	end
	getgenv().KohlsPlus = true
	getgenv().syn = nil
	if not run_on_actor then
		-- obsolete
		script.Parent = Instance.new("Actor")
		settingsTable.actor_missing = true
	end
end

local firetouchinterestc = function(part, touchedby, idk) -- idk if this works but it should
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
		action = function(who : string)
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
				table.insert(settingsTable.banned, GetPlayer(who))
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
				settingsTable.banned[GetPlayer(who)] = nil
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
			local httprequest = http and http.request or http_request or request
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
		desc = "Gives you permanent admin pad (to toggle use this command.)",
	},
	["shutdown"] = {
		name = "shutdown",
		action = function(method : string?)
			-- only vg ATM, more methods later
			if method and method:lower() == "vg" or not method then
				if game:GetService("Players").LocalPlayer.Character.Parent ~= workspace then
					return game:GetService("StarterGui"):SetCore("SendNotification", {
						Title = "Error",
						Text = "Cannot crash while punished, try another method. For methods, use -methods"
					})
				end
				run("gear me 94794847")
				repeat task.wait() until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("VampireVanquisher")
				game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("VampireVanquisher").Parent = game:GetService("Players").LocalPlayer.Character
				task.wait()
				run("unsize me me me")
				task.wait()
				run("unsize me me me")
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
			run("freeze "..GetPlayer(target).Name)
			task.wait()
			game:GetService("Players").LocalPlayer.Character:PivotTo(GetPlayer(target).Character:GetPivot())
			for i = 1, 100 do
				run("gear me 1645056094")
			end
			for _, v in game:GetService("Players").LocalPlayer:FindFirstChildOfClass("Backpack"):GetChildren() do
				v.Parent = game:GetService("Players").LocalPlayer.Character
				task.wait()
				v:Activate()
			end
			run("punish me")
			task.wait(.3)
			run("unpunish me")
		end,
		desc = "A better way of kicking"
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
		desc = "Makes you immune to obby killbricks. *Can't be disabled until you rejoin*",
		aliases = {"noobbykill"}
	}
}
game:GetService("Players").LocalPlayer.Chatted:Connect(function(msg)
	local user = msg:split(" ")
	for i, v in commands do
		if msg:find(settingsTable.prefix..v.name) and user[2] then
			v.action(user[2])
		elseif msg:find(settingsTable.prefix..v.name) and not user[2] then
			v.action()
		end
	end
end)

local assets = workspace:FindFirstChildOfClass("Terrain"):WaitForChild("_Game")
local pads = assets:WaitForChild("Admin"):WaitForChild("Pads")

if settingsTable.actor_missing then -- this was meant to be used for ConnectParallel but there are some limitations that made those functions not work
	game:GetService("RunService").Heartbeat:Connect(function(dt)
		for i, v in settingsTable.banned do
			if v.Parent and not v.Parent:IsA("Lighting") then
				local name = v.Name
				run("punish "..name)
				run("explode "..name)
				run("name "..name.." Dangerous creature")
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
else
	-- run_on_actor was meant to be used for ConnectParallel but there are some limitations that made those functions not work
	run_on_actor(function()
		game:GetService("RunService").Heartbeat:Connect(function(dt)
			for i, v in settingsTable.banned do
				if v.Parent and v.Parent.Name ~= "Lighting" then
					local name = v.Name
					run("punish "..name)
					run("explode "..name)
					run("name "..name.." Dangerous creature")
				end
			end
		end)
	end)
	run_on_actor(function()
		game:GetService("RunService").Heartbeat:Connect(function(dt)
			if settingsTable.perm then
				if not pads:FindFirstChild(game.Players.LocalPlayer.Name.."'s admin") and pads:FindFirstChild("Touch to get admin") then
					pcall(function()
						firetouchinterestc(pads:FindFirstChild("Touch to get admin").Head, game.Players.LocalPlayer.Character.Torso, 1337)
					end)
				end
			end
		end)
	end)
end
game:GetService("StarterGui"):SetCore("SendNotification", {
	Title = "Welcome to Kohls+",
	Text = "Script loaded successfully"
})
game:GetService("StarterGui"):SetCore("SendNotification", {
	Title = "Aliases disabled",
	Text = "Aliases are temporarily disabled because they were broken."
})
