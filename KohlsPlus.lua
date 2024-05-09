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

loadstring(game:HttpGet("https://raw.githubusercontent.com/trollfacenan/random-kah-scripts/main/AntiFling.lua"))()
task.defer(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/trollfacenan/random-kah-scripts/main/ColorAPI.lua"))()
	task.wait(.4)
	if not colorAPI then
		colorAPI = loadstring(game:HttpGet("https://raw.githubusercontent.com/trollfacenan/random-kah-scripts/main/ColorAPI.lua"))()
	end
end)

local firetouchinterestc = function(part, touchedby, idk)
	if identifyexecutor():find("Krampus") then
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

local antipmkickv = false
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
			-- only vg ATM, more methods later
			if method and method:lower() == "vg" or not method then
				if game:GetService("Players").LocalPlayer.Character.Parent ~= workspace then
					return game:GetService("StarterGui"):SetCore("SendNotification", {
						Title = "Error",
						Text = "Cannot crash while punished, please wait until there are other methods."
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
			run("walkspeed "..GetPlayer(target).Name.." 0") run("jumppower "..GetPlayer(target).Name.." 0")
			local kicked = false
			task.wait()
			game:GetService("Players").LocalPlayer.Character:PivotTo(GetPlayer(target).Character:GetPivot())
			for i = 1, 1000 do
				game:FindService("Players"):Chat("gear me 1645056094")
				task.wait()
			end
            task.wait(1.5)
			task.defer(function() 
				for _, v in game:GetService("Players").LocalPlayer:FindFirstChildOfClass("Backpack"):GetChildren() do
					v.Parent = game:GetService("Players").LocalPlayer.Character
					task.wait(0)
					v:Activate()
				end 
			end)
			task.wait(0.5)
			run("punish me")
			task.wait(1)
			run("unpunish me")
			kicked = true
		end,
		desc = "Another way of kicking, works very rarely although kicks instantly"
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
			repeat
				run("pm "..GetPlayer(target).Name.." 😁😁😂😂🤣😀😃😄😁😂😂🤣😀😃😄😁😂😂🤣😀😃😄😄😄😄😄😄😄😄😋😊😊😊😉😉😆😆😆🤨🤨😐😁😂😂🤣😀😃😄😁")
				task.wait()
			until not GetPlayer(target)
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
	["randomcolors"] = {
		name = "randomcolors",
		action = function()
			colorAPI.colorallRandom()
		end,
		desc = "Paints the map in random colors. *This may make your ping high.*"
	},
	["originalcolors"] = {
		name = "originalcolors",
		action = function()
			colorAPI.colorallOriginal()
		end,
		desc = "Returns the map to it's original colors. *This may make your ping high.*"
	},
	["antipmkick"] = {
		name = "antipmkick",
		action = function()
			antipmkickv = not antipmkickv
		end,
		desc = "Prevents you from being crashed via pmkick (Use this command to toggle Anti PM-Kick)"
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
local function antirkick(character)
	character.ChildAdded:Connect(function(rocket)
		if rocket.Name == "Rocket" then
			task.wait(.3)
			rocket:Destroy()
		end
	end)
end
local function antipmkick()
	task.wait()
	for i, v in game:GetService("Players").LocalPlayer.PlayerGui:GetChildren() do
		if v.Name == "MessageGUI" then
			task.wait()
			v:Destroy()
		end
	end
	for i, v in workspace.Terrain._Game.Folder:GetChildren() do
		if v.Name == "MessageGUI" then
			task.wait()
			v:Destroy()
		end
	end
end
for i, v in game:FindService("Players"):GetPlayers() do
	antirkick(v.Character)
	v.CharacterAdded:Connect(antirkick)
end
game:GetService("Players").PlayerAdded:Connect(function(v)
	antirkick(v.Character)
	v.CharacterAdded:Connect(antirkick)
end)
while true do
	if antipmkickv then antipmkick() end
end

local assets = workspace:FindFirstChildOfClass("Terrain"):WaitForChild("_Game")
local pads = assets:WaitForChild("Admin"):WaitForChild("Pads")

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
	if game:FindService("Players").LocalPlayer.PlayerGui:FindFirstChild("EFFECTGUIBLIND") then
		game:FindService("Players").LocalPlayer.PlayerGui:FindFirstChild("EFFECTGUIBLIND"):Destroy()
	end
end)
game:GetService("RunService").Heartbeat:Connect(function(dt)
	for i, v in game:FindService("Players"):GetPlayers() do
		if v.Character:FindFirstChild("Rocket") then
			task.wait(.2)
			v.Rocket:Destroy()
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
