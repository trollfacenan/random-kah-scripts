loadstring(game:HttpGet("https://raw.githubusercontent.com/Amourousity/Conversio/main/source.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Amourousity/Utilitas/main/source.lua"))()

local t = os.time()
local function GetPlayer(text)
	for _,Player in game:GetService("Players"):GetPlayers() do
		if string.sub(string.lower(Player.Name),1,string.len(text)) == string.lower(text) then
			return Player
		end
	end
end
local settingsTable = {
	perm = not game:GetService("MarketplaceService"):UserOwnsGamePassAsync(game:GetService("Players").LocalPlayer.UserId, 66254), -- this is not the gamepass checker, it's for the pad grabber
	prefix = "-",
	firsttimenotification = true,
	banned = {},
	connections = {},
	no = {"Not_Wojtek"},
	antivg = true
}
local startupcommands = {
	"nok",
	"iy"
}
if KohlsPlus then
	return
end

if not game:GetService("RunService"):IsStudio() then
	assert(game:GetService("HttpService"):JSONDecode(request({Url = "https://raw.githubusercontent.com/trollfacenan/random-kah-scripts/main/run.json", Method = "GET"}).Body).works, "Kohls+ is under maintenance, please try again later.")
	getgenv().KohlsPlus = true
	getgenv().syn = nil
end

local function run(message)
	game:GetService("Players"):Chat(message)
end

