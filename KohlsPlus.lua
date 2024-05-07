-- Doesn't have "others" or "all" support but I'll add that later.

local function GetPlayer(text)
	for _,Player in game:GetService("Players") do
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
	assert(game.PlaceId == 112420803, "Unsupported game")
	assert(getgenv, "Cannot load Kohls+, getgenv is missing.")
	assert(typeof(Instance.new("Part")) == "Instance", "\nUnknown error, failed to run Kohls+\nTry rejoining or try again later.")
	assert(game:GetService("HttpService"):JSONDecode(game:GetService("HttpService"):GetAsync("https://raw.githubusercontent.com/trollfacenan/random-kah-scripts/main/run.json")).works, "Kohls+ is under maintenance, please try again later.")
	if KohlsPlus then
		return
	end
	getgenv().KohlsPlus = true
	getgenv().syn = nil
	if not run_on_actor then
		script.Parent = Instance.new("Actor")
		actor_missing = true
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
			part.Archivable = true
			fakeclone = part:Clone()
			fakeclone:PivotTo(touchedby.CFrame)
			task.wait()
			fakeclone:Destroy()
		end)
	elseif part:IsA("TouchTransmitter") then
		local basepart
		repeat
			basepart = part.Parent
			task.wait()
		until basepart:IsA("BasePart")
		pcall(function()
			part.Archivable = true
			fakeclone = basepart:Clone()
			fakeclone:PivotTo(touchedby.CFrame)
			task.wait()
			fakeclone:Destroy()
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
	}
}
game:GetService("Players").LocalPlayer.Chatted:Connect(function(msg)
	local user = msg:split("")
	for i, v in commands do
		if v.aliases then
			for a, b in v.aliases do
				if msg == b and user[2] then
					v.action(user[2])
					break
				else
					v.action()
					break
				end
			end
		elseif v.name == msg and user[2] then
			v.action(user[2])
			break
		else
			v.action()
			break
		end
	end
end)

local assets = workspace:FindFirstChildOfClass("Terrain"):WaitForChild("_Game")
local pads = assets:WaitForChild("Pads")

if actor_missing then
	game:GetService("RunService").Heartbeat:ConnectParallel(function(dt)
		for i, v in settingsTable.banned do
			if v:IsDescendantOf(game) and not v.Parent:IsA("Lighting") then
				run("punish "..name)
				run("explode "..name)
				run("name "..name.." Dangerous creature")
			end
		end
	end)
	game:GetService("RunService").Heartbeat:ConnectParallel(function(dt)
		if settingsTable.perm then
			if not pads:FindFirstChild(game:GetService("Players").LocalPlayer.Name.."'s admin") and pads:FindFirstChild("Touch to get admin") then
				pcall(function()
					firetouchinterestc(pads:FindFirstChild("Touch to get admin").Head, game:GetService("Players").LocalPlayer.Character.Torso, 1337)
				end)
			end
		end
	end)
else
	run_on_actor(function()
		game:GetService("RunService").Heartbeat:ConnectParallel(function(dt)
			for i, v in settingsTable.banned do
				if v:IsDescendantOf(game) and not v.Parent:IsA("Lighting") then
					run("punish "..name)
					run("explode "..name)
					run("name "..name.." Dangerous creature")
				end
			end
		end)
	end)
	run_on_actor(function()
		game:GetService("RunService").Heartbeat:ConnectParallel(function(dt)
			if settingsTable.perm then
				if not pads:FindFirstChild(game:GetService("Players").LocalPlayer.Name.."'s admin") and pads:FindFirstChild("Touch to get admin") then
					pcall(function()
						firetouchinterestc(pads:FindFirstChild("Touch to get admin").Head, game:GetService("Players").LocalPlayer.Character.Torso, 1337)
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

-- By using this script you automatically agree to the license which can be found at https://github.com/trollfacenan/random-kah-scripts/blob/main/LICENSE