task.defer(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/trollfacenan/random-kah-scripts/main/AntiFling.lua"))() end)
local isFluxus = identifyexecutor():find("Fluxus")
local recursive_loop
local running = false
recursive_loop = function(func, ...)
	if isFluxus then
		return task.defer(function(...)
			while task.wait() do
				if ... then
					func(...) else
					func()
				end
				task.wait()
			end
		end)
	end
	if running then task.desynchronize()
		task.defer(recursive_loop, func, ...)
		task.synchronize()
		func(...) end
end
local recursive_loop1
recursive_loop1 = function(func, ...)
	if isFluxus then
		return task.defer(function(...)
			while task.wait() do
				if ... then
					func(...) else
					func()
				end
			end
		end)
	end
	task.desynchronize()
	task.defer(recursive_loop1, func, ...)
	task.synchronize()
	func(...)
end
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
				settingsTable.banned[GetPlayer(who).UserId] = nil
				run("respawn "..GetPlayer(who).Name)
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
		name = "lock",
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
				run("pm "..who.." You have been locked from this server\nPlease join another server")
				settingsTable.connections["Kick"..name] = plr.CharacterAdded:Connect(function()
					settingsTable.connections["_Kick"..name]:Disconnect()
					repeat
						run("punish "..name)
						run("blind "..name)
						task.wait()
					until game:GetService("Lighting"):FindFirstChild(plr.Name)
					settingsTable.connections["_Kick"..name] = plr.Character.AncestryChanged:Connect(function(newparent)
						if newparent ~= game:GetService("Lighting") or newparent ~= nil then repeat
								run("punish "..name)
								run("blind "..name)
								task.wait()
							until not plr or game:GetService("Lighting"):FindFirstChild(plr.Name) end
					end)
				end)
				settingsTable.connections["_Kick"..name] = plr.Character.AncestryChanged:Connect(function(newparent)
					if newparent ~= game:GetService("Lighting") or newparent ~= nil then repeat
							run("punish "..name)
							run("blind "..name)
							task.wait()
						until not plr or game:GetService("Lighting"):FindFirstChild(plr.Name) end
				end)
				run("punish "..name)
				run("blind "..name)
				task.defer(function()
					while task.wait() do -- cba to use .PlayerRemoving
						if not game:GetService("Players"):FindFirstChild(name) then
							settingsTable.connections["Kick"..name]:Disconnect()
							settingsTable.connections["_Kick"..name]:Disconnect()
							break
						end
					end
				end)
			elseif settingsTable.banned[GetPlayer(who).UserId] or settingsTable.no[GetPlayer(who).UserId] then
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
			local req = httprequest({Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", game.PlaceId)})
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
			if settingsTable.perm then
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
				task.defer(function()
					while task.wait() do
						run("unsize me me me")
					end
				end)
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
				for i = 1, 52 do
					run("dog all all all						fuck")
				end
				for i = 1, 51 do
					run("clone all all all						fuck")
				end
				while task.wait() do
					run("clone all all all						fuck")
				end	
			elseif method == "blind" then
				run("brightness -nan")
				run("fogend 0 fuck")
				run("blind others fuck")
				run("time -")
				task.wait(.5)
				for i = 1, 52 do
					run("dog all all all						fuck")
				end
				for i = 1, 51 do
					run("clone all all all						fuck")
				end
				while task.wait() do
					run("clone all all all						fuck")
				end
			elseif method == "test" then
				-- Purge Premium (real!!!!!!!1!!11!! 2024 no hack)
				task.defer(function()
					task.wait(3)
					run("size all 2")
					run("setgrav all 3500")
				end)
				while task.wait() do
					run("dog all all all										fuck")
					task.wait()
					run("name all "..math.random())
					task.wait()
					run("clone all all all										fuck")
					task.wait()
					run("tp all all													fuck")
					task.wait()
					run("stand all all all											fuck")
				end
			end
		end,
		desc = "Shutdowns/crashes the server you are on.",
		aliases = {"crash", "stopserver"}
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
	["antifling"] = {
		name = "antifling",
		action = function()
			shared.antifling = not shared.antifling
		end,
		desc = "Prevents you from being flinged. (Use this command to toggle Anti-fling)"
	},
	["punish2"] = {
		name = "punish2",
		action = function(target: string)
			run("respawn "..target)
			task.wait()
			for i = 1, 20 do
				run("gear me 139578207")
			end
			repeat task.wait() until #game.Players.LocalPlayer.Backpack:GetChildren() > 6
			task.wait()
			for i, v in game:GetService("Players").LocalPlayer.Backpack:GetChildren() do
				if v.Name == "TriLaserGun" then
					v.Parent = game:GetService("Players").LocalPlayer.Character
				end
			end
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
							firetouchinterestc(v, TargetPlayer.Character.HumanoidRootPart, 0)
							firetouchinterestc(v, TargetPlayer.Character.HumanoidRootPart, 1)
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
			for i, v in game:GetService("Players").LocalPlayer.Character:GetChildren() do
				if v.Name == "TriLaserGun" then
					pcall(function()
						v:WaitForChild("Click"):FireServer(TargetPlayer.Character.HumanoidRootPart.Position)
					end)	
				end
			end
			task.defer(function() repeat task.wait() until removed


				kahcon:Disconnect()
				kahcon2:Disconnect() end)
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
		desc = "Stops spamming commands"
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
	},
	["rkick"] = {
		name = "rkick",
		action = function(user: string)
			if not game:GetService("MarketplaceService"):UserOwnsGamePassAsync(game:GetService("Players").LocalPlayer.UserId, 35748) then
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Error",
					Text = "P299 admin not found. This command is unavailable for you."
				})
				return
			end
			if not user or not GetPlayer(user) then
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Error",
					Text = "No player/invalid player specified."
				})
				return
			end
			local u = GetPlayer(user)
			run("respawn "..u.Name.." fuck																			")
			task.wait(.1)
			run("jail/"..u.Name)
			task.spawn(function()
				while spamming and u ~= nil do
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = (u.Character.HumanoidRootPart.CFrame * CFrame.Angles(0,math.rad(180),0)*CFrame.new(0,0,-2))
					run("rocket/me/"..u.Name.."/me/"..u.Name)
					task.wait(0.125)
				end
			end)
		end,
		desc = "Kicks someone using rockets. P299 required"
	},
	["lagall"] = {
		name = "templagall",
		action = function()
			if #game:GetService("Players"):GetPlayers() < 4 then
				return game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Error",
					Text = "Insufficient amount of players (min. 4)"
				})
			end
			task.spawn(function()
				running = true
				while task.wait() do
					run("respawn all all all")
					if not running then break end
				end
			end)
			task.wait(10)
			game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game:GetService("Players").LocalPlayer)
		end,
		desc = "Temporarily lags everyone using respawn."
	},
	["lagall2"] = {
		name = "lagall",
		action = function()
			local loop_dogs = {}
			local stopped = false
			task.defer(function()
				task.wait(40)
				stopped = true
				run("fix")
			end)
			task.spawn(function()
				run("brightness -nan")
				run("fogend 0 fuck")
				run("blind others fuck")
				run("time -")
				for i = 1, 52 do
					run("dog all all all									fuck")
				end
				for i, v in game:GetService("Players"):GetPlayers() do
					loop_dogs[#loop_dogs + 1] = v.CharacterAdded:Connect(function()
						if not stopped then
							for i, v in loop_dogs do
								pcall(function()
									v:Disable()
								end)
							end
						end
						for i = 1, 52 do
							run("dog "..v.Name.."									fuck")
						end
					end)
				end
				loop_dogs[#loop_dogs + 1] = game:GetService("Players").PlayerAdded:Connect(function(v)
					loop_dogs[#loop_dogs + 1] = v.CharacterAdded:Connect(function()
						if not stopped then
							for i, v in loop_dogs do
								pcall(function()
									v:Disable()
								end)
							end
						end
						for i = 1, 52 do
							run("dog "..v.Name.."									fuck")
						end
					end)
					if running then
						for i = 1, 52 do
							run("dog "..v.Name.."									fuck")
						end
					end
				end)
			end)
			task.spawn(function()
				while task.wait() do
					if stopped then break end
					run("tp all all all									fuck")
					task.wait()
					run("stand all all all								fuck")
					if stopped then break end
				end
			end)
		end,
		desc = "Similar to purge in SCV3-VAR. Stops after 40 seconds"
	},
	["aa"] = {
		name = "iy",
		action = function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
		end,
		desc = "Loads Infinite Yield"
	},
	["breakserver"] = {
		name = "breakserver",
		action = function()
			run("gear all 000000000000000000000000000000004842204072")
			run("blind all fuck")
			run("brightness -nan")
			run("time -")
			run("gear all 00000000000000000000000000000000253519495")
			run("ungear all all all fuck")
			run("gear all 00000000000000000000000000000000253519495")
			run("punish all fuck")
			run("trip others fuck")
			run("setgrav others -inf")
			run("speed others 000000000000000000000")
			run("unpunish me fuck")
			run("unpunish me fuck")
			run("gear all 00000000000000000000000000000000253519495")
			task.spawn(function()
				for i = 1, 999 do
					run("gear all 00000000000000000000000000000000253519495")
					task.wait(.225)
				end
			end)
			run(settingsTable.prefix.."fixcam")
		end,
		desc = "Makes the server unplayable for some time."
	},
	["breakserve"] = {
		name = "breakcam",
		action = function()
			run("gear all 000000000000000000000000000000004842204072")
			task.wait(.4)
			run("ungear all")
		end,
		desc = "Prevents everyone from moving their camera"	
	},
	["fixcam"] = {
		name = "fixcam",
		action = function()
			-- i don't know who made this but this isn't mine!
			task.spawn(function()
				local lp = game.Players.LocalPlayer
				local ui = game:GetService("UserInputService")
				local l__ContextActionService__7 = game:GetService("ContextActionService");
				local l__RunService__1 = game:GetService('RunService')
				l__ContextActionService__7:UnbindAction("ShoulderCameraSprint");
				l__RunService__1:UnbindFromRenderStep("ShoulderCameraUpdate");
				l__ContextActionService__7:UnbindAction("ShoulderCameraZoom");
				while true do
					repeat game:GetService'RunService'.Heartbeat:Wait() until game.Workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable
					l__RunService__1:UnbindFromRenderStep("ShoulderCameraUpdate");
					l__ContextActionService__7:UnbindAction("ShoulderCameraZoom");
					l__ContextActionService__7:UnbindAction("ShoulderCameraSprint");
					local wepsys = game:GetService("ReplicatedStorage"):FindFirstChild('WeaponsSystem')
					if not wepsys then return end
					for i,v in pairs(wepsys:GetDescendants()) do
						if v:IsA("Script") then
							v.Disabled = true
						end
						v:Destroy()
					end
					local wep = lp.PlayerGui:FindFirstChild("ClientWeaponsScript")
					local gui = lp.PlayerGui:FindFirstChild("WeaponsSystemGui")
					local sc = lp.PlayerScripts:FindFirstChild("ClientWeaponsScript")
					if wep then wep.Disabled = true wep:Destroy() end
					if gui then gui:Destroy() end
					if sc then
						sc.Disabled = true
						sc:Destroy()
					end
					ui.MouseIconEnabled = true
					game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
					game.Workspace.CurrentCamera.CameraSubject = lp.Character.Humanoid
					lp.Character.Humanoid.AutoRotate = true
				end
			end)
		end,
		desc = "Undoes "..settingsTable.prefix.."breakcam *Clientsided*"
	},
	["emergency"] = {
		name = "emr",
		action = function()
			local function whatihas()
				local MarketplaceService = game:GetService("MarketplaceService")
				local Players = game:GetService("Players")
				local LocalPlayer = Players.LocalPlayer
				local gameFlr = workspace.Terrain._Game
				local adminFlr = gameFlr.Admin
				local pc1 = (MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 35748) or MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 37127))
				local pc2 = (MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 66254) or MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 64354))
				if pc1 and pc2 then
					task.spawn(function()
						for i = 1, 256 do
							run("respawn random													fuck")
							for i = 1, 32 do
								run("shield/all all all										fuck")
							end
							task.wait(.345)
							for i = 1, 32 do
								run("rocket/all all all										fuck")
							end
							task.wait(.345)
							for i = 1, 32 do
								run("gear all 94794847										fuck")
							end
							task.wait(.345)
							for i = 1, 32 do
								run("gear all 4842204072										fuck")
							end
							task.wait(.345)
							for i = 1, 32 do
								run("gear all 00000000000000000000000000000000253519495										fuck")
							end
							task.wait()
							for i = 1, 32 do
								run("clone all all all										fuck")
							end
							task.wait(.22)
							for i = 1, 32 do
								run("gear all 94794847										fuck")
							end
							task.wait(.1)
							for i, v in game:GetService("Players").LocalPlayer.Backpack:GetChildren() do
								v.Parent = game:GetService("Players").LocalPlayer.Character
							end
						end
						game:GetService("StarterGui"):SetCore("SendNotification", {
							Title = "Success",
							Text = "Game has been successfully crashed"
						})
					end)
				elseif pc1 and not pc2 then
					task.spawn(function()
						game:GetService("StarterGui"):SetCore("SendNotification", {
							Title = "Emergency crash",
							Text = "Possibly crashed the server. If it didn't crash then the server is just unplayable."
						})
						for i = 1, 256 do
							for i = 1, 32 do
								run("shield/all all all									fuck")
							end
							task.wait(.225)
							for i = 1, 32 do
								run("rocket/all all all									fuck")
							end
							task.wait(.225)
							for i = 1, 32 do
								run("part/1/1/1									fuck")
							end
							task.wait(.225)
							for i = 1, 32 do
								run("h/Leave this server lol.")
							end
							task.wait(.225)
							for i = 1, 32 do
								run("part/10/10/10									fuck")
							end
							task.wait(.225)
							if adminFlr.Pads:FindFirstChild(game:GetService("Players").LocalPlayer.."'s admin") then
								run("respawn random													fuck")
								for i = 1, 32 do
									run("gear all 94794847										fuck")
								end
								task.wait(.345)
								for i = 1, 32 do
									run("gear all 4842204072										fuck")
								end
								task.wait(.345)
								for i = 1, 32 do
									run("gear all 00000000000000000000000000000000253519495										fuck")
								end
								task.wait()
								for i = 1, 32 do
									run("clone all all all										fuck")
								end
								task.wait(.22)
								for i = 1, 32 do
									run("gear all 94794847										fuck")
								end
								task.wait(.1)
								for i, v in game:GetService("Players").LocalPlayer.Backpack:GetChildren() do
									v.Parent = game:GetService("Players").LocalPlayer.Character
								end
							end
						end
					end)
				elseif not pc1 and pc2 then
					-- bad crash
					task.spawn(function()
						game:GetService("StarterGui"):SetCore("SendNotification", {
							Title = "Emergency crash",
							Text = "The server won't crash although there will be huge lagspikes."
						})
						for i = 1, 999 do
							for i = 1, 5 do
								run("gear all 94794847										fuck")
							end
							task.wait(.214)
							for i = 1, 5 do
								run("gear all 4842204072										fuck")
							end
							task.wait(.198)
							for i = 1, 5 do
								run("gear all 00000000000000000000000000000000253519495										fuck")
							end
						end
					end)
				end
			end
			whatihas()
		end,
		desc = "Alternate way to crash the server if -shutdown fails (P299 or Perm required)"
	},
	["emergency2"] = {
		name = "carlag",
		action = function()
			local function whatihas()
				task.spawn(function()
					run("gear all 4842204072										fuck")
					run("respawn random random random									fuck")
					while task.wait() do
						settingsTable.perm = true
						settingsTable.antivg = false
						run("gear all 00000000000000000000000000000000253519495										fuck")
						task.wait()
						run("gear all 94794847										fuck")
					end
				end)
			end
			whatihas()
		end,
		desc = settingsTable.prefix.."emr without Perm or P299"
	},
	["safelogs"] = {
		name = "safelogs",
		action = function()
			run("logs aaee me fuck											")
		end,
		desc = "Bypasses antilogs if someone has it"
	},
	["safelogs2"] = {
		name = "listen",
		action = function()
			run("logs			 me fuck											")
		end,
		desc = "If someone has a safelogs detector then use this"
	}
}
game:GetService("Players").LocalPlayer.Chatted:Connect(function(msg)
	local user = msg:split(" ")
	for i, v in commands do
		if msg:find(settingsTable.prefix..v.name) and user[2] and msg:match(settingsTable.prefix.."fastspam") then
			fastspamming = msg:sub(11)
		elseif msg:find(settingsTable.prefix..v.name) and user[2] and msg:match(settingsTable.prefix.."spam") then
			spamming = msg:sub(7)
		elseif msg:match(settingsTable.prefix..v.name) or v.aliases and v.aliases[msg] ~= nil and user[2] then
			v.action(user[2])
		elseif msg:match(settingsTable.prefix..v.name) or v.aliases and v.aliases[msg] ~= nil and not user[2] then
			v.action()
		end
	end
end)
for i, v in startupcommands do
	run(settingsTable.prefix..v)
end
local function antirkick(character)
	task.wait(.2)
	character.ChildAdded:Connect(function(rocket)
		if rocket.Name == "Rocket" then
			task.wait(.1)
			rocket:Destroy()
		end
	end)
end
for i, v in game:FindService("Players"):GetPlayers() do
	if v.Name == "9jn" or v.Name == "9gn" then
		run("blind all fuck")
		run("gear all 00000000000000000000000000000000253519495")
		run("ungear all all all fuck")
		run("gear all 00000000000000000000000000000000253519495")
		run("punish all fuck")
		run("trip others fuck")
		run("setgrav others -inf")
		run("unpunish me fuck")
		run("unpunish me fuck")
		run("gear all 00000000000000000000000000000000253519495")
		run("gear all 000000000000000000000000000000004842204072")
		task.wait(.5)
		local s, e = pcall(function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/Tech-187/Lua-scripts/main/scv3-var's%20usilcrash"))()
		end)
		if e then run("-shutdown dog") end
	end
	pcall(antirkick, v.Character)
	v.CharacterAdded:Connect(function() antirkick(v.Character) end)
end
game:GetService("Players").PlayerAdded:Connect(function(v)
	if v.Name == "9jn" or v.Name == "9gn" then
		run("blind all fuck")
		run("gear all 00000000000000000000000000000000253519495")
		run("ungear all all all fuck")
		run("gear all 00000000000000000000000000000000253519495")
		run("punish all fuck")
		run("trip others fuck")
		run("setgrav others -inf")
		run("unpunish me fuck")
		run("unpunish me fuck")
		run("gear all 00000000000000000000000000000000253519495")
		run("gear all 000000000000000000000000000000004842204072")
		task.wait(.5)
		local s, e = pcall(function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/Tech-187/Lua-scripts/main/scv3-var's%20usilcrash"))()
		end)
		if e then run("-shutdown dog") end
	end
	pcall(antirkick, v.Character)
	v.CharacterAdded:Connect(function() antirkick(v.Character) end)
end)

local assets = workspace:FindFirstChildOfClass("Terrain"):WaitForChild("_Game")
local pads = assets:WaitForChild("Admin"):WaitForChild("Pads")

game:GetService("RunService").Heartbeat:Connect(function(dt)
	for i, v in game:FindService("Players"):GetPlayers() do
		if settingsTable.antivg and (game:GetService("Players").LocalPlayer.Name ~= v.Name) and v.Character and v.Character:FindFirstChild("VampireVanquisher") or settingsTable.antivg and (game:GetService("Players").LocalPlayer.Name ~= v.Name) and v.Backpack:FindFirstChild("VampireVanquisher") then
			local name = v.Name
			run("ungear/"..name)
			run("ungear "..name)
		end
	end
	if game:FindService("Players").LocalPlayer.PlayerGui:FindFirstChild("EFFECTGUIBLIND") then
		game:FindService("Players").LocalPlayer.PlayerGui:FindFirstChild("EFFECTGUIBLIND"):Destroy()
	end
end)
game:GetService("Players").PlayerAdded:Connect(function(v)
	if settingsTable.banned[v.UserId] or settingsTable.no[v.Name] and v.Character.Parent and v.Character.Parent == workspace then
		local name = v.Name
		run("punish "..name)
		run("blind "..name)
	end
end)
for i, v in game:GetService("Players"):GetPlayers() do
	if settingsTable.banned[v.UserId] or settingsTable.no[v.Name] and v.Character.Parent and v.Character.Parent == workspace then
		local name = v.Name
		run("punish "..name)
		run("blind "..name)
	end
end

task.defer(function()
	local lp = game:GetService("Players").LocalPlayer
	local store = workspace.Terrain._Game
	local pads = store.Admin.Pads
	local regen = store.Admin:FindFirstChild("Regen")
	local pad = pads:FindFirstChild("Touch to get admin")
	if pad == nil and settingsTable.perm then
		if fireclickdetector and typeof(regen) == "Instance" then
			fireclickdetector(regen.ClickDetector, 9e9)
		end	
		repeat task.wait() until pads:FindFirstChild("Touch to get admin")
		pad = pads:FindFirstChild("Touch to get admin")
	end
	pad.Archivable = true
	task.defer(function() 
		while task.wait() do
			if settingsTable.perm and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
				if pad == nil then
					if fireclickdetector and regen then
						fireclickdetector(regen.ClickDetector, 0)
					end
					pad = pads:FindFirstChild("Touch to get admin")
				end
				task.spawn(function()
					firetouchinterest(pad.Head, game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, 1)
					firetouchinterest(pad.Head, game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, 0)
					firetouchinterest(pad.Head, game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, 1)
					task.wait()
					firetouchinterest(pad.Head, game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, 0)
				end)
			end
		end 
	end)
end)	

game:GetService("StarterGui"):SetCore("SendNotification", {
	Title = "Welcome to Kohls+",
	Text = "Script loaded successfully"
})

-- Other Loops
task.defer(function()
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
