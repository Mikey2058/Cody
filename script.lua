 local Tool = nil
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer 
local TeleportService = game:GetService("TeleportService")
local Character = LocalPlayer.Character  or LocalPlayer.CharacterAdded:Wait()
game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false) 
script.Parent:WaitForChild("MainScreenGui").Enabled = false
if script.Parent:FindFirstChild("CenterTop") then
	script.Parent:FindFirstChild("CenterTop").Enabled = false
end
spawn(function()
	game.Workspace.Terrain:Clear()
	for i, v in pairs(game.Workspace.Ignored.Animations:GetDescendants()) do
		v:Destroy()
	end
	for i, v in pairs(game.Workspace.Ignored.Debris:GetDescendants()) do
		v:Destroy()
	end
	for i, v in pairs(script.Parent:GetChildren()) do
		if v.Name == "ren" then
			v:Destroy()
		end
	end


end)
local MainModule = require(game:GetService("ReplicatedStorage").MainModule) 
LocalPlayer:WaitForChild("DataFolder",20) 
local CurrentCamera = workspace.CurrentCamera 
local Mouse = LocalPlayer:GetMouse() 
local RunService = game:GetService("RunService") 
local BodyEffects = Character:WaitForChild("BodyEffects") 
local UserInputService = game:GetService("UserInputService") 
local GamePassService = game:GetService("GamePassService")
local MarketplaceService = game:GetService("MarketplaceService")
local Inputs = {} 
local MainEvent = game:GetService("ReplicatedStorage"):WaitForChild("MainEvent")
local StarterGui = game:GetService("StarterGui") 
local MainScreenGui = LocalPlayer.PlayerGui:WaitForChild("MainScreenGui")
local Notify = script.Parent:WaitForChild("Notify")
local ContextActionService = game:GetService("ContextActionService") 
local TeleportService = game:GetService("TeleportService")
Character:WaitForChild("Humanoid", 1/0) 
Character:WaitForChild("FULLY_LOADED_CHAR", 1/0)
local SmallGunAim = Character.Humanoid:LoadAnimation(game:GetService("ReplicatedStorage").ClientAnimations.SmallGunAim) 
local SmallGunAimShot = Character.Humanoid:LoadAnimation(game:GetService("ReplicatedStorage").ClientAnimations.SmallGunAimShot) 
local SmallGunShot = Character.Humanoid:LoadAnimation(game:GetService("ReplicatedStorage").ClientAnimations.SmallGunShot) 
local Stomp = Character.Humanoid:LoadAnimation(game:GetService("ReplicatedStorage").ClientAnimations.Stomp) 
local Crouching = Character.Humanoid:LoadAnimation(game:GetService("ReplicatedStorage").ClientAnimations.Crouching)
local TweenService = game:GetService("TweenService")
local WeaponSkinsGUI = MainScreenGui:WaitForChild("WeaponSkinsGUI");
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local XenoModule = require(game.ReplicatedStorage.Modules.Xeno)
local CameraShaker = require(game.ReplicatedStorage.Modules.CameraShaker)
local CameraEffects = require(game.ReplicatedStorage.Modules.CameraEffects)
local MainGroup = 33427148
local HOFGroup = 32490899
local CanOpenCrate = true
MainScreenGui.Enabled = true
local hitmarker_val = true
if script.Parent:FindFirstChild("TopBarLeft") then
	script.Parent:FindFirstChild("TopBarLeft").Enabled = true
end


local function ClickExp()
	local CLICK_EXPLOSION = game.ReplicatedStorage.VFX.CLICK_EXPLOSION:Clone()
	CLICK_EXPLOSION.Position = UDim2.new(0, Mouse.X, 0, Mouse.Y)
	CLICK_EXPLOSION.Parent = LocalPlayer.PlayerGui.MainScreenGui
	script.Sound:Play()
	local CLICK_EXPLOSION_TWEEN = game.TweenService:Create(CLICK_EXPLOSION, TweenInfo.new(0.2), {
		Size = UDim2.new(0.019, 0, 0.039, 0), 
		Transparency = 1
	})
	CLICK_EXPLOSION_TWEEN:Play()
	CLICK_EXPLOSION_TWEEN.Completed:Connect(function()
		CLICK_EXPLOSION:Destroy()
	end)
end

local function Notification(Type, Duration, Text)
	if Type == "Success" then
		local template = Notify.Notifications.Template.Template:Clone()
		template.Parent = Notify.Notifications
		template.Title.Text = Text
		template.UIStroke.Color = Color3.new(0.215686, 1, 0)
		template.Title.TextColor3 = Color3.new(0.215686, 1, 0)
		template.Visible = true
		template.Size = UDim2.new(1, 0, 0, 0)
		TweenService:Create(template, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = UDim2.new(1, 0,0.1, 0)
		}):Play()
		script.Success:Play()
		task.delay(Duration, function()
			TweenService:Create(template, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				Size = UDim2.new(1, 0, 0, 0)
			}):Play()
			task.delay(0.2, function()
				template:Destroy()
			end)
		end)
	else
		if Type == "Error" then
			local template = Notify.Notifications.Template.Template:Clone()
			template.Parent = Notify.Notifications
			template.Title.Text = Text
			template.UIStroke.Color = Color3.new(1, 0, 0.0156863)
			template.Title.TextColor3 = Color3.new(1, 0, 0.0156863)
			template.Visible = true
			template.Size = UDim2.new(1, 0, 0, 0)
			TweenService:Create(template, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Size = UDim2.new(1, 0,0.1, 0)
			}):Play()
			script.Error:Play()
			task.delay(Duration, function()
				TweenService:Create(template, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					Size = UDim2.new(1, 0, 0, 0)
				}):Play()
				task.delay(0.2, function()
					template:Destroy()
				end)
			end)
		else
			if Type == "Info" then
				local template = Notify.Notifications.Template.Template:Clone()
				template.Parent = Notify.Notifications
				template.Title.Text = Text
				template.UIStroke.Color = Color3.new(1, 1, 1)
				template.Title.TextColor3 = Color3.new(1, 1, 1)
				template.Visible = true
				template.Size = UDim2.new(1, 0, 0, 0)
				TweenService:Create(template, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Size = UDim2.new(1, 0,0.1, 0)
				}):Play()
				script.Info:Play()
				task.delay(Duration, function()
					TweenService:Create(template, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
						Size = UDim2.new(1, 0, 0, 0)
					}):Play()
					task.delay(0.2, function()
						template:Destroy()
					end)
				end)
			else
				if Type == "Announcement" then
					local template = Notify.Notifications.Template.Template:Clone()
					template.Parent = Notify.Notifications
					template.Title.Text = Text
					template.UIStroke.Color = Color3.new(0.533333, 0.533333, 0.533333)
					template.Title.TextColor3 = Color3.new(0.533333, 0.533333, 0.533333)
					template.Visible = true
					template.Size = UDim2.new(1, 0, 0, 0)
					TweenService:Create(template, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						Size = UDim2.new(1, 0,0.1, 0)
					}):Play()
					script.Announcement:Play()
					task.delay(Duration, function()
						TweenService:Create(template, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
							Size = UDim2.new(1, 0, 0, 0)
						}):Play()
						task.delay(0.2, function()
							template:Destroy()
						end)
					end)
				end
			end
		end
	end
end

Notification("Announcement", 4.5, "Welcome To Dap Hood")

if _G.GUN_COMBAT_TOGGLE == nil then
	_G.GUN_COMBAT_TOGGLE = false 
end 
_G.MoneyDropConnections = false 
CurrentCamera.CameraType = Enum.CameraType.Custom 
spawn(function()
	while true do
		wait() 
		if Character:WaitForChild("Humanoid") then
			break 
		end 	
	end 
	CurrentCamera.CameraSubject = Character.Humanoid 
end) 
function changefunc()
	local u1 = {
		functions = {}, 
	} 
	u1.connect = function(p1, p2)
		table.insert(u1.functions, p2) 
	end
	local u2 = nil 
	function u1.updatechanges(p3, p4)
		local v21, v22, v23 = pairs(u1.functions) 
		while true do
			local v24, v25 = v21(v22, v23) 
			if v24 then

			else
				break 
			end 
			v23 = v24 
			spawn(function()
				v25(p4.Press, p4.Time, u2) 
			end) 		
		end 
		u2 = p4.Time 
	end 
	return u1 
end 
local v26 = {} 
function v26.__index(p5, p6)
	if getmetatable(Inputs)[p6] == nil then
		Inputs[p6] = {} 
	end 
	return getmetatable(Inputs)[p6] 
end 
function v26.__newindex(p7, p8, p9)
	if getmetatable(Inputs)[p8] == nil then
		getmetatable(Inputs)[p8] = {
			val = p9, 
			changed = changefunc()
		} 
		return 
	end 
	getmetatable(Inputs)[p8].val = p9 
	getmetatable(Inputs)[p8].changed:updatechanges(p9) 
end 
setmetatable(Inputs, v26) 
UserInputService.InputBegan:connect(function(p10, p11)
	if not p11 then
		if p10.UserInputType ~= Enum.UserInputType.Keyboard and p10.UserInputType ~= Enum.UserInputType.Gamepad1 then
			if p10.UserInputType == Enum.UserInputType.MouseButton2 then
				Inputs[Enum.UserInputType.MouseButton2.Name] = {
					Press = true, 
					Time = tick()
				} 
			end 
			return 
		end 
	else
		return 
	end 
	Inputs[p10.KeyCode.Name] = {
		Press = true, 
		Time = tick()
	} 
end) 
UserInputService.InputEnded:connect(function(p12, p13)
	if not p13 then
		if p12.UserInputType ~= Enum.UserInputType.Keyboard and p12.UserInputType ~= Enum.UserInputType.Gamepad1 then
			if p12.UserInputType == Enum.UserInputType.MouseButton2 then
				Inputs[Enum.UserInputType.MouseButton2.Name] = {
					Press = false, 
					Time = tick()
				} 
			end 
			return 
		end 
	else
		return 
	end 
	Inputs[p12.KeyCode.Name] = {
		Press = false, 
		Time = tick()
	} 
end) 
local u3 = false 
Inputs.Q.changed:connect(function(p14)
	if p14 and u3 == false and MainModule.Activate(BodyEffects) and (LocalPlayer.DataFolder.Information:FindFirstChild("JJARC") and BodyEffects.Mask.Value == "[Breathing Mask]" and Character:FindFirstChild("In-gameMask")) then
		u3 = true 
		MainEvent:FireServer("BreathingHAMON") 
		wait(2) 
		u3 = false
	end 
end) 
local u4 = false 

MainScreenGui:WaitForChild("Leaderboard") 
if _G.LeaderBoardVisible == true or _G.LeaderBoardVisible == nil then
	MainScreenGui.Leaderboard.Visible = false 
	_G.LeaderBoardVisible = false 
else
	MainScreenGui.Leaderboard.Visible = false 
end 
_G.LeaderBoardVisible = _G.LeaderBoardVisible and false 
Inputs.Tab.changed:connect(function(p22)
	if p22 then
		_G.LeaderBoardVisible = not _G.LeaderBoardVisible 
		MainScreenGui.Leaderboard.Visible = _G.LeaderBoardVisible 
	end 
end) 
local u5 = false



MainEvent.OnClientEvent:Connect(function(Reason, Value)
	if Reason == "ResetButtonHandler" then
		game:GetService("StarterGui"):SetCore("ResetButtonCallback", Value)
	else
		if Reason == "BackpackBarHandler" then
			game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, Value)
			for i, v in pairs(Character:GetChildren()) do
				if v:IsA("Tool") then
					Character.Humanoid:UnequipTools()
				end
			end
		end
	end
end)

local ShopMenu = MainScreenGui.Crew.ShopFrame
local Background = ShopMenu.ShopBackGround
local CloseButton = ShopMenu.CloseButton

CloseButton.Activated:Connect(function()
	ShopMenu.Visible = not ShopMenu.Visible
end)

MainScreenGui.Crew.CenterTop.Shop.Activated:Connect(function()
	MainScreenGui.Crew.ShopFrame.Visible = not MainScreenGui.Crew.ShopFrame.Visible
end)


for _, v in pairs(MainScreenGui.Crew.ShopFrame.ShopBackGround.StuffFrame:GetChildren()) do
		Background.StuffFrame.SpawnWithArmor.TextButton.Activated:Connect(function()
		MarketplaceService:PromptGamePassPurchase(LocalPlayer, 1801380078)
				ShopMenu.ButtonSound:Play()
			end)
	Background.StuffFrame.SpawnWithFood.TextButton.Activated:Connect(function()
				MarketplaceService:PromptGamePassPurchase(LocalPlayer, 744835282)
				ShopMenu.ButtonSound:Play()
			end)
	Background.StuffFrame.SpawnWithTools.TextButton.Activated:Connect(function()
				MarketplaceService:PromptGamePassPurchase(LocalPlayer, 744709349)
				ShopMenu.ButtonSound:Play()
			end)

	Background.StuffFrame.AimViewerTool.TextButton.Activated:Connect(function()
		MarketplaceService:PromptGamePassPurchase(LocalPlayer, 744729720)
		ShopMenu.ButtonSound:Play()
	end)
end


for i, v in pairs(MainScreenGui.Crew.ShopFrame.ShopBackGround.EmojiFrame:GetChildren()) do
	if v:IsA("Frame") then
		v.TextBoxName.Text = LocalPlayer.DisplayName
		v.TextButton.Activated:Connect(function()
			MarketplaceService:PromptProductPurchase(LocalPlayer, v.TextButton.ID.Value)
			ShopMenu.ButtonSound:Play()
		end)
	end
end

for i, v in pairs(MainScreenGui.Crew.ShopFrame.ShopBackGround.StompFrame:GetChildren()) do
	if v:IsA("Frame") then
		v.TextButton.Activated:Connect(function()
			MarketplaceService:PromptProductPurchase(LocalPlayer, v.TextButton.ID.Value)
			ShopMenu.ButtonSound:Play()
		end)
	end
end


Background.AuraButton.Activated:Connect(function()
	Background.AuraFrame.Visible = true
	Background.EmojiFrame.Visible = false
	Background.StuffFrame.Visible = false
	Background.StompFrame.Visible = false
	ShopMenu.MenuSound:Play()
end)

Background.EmojiButton.Activated:Connect(function()
	Background.EmojiFrame.Visible = true
	Background.AuraFrame.Visible = false
	Background.StuffFrame.Visible = false
	Background.StompFrame.Visible = false
	ShopMenu.MenuSound:Play()
end)

Background.StuffButton.Activated:Connect(function()
	Background.StuffFrame.Visible = true
	Background.AuraFrame.Visible = false
	Background.EmojiFrame.Visible = false
	Background.StompFrame.Visible = false
	ShopMenu.MenuSound:Play()
end)

Background.StompButton.Activated:Connect(function()
	Background.StompFrame.Visible = true
	Background.AuraFrame.Visible = false
	Background.EmojiFrame.Visible = false
	ShopMenu.MenuSound:Play()
end)

local ScrollUI_Aura = MainScreenGui.Crew.newAura.ShopBackGround.Scroll

ScrollUI_Aura.Broly.Toggle.Activated:Connect(function()
	if MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 664030238) then
		if ScrollUI_Aura.Broly.ToggleBool.Value == true then
			MainEvent:FireServer("Broly", false)
			ScrollUI_Aura.Broly.Toggle.Text = "OFF"
			ScrollUI_Aura.Broly.Toggle.BackgroundColor3 = Color3.new(0.596078, 0, 0.0117647)
			ScrollUI_Aura.Broly.ToggleBool.Value = false
		else
			MainEvent:FireServer("Broly", true)
			ScrollUI_Aura.Broly.Toggle.Text = "ON"
			ScrollUI_Aura.Broly.Toggle.BackgroundColor3 = Color3.new(0.0862745, 0.52549, 0)
			ScrollUI_Aura.Broly.ToggleBool.Value = true
		end
	else
		MarketplaceService:PromptGamePassPurchase(LocalPlayer, 664030238)
	end
end)

--[[
ScrollUI_Aura.Unkown.Toggle.Activated:Connect(function()
	if MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 664030238) then
		if ScrollUI_Aura.Unkown.ToggleBool.Value == true then
			MainEvent:FireServer("Unkown", false)
			ScrollUI_Aura.Unkown.Toggle.Text = "OFF"
			ScrollUI_Aura.Unkown.Toggle.BackgroundColor3 = Color3.new(0.596078, 0, 0.0117647)
			ScrollUI_Aura.Unkown.ToggleBool.Value = false
		else
			MainEvent:FireServer("Unkown", true)
			ScrollUI_Aura.Unkown.Toggle.Text = "ON"
			ScrollUI_Aura.Unkown.Toggle.BackgroundColor3 = Color3.new(0.0862745, 0.52549, 0)
			ScrollUI_Aura.Unkown.ToggleBool.Value = true
		end
	else
		MarketplaceService:PromptGamePassPurchase(LocalPlayer, 663732421)
	end
end)

ScrollUI_Aura.Kitty.Toggle.Activated:Connect(function()
	if MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 665051147) then
		if ScrollUI_Aura.Kitty.ToggleBool.Value == true then
			MainEvent:FireServer("Kitty", false)
			ScrollUI_Aura.Kitty.Toggle.Text = "OFF"
			ScrollUI_Aura.Kitty.Toggle.BackgroundColor3 = Color3.new(0.596078, 0, 0.0117647)
			ScrollUI_Aura.Kitty.ToggleBool.Value = false
		else
			MainEvent:FireServer("Kitty", true)
			ScrollUI_Aura.Kitty.Toggle.Text = "ON"
			ScrollUI_Aura.Kitty.Toggle.BackgroundColor3 = Color3.new(0.0862745, 0.52549, 0)
			ScrollUI_Aura.Kitty.ToggleBool.Value = true
		end
	else
		MarketplaceService:PromptGamePassPurchase(LocalPlayer, 665051147)
	end
end)

ScrollUI_Aura.Blade.Toggle.Activated:Connect(function()
	if MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 665051147) then
		if ScrollUI_Aura.Blade.ToggleBool.Value == true then
			MainEvent:FireServer("Blade", false)
			ScrollUI_Aura.Blade.Toggle.Text = "OFF"
			ScrollUI_Aura.Blade.Toggle.BackgroundColor3 = Color3.new(0.596078, 0, 0.0117647)
			ScrollUI_Aura.Blade.ToggleBool.Value = false
		else
			MainEvent:FireServer("Blade", true)
			ScrollUI_Aura.Blade.Toggle.Text = "ON"
			ScrollUI_Aura.Blade.Toggle.BackgroundColor3 = Color3.new(0.0862745, 0.52549, 0)
			ScrollUI_Aura.Blade.ToggleBool.Value = true
		end
	else
		MarketplaceService:PromptGamePassPurchase(LocalPlayer, 665040356)
	end
end)

ScrollUI_Aura.Resort.Toggle.Activated:Connect(function()
	if MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 663108867) then
		if ScrollUI_Aura.Resort.ToggleBool.Value == true then
			MainEvent:FireServer("Resort", false)
			ScrollUI_Aura.Resort.Toggle.Text = "OFF"
			ScrollUI_Aura.Resort.Toggle.BackgroundColor3 = Color3.new(0.596078, 0, 0.0117647)
			ScrollUI_Aura.Resort.ToggleBool.Value = false
		else
			MainEvent:FireServer("Resort", true)
			ScrollUI_Aura.Resort.Toggle.Text = "ON"
			ScrollUI_Aura.Resort.Toggle.BackgroundColor3 = Color3.new(0.0862745, 0.52549, 0)
			ScrollUI_Aura.Resort.ToggleBool.Value = true
		end
	else
		MarketplaceService:PromptGamePassPurchase(LocalPlayer, 663108867)
	end
end)

ScrollUI_Aura.Summer.Toggle.Activated:Connect(function()
	if MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 662999962) then
		if ScrollUI_Aura.Summer.ToggleBool.Value == true then
			MainEvent:FireServer("Summer", false)
			ScrollUI_Aura.Summer.Toggle.Text = "OFF"
			ScrollUI_Aura.Summer.Toggle.BackgroundColor3 = Color3.new(0.596078, 0, 0.0117647)
			ScrollUI_Aura.Summer.ToggleBool.Value = false
		else
			MainEvent:FireServer("Summer", true)
			ScrollUI_Aura.Summer.Toggle.Text = "ON"
			ScrollUI_Aura.Summer.Toggle.BackgroundColor3 = Color3.new(0.0862745, 0.52549, 0)
			ScrollUI_Aura.Summer.ToggleBool.Value = true
		end
	else
		MarketplaceService:PromptGamePassPurchase(LocalPlayer, 662999962)
	end
end)

ScrollUI_Aura.Bats.Toggle.Activated:Connect(function()
	if MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 663706066) then
		if ScrollUI_Aura.Bats.ToggleBool.Value == true then
			MainEvent:FireServer("Bats", false)
			ScrollUI_Aura.Bats.Toggle.Text = "OFF"
			ScrollUI_Aura.Bats.Toggle.BackgroundColor3 = Color3.new(0.596078, 0, 0.0117647)
			ScrollUI_Aura.Bats.ToggleBool.Value = false
		else
			MainEvent:FireServer("Bats", true)
			ScrollUI_Aura.Bats.Toggle.Text = "ON"
			ScrollUI_Aura.Bats.Toggle.BackgroundColor3 = Color3.new(0.0862745, 0.52549, 0)
			ScrollUI_Aura.Bats.ToggleBool.Value = true
		end
	else
		MarketplaceService:PromptGamePassPurchase(LocalPlayer, 663706066)
	end
end)

ScrollUI_Aura.Cloudy.Toggle.Activated:Connect(function()
	if MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 663918026) then
		if ScrollUI_Aura.Cloudy.ToggleBool.Value == true then
			MainEvent:FireServer("Cloudy", false)
			ScrollUI_Aura.Cloudy.Toggle.Text = "OFF"
			ScrollUI_Aura.Cloudy.Toggle.BackgroundColor3 = Color3.new(0.596078, 0, 0.0117647)
			ScrollUI_Aura.Cloudy.ToggleBool.Value = false
		else
			MainEvent:FireServer("Cloudy", true)
			ScrollUI_Aura.Cloudy.Toggle.Text = "ON"
			ScrollUI_Aura.Cloudy.Toggle.BackgroundColor3 = Color3.new(0.0862745, 0.52549, 0)
			ScrollUI_Aura.Cloudy.ToggleBool.Value = true
		end
	else
		MarketplaceService:PromptGamePassPurchase(LocalPlayer, 663918026)
	end
end)

ScrollUI_Aura.Lightning.Toggle.Activated:Connect(function()
	if MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 662937982) then
		if ScrollUI_Aura.Lightning.ToggleBool.Value == true then
			MainEvent:FireServer("Lightning", false)
			ScrollUI_Aura.Lightning.Toggle.Text = "OFF"
			ScrollUI_Aura.Lightning.Toggle.BackgroundColor3 = Color3.new(0.596078, 0, 0.0117647)
			ScrollUI_Aura.Lightning.ToggleBool.Value = false
		else
			MainEvent:FireServer("Lightning", true)
			ScrollUI_Aura.Lightning.Toggle.Text = "ON"
			ScrollUI_Aura.Lightning.Toggle.BackgroundColor3 = Color3.new(0.0862745, 0.52549, 0)
			ScrollUI_Aura.Lightning.ToggleBool.Value = true
		end
	else
		MarketplaceService:PromptGamePassPurchase(LocalPlayer, 662937982)
	end
end)

ScrollUI_Aura.Cats.Toggle.Activated:Connect(function()
	if MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 663228984) then
		if ScrollUI_Aura.Cats.ToggleBool.Value == true then
			MainEvent:FireServer("Cats", false)
			ScrollUI_Aura.Cats.Toggle.Text = "OFF"
			ScrollUI_Aura.Cats.Toggle.BackgroundColor3 = Color3.new(0.596078, 0, 0.0117647)
			ScrollUI_Aura.Cats.ToggleBool.Value = false
		else
			MainEvent:FireServer("Cats", true)
			ScrollUI_Aura.Cats.Toggle.Text = "ON"
			ScrollUI_Aura.Cats.Toggle.BackgroundColor3 = Color3.new(0.0862745, 0.52549, 0)
			ScrollUI_Aura.Cats.ToggleBool.Value = true
		end
	else
		MarketplaceService:PromptGamePassPurchase(LocalPlayer, 663228984)
	end
end)
]]
MainScreenGui.Leaderboard.Close.MouseButton1Click:connect(function()
	if u5 == false then
		game:GetService("TweenService"):Create(MainScreenGui.Leaderboard, TweenInfo.new(0.5), {
			Position = UDim2.new(1, -205, 0, -200)
		}):Play() 
		MainScreenGui.Leaderboard.Close.Text = "OPEN" 
	else
		game:GetService("TweenService"):Create(MainScreenGui.Leaderboard, TweenInfo.new(0.5), {
			Position = UDim2.new(1, -205, 0, 5)
		}):Play() 
		MainScreenGui.Leaderboard.Close.Text = "CLOSE"
	end 
	wait(0.5) 
	u5 = not u5 
end) 
local u6 = false 
Inputs.LeftShift.changed:connect(function(p23, p24, p25)
	if p23 then
		u6 = true 
		return 
	end 
	u6 = false 
end) 
Inputs.ButtonL3.changed:connect(function(p26)
	if p26 then
		u6 = true 
		return 
	end 
	u6 = false 
end) 
local u7 = false 
ContextActionService:BindAction("Sprint", function(p27, p28)
	if p28 and p28 == Enum.UserInputState.Begin then
		u7 = not u7 
		u6 = u7 
	end 
end, true, "Sprint") 
ContextActionService:SetImage("Sprint", "rbxassetid://5500316788") 
ContextActionService:SetPosition("Sprint", UDim2.new(0.65, 0, 0, 0)) 
local u8 = true 
local u9 = false 
Inputs.MouseButton2.changed:connect(function(p29, p30, p31)
	if u8 == false then
		return 
	end 
	u9 = p29 
	if u9 == false then
		u8 = false 
		wait(0.1) 
		u8 = true 
	end
end) 
Inputs.ButtonL2.changed:connect(function(p32)
	if u8 == false then
		return 
	end 
	u9 = p32 
	if u9 == false then
		u8 = false 
		wait(0.1) 
		u8 = true 
	end 
end) 
local u10 = false 
local function v28()
	if u10 == false and MainModule.Activate(BodyEffects) then
		u10 = true 
		local v29 = workspace:FindPartOnRayWithIgnoreList(Ray.new(Character.LowerTorso.Position, Vector3.new(0, -Character.UpperTorso.Size.y * 4.5, 0)), { Character, unpack(MainModule.Ignored) }) 
		local v30 = nil 
		if v29 and v29:IsDescendantOf(workspace.Players) then
			v30 = v29.Parent:FindFirstChild("Humanoid") or (v29.Parent.Parent:FindFirstChild("Humanoid") or v29.Parent.Parent.Parent:FindFirstChild("Humanoid")) 
		end 
		if v30 then
			Stomp:Play(0.100000001, 1, 1.5) 
			wait(0.75) 
			MainEvent:FireServer("Stomp") 
			wait(0.4) 
		end 
		u10 = false 
	end 
end 
ContextActionService:BindAction("Stomp", v28, true, "Stomp") 
ContextActionService:SetImage("Stomp", "rbxassetid://5500317148") 
ContextActionService:SetPosition("Stomp", UDim2.new(0.65, 0, 0, -35)) 
Inputs.E.changed:connect(function(p33, p34, p35)
	if p33 then
		v28() 
	end 
end) 
Inputs.DPadDown.changed:connect(function(p36)
	if p36 then
		v28() 
	end 
end) 
local u11 = false 
local u12 = false 
ContextActionService:BindAction("Crouch", function(p37, p38)
	if p38 then
		if p38 == Enum.UserInputState.Begin then
			u11 = not u11 
			p37 = u11 
		else
			p37 = u11 
		end 
	end 
	u12 = p37 
end, true, "Crouch") 
ContextActionService:SetImage("Crouch", "rbxassetid://5500316222") 
ContextActionService:SetPosition("Crouch", UDim2.new(0.65, 0, 0, 35)) 
Inputs.LeftControl.changed:connect(function(p39, p40, p41)
	u12 = p39 
end) 
Inputs.ButtonB.changed:connect(function(p42)
	u12 = p42 
end) 
local u13 = false 
local function v31()
	if u13 == false and BodyEffects.Attacking.Value == false and BodyEffects["K.O"].Value == false and Character:FindFirstChild("GRABBING_CONSTRAINT") == nil then
		u13 = true 
		MainEvent:FireServer("Grabbing", u12) 
		wait(0.5) 
		u13 = false 
	end 
end 
ContextActionService:BindAction("Carry", v31, true, "Carry") 
ContextActionService:SetImage("Carry", "rbxassetid://5500315978") 
ContextActionService:SetPosition("Carry", UDim2.new(0.65, 0, 0, -70)) 
Inputs.G.changed:connect(function(p43, p44, p45)
	if p43 then
		v31() 
	end 
end) 
Inputs.DPadUp.changed:connect(function(p46)
	if p46 then
		v31() 
	end 
end) 
ContextActionService:BindAction("Reload", function()
	local v32 = MainModule.GunHold(Character) 
	if v32 then
		MainEvent:FireServer("Reload", v32[1]) 
	end 
end, true, "Reload") 
ContextActionService:SetImage("Reload", "rbxassetid://5500316505") 
ContextActionService:SetPosition("Reload", UDim2.new(0.65, 0, 0, -105)) 
Inputs.R.changed:connect(function(p47, p48, p49)
	if not p47 then
		return 
	end 
	local v33 = MainModule.GunHold(Character) 
	if v33 then
		MainEvent:FireServer("Reload", v33[1]) 
	end 
end) 
Inputs.ButtonX.changed:connect(function(p50)
	if not p50 then
		return 
	end 
	local v34 = MainModule.GunHold(Character) 
	if v34 then
		MainEvent:FireServer("Reload", v34[1]) 
	end 
end) 
local AutoShoot = false
local ChargeAt = false

if MainModule.IsMobile() then
	MainScreenGui.ShootButton.MouseButton1Down:Connect(function()
		if AutoShoot == false then
			AutoShoot = true
		end
	end)

	MainScreenGui.ShootButton.MouseButton1Up:Connect(function()
		if AutoShoot == true then
			AutoShoot = false
		end
	end)

	MainScreenGui.ChargeButton.MouseButton1Down:Connect(function()
		if ChargeAt == false then
			ChargeAt = true
		end
	end)

	MainScreenGui.ChargeButton.MouseButton1Up:Connect(function()
		if ChargeAt == true then
			ChargeAt = false
		end
	end)
end
if MainModule.IsMobile() then
	MainScreenGui.Crew.BottomLeft.MouseLock.Visible = true 
	_G.UpdateAimed(false) 
end 

_G.MobileShiftLock = false 
local Shiftlock = false 
MainScreenGui.Crew.BottomLeft.MouseLock.Activated:connect(function()
	Shiftlock = not Shiftlock 
	if Shiftlock then
		u9 = true
		MainScreenGui.Aim.Visible = true 
		MainScreenGui.Aim.Position = UDim2.new(0.5, 0, 0.5, -19) 
	else
		u9 = false
		MainScreenGui.Aim.Visible = true 
	end 
	_G.MobileShiftLock = Shiftlock 
	_G.UpdateAimed(Shiftlock) 
end) 


if UserInputService.GamepadEnabled then
	workspace.DescendantAdded:connect(function(Descendant)
		if Descendant.Name == "Blood_Decal" then
			Descendant.Transparency = 1 
			return 
		end 
		if Descendant.Name == "BloodParticle" then
			Descendant.Transparency = NumberSequence.new(1) 
		end 
	end) 
end 

Table = {
	timer = tick(), 
	times = 0, 
	disabling = false
} 

LocalPlayer.Backpack.ChildAdded:connect(function(p52)
	if p52:IsA("Tool") then
		if tick() - Table.timer < 0.1 then
			Table.times = Table.times + 1 
		else
			Table.times = 0 
		end 
		if Table.times >= 4 and Table.disabling == false then
			Table.disabling = true 
			game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false) 
			delay(1, function()
				Table.disabling = false 
				game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true) 
			end) 
		end 
		Table.timer = tick() 
	end 
end)

MainScreenGui:WaitForChild("AmmoFrame")
MainScreenGui.AmmoFrame.Visible = false

StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true) 

BodyEffects:WaitForChild("K.O")

BodyEffects["K.O"].Changed:Connect(function(Ragdolled)
	if Ragdolled then
		CurrentCamera.CameraSubject = Character.UpperTorso 
		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
		game:GetService("StarterGui"):SetCore("ResetButtonCallback", false)
		for i, v in pairs(Character:GetChildren()) do
			if v:IsA("Tool") and not v:GetAttribute("IsAGun") then
				Character.Humanoid:UnequipTools()
			end
		end
		if script.Parent:FindFirstChild("BottomLeft") then
			script.Parent:FindFirstChild("BottomLeft").Enabled = false
		end
		return 
	end 
	CurrentCamera.CameraSubject = Character.Humanoid 
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true) 
	game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
	if script.Parent:FindFirstChild("BottomLeft") then
		script.Parent:FindFirstChild("BottomLeft").Enabled = true
	end
end) 

LocalPlayer:WaitForChild("DataFolder")
LocalPlayer.DataFolder:WaitForChild("Currency")

local Money = LocalPlayer.DataFolder.Currency.Value
local STREAK = nil

local function StreaksFUNCTION(Streaks)
	script.Kill:Play()

	if Streaks > 0 then
		Streaks = "+" .. MainModule.AddComma(Streaks).." Streak"
	else
		Streaks = "-" .. MainModule.AddComma(math.abs(Streaks)).." Streak"
	end

	local v36 = Instance.new("TextLabel")
	v36.Name = "MONEYDELTA"
	v36.Text = Streaks
	v36.BackgroundTransparency = 1
	v36.AnchorPoint = Vector2.new(0.5, 0.5)
	v36.Position = UDim2.new(0.5, 0, 0, 40)
	v36.TextColor3 = Color3.fromRGB(255, 0, 0)
	v36.Size = UDim2.new(0, 50, 0, 50)
	v36.Font = Enum.Font.GothamBold
	v36.TextSize = 25
	v36.Parent = MainScreenGui
	delay(0.3, function()
		game:GetService("TweenService"):Create(v36, TweenInfo.new(1), {Position = UDim2.new(0.5, 0, 0, -40), TextTransparency = 1}):Play()
		wait(1)
		v36:Destroy()
	end)
end

local function makeMoneyChangeGUI(Currency)
	script.CurrencySound:Play() 
	local Color
	if Currency > 0 then
		Color = Color3.fromRGB(95, 255, 87) 
		Currency = "+ $" .. MainModule.AddComma(Currency) 
	else
		Color = Color3.fromRGB(194, 0, 0) 
		Currency = "- $" .. MainModule.AddComma(math.abs(Currency)) 
	end 
	local TextLabel = Instance.new("TextLabel") 
	TextLabel.Name = "MONEYDELTA" 
	TextLabel.Text = Currency 
	TextLabel.BackgroundTransparency = 1 
	TextLabel.AnchorPoint = Vector2.new(0.5, 0.5) 
	TextLabel.Position = UDim2.new(0.5, 0, 0, 40) 
	TextLabel.TextColor3 = Color 
	TextLabel.Size = UDim2.new(0, 50, 0, 50) 
	TextLabel.Font = Enum.Font.Highway 
	TextLabel.TextSize = 25 
	TextLabel.Parent = MainScreenGui 
	delay(0.3, function()
		game:GetService("TweenService"):Create(TextLabel, TweenInfo.new(1), {
			Position = UDim2.new(0.5, 0, 0, -40), 
			TextTransparency = 1
		}):Play() 
		wait(1) 
		TextLabel:Destroy() 
	end) 
end 

local function StreakChangeFunction()
	if STREAK ~= nil then
		StreaksFUNCTION(LocalPlayer:WaitForChild("DataFolder"):WaitForChild("Information"):WaitForChild("Streaks").Value - STREAK)
	end

	STREAK = LocalPlayer:WaitForChild("DataFolder"):WaitForChild("Information"):WaitForChild("Streaks").Value
end

LocalPlayer:WaitForChild("DataFolder"):WaitForChild("Information"):WaitForChild("Streaks"):GetPropertyChangedSignal("Value"):Connect(function()
	if BodyEffects["K.O"].Value == false then
		StreakChangeFunction()
	end
end)

StreakChangeFunction()

LocalPlayer:WaitForChild("DataFolder").Currency.Changed:connect(function()
	MainScreenGui.MoneyText.Text = "$" .. MainModule.AddComma(LocalPlayer:WaitForChild("DataFolder").Currency.Value) 
	if Money ~= nil then
		makeMoneyChangeGUI(LocalPlayer:WaitForChild("DataFolder").Currency.Value - Money) 
	end 
	Money = LocalPlayer:WaitForChild("DataFolder").Currency.Value 
end) 

MainScreenGui.MoneyText.Text = "$" .. MainModule.AddComma(LocalPlayer:WaitForChild("DataFolder").Currency.Value) 

BodyEffects:WaitForChild("GunShotChanges")

BodyEffects.GunShotChanges:GetPropertyChangedSignal('Value'):Connect(function()
	local Tool = MainModule.GunHold(Character)

	if Tool == nil or Tool == false then
		return
	end

	local Reloaded = true 

	if Tool[1].Name == "[Flamethrower]" then
		return
	end

	local Recoil = nil;

	if math.random() > 0.5 then
		Recoil = 0.008726646259971648
	else
		Recoil = -0.008726646259971648
	end

	CurrentCamera.CFrame = CurrentCamera.CFrame * CFrame.Angles(0.004363323129985824, Recoil * 0.5, 0) 

	if not (not _G.Aimed) or Tool[1].Name == "[Shotgun]" or Tool[1].Name == "[Sniper]" or Tool[1].Name == "[Rifle]" or Tool[1].Name == "[TacticalShotgun]" or Tool[1].Name == "[AR]" or Tool[1].Name == "[AUG]" or Tool[1].Name == "[AK47]" or Tool[1].Name == "[LMG]" or Tool[1].Name == "[SilencerAR]" or Tool[1].Name == "[Automatic RPG]" then
		if Reloaded then
			SmallGunAimShot:Play()
			return
		end
	else
		CurrentCamera.CFrame = CurrentCamera.CFrame * CFrame.Angles(0.004363323129985824, Recoil * 0.5, 0)
		if Reloaded then
			SmallGunShot:Play(0.100000001, 1, 1.25) 
		end
	end
end)

local RemoteFunction = game:GetService("ReplicatedStorage").RemoteFunction.RemoteFunction 

function RemoteFunction.OnClientInvoke(Subject, ...)
	if Subject == "Aim" then
		local Position, Shot = ... 
		local Tool = MainModule.GunHold(Character) 
		if Tool == nil or Tool == false then
			return 
		else
			local Reloaded = true 
			local Hit = nil
			local bruuuhhhh = Tool[1].Ammo
			if Tool and Tool[1] and bruuuhhhh.Value <= 0 then
				Reloaded = false 
			end 
			if not (not _G.Aimed) or Tool[1].Name == "[Shotgun]" or Tool[1].Name == "[Automatic RPG]" or Tool[1].Name == "[Rifle]" or Tool[1].Name == "[AR]" then
				Hit = (Mouse.Hit.p - Position).unit 
				if Reloaded then
					SmallGunAimShot:Play() 
				end 
			else
				Hit = (Mouse.Hit.p + Vector3.new(0, math.random() > 0.5 and math.random() or math.random() * -1, 0) - Position).unit 
				if Reloaded then
					SmallGunAimShot:Play(0.100000001, 1, 1.25) 
				end 
			end 
			if _G.GUN_COMBAT_TOGGLE then
				local Position = nil 
				if Shot ~= true then
					for i, v in pairs(workspace.Players:GetChildren()) do
						if v ~= Character and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("UpperTorso") and (v.UpperTorso.Position - Character.UpperTorso.Position).magnitude < 5 then
							return true 
						end 
					end 
					Position = Hit 
					return Position 
				else
					Position = Hit 
					return Position 
				end 
			else
				Position = Hit 
				return Position 
			end 
		end 
	end 
	if Subject == "MOUSEPOS" then
		return Mouse.Hit.p 
	end 
	if Subject == "CLOSECOMBAT" then
		for i, v in pairs(workspace.Players:GetChildren()) do
			if v ~= Character and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("UpperTorso") and (v.UpperTorso.Position - Character.UpperTorso.Position).magnitude < 5 then
				return true 
			end 
		end 
		return false 
	end 
	if Subject ~= "LOCK_PICK" then
		if Subject == "Join/Leave" then
			local AreYouSure = MainScreenGui.AreYouSure 
			AreYouSure.Visible = true 
			local Selected = nil 
			local No = AreYouSure.TextButton2.MouseButton1Click:connect(function()
				Selected = false 
			end)
			local Yes = AreYouSure.TextButton.MouseButton1Click:connect(function()
				Selected = true 
			end)
			while true do
				wait() 
				if Selected ~= nil then
					break 
				end 			
			end 
			No:disconnect() 
			Yes:disconnect()
			AreYouSure.Visible = false 
			return Selected 
		else
			return 
		end 
	end 
	local LockPick = MainScreenGui.LockPick 
	LockPick.Visible = true 
	local Clicked = false 
	local Click = nil 
	Click = Mouse.Button1Down:connect(function()
		Clicked = true 
		Click:disconnect() 
	end) 
	local Spot = 0 
	while Clicked == false do
		Spot = Spot + 0.01 
		local CurrAccuracy = Spot % 1 
		if CurrAccuracy > 0.3 and CurrAccuracy < 0.7 then
			Spot = Spot + 0.01 
		end 
		LockPick.Green.Position = UDim2.new(Spot % 1, 0, 0.5, 0) 
		game:GetService("RunService").Heartbeat:wait() 	
	end 
	local Accuracy = Spot % 1 
	LockPick.Visible = false 
	if Accuracy > 0.4 and Accuracy < 0.6 then
		return true 
	end 
	return false 
end 

Main = false

CurrentCamera:ClearAllChildren()

local CombatLogTimer = 0
local CombatLog = MainScreenGui:WaitForChild("CombatLog")
local TIMERCOOLDOWN = false
local COOLDOWN = false

local Bicycling = Character.Humanoid:LoadAnimation(game:GetService("ReplicatedStorage").ClientAnimations.Bicycling) 
local CartRide = Character.Humanoid:LoadAnimation(game:GetService("ReplicatedStorage").ClientAnimations.CartRide) 
local FireworksModule = require(game:GetService("ReplicatedStorage"):WaitForChild("Firework")) 
MainEvent:FireServer("IS_MOBILE", MainModule.IsMobile()) 

if _G.updateFerrisWheel == nil then
	_G.updateFerrisWheel = false 
	_G.updateBullAnimation = false 
end 

Mouse.TargetFilter = workspace:WaitForChild("Ignored",1/0)

local u24 = {} 
local u25 = { "19323823", "19323854" } 
local u26 = { "19003948", "19003957", "19003971", "19003978", "19003982", "19003990", "19003998" } 

local u48 = false
local function skinsDebounceActi()
	if u48 == false then
		u48 = true
		MainScreenGui.WeaponSkinsGUI.Visible = not MainScreenGui.WeaponSkinsGUI.Visible 
		task.wait(0.01) 
		if MainScreenGui.WeaponSkinsGUI.Visible then
			game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
		else
			game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
		end
		task.wait(0.5)
		u48 = false
	end
end

MainEvent.OnClientEvent:Connect(function(p59, place, localplr)
	if p59 == "Atomic_Require" then
		require(place).Startup(localplr)
	end
end)

MainEvent.OnClientEvent:connect(function(p59, ...)
	if p59 == "ShotFrom" then
		local v73 = ... 
		local v74 = game:GetService("ReplicatedStorage").DMGIndicator:Clone() 
		v74.Parent = MainScreenGui.DamageIndicator 
		v74.Visible = true 
		for v75 = 0, 1, 0.01 do
			RunService.Heartbeat:wait() 
			local l__Position__76 = Character.LowerTorso.Position 
			local l__unit__77 = (v73 - l__Position__76).unit 
			--local l__unit__78 = CFrame.new(l__Position__76):ToObjectSpace(CurrentCamera.CFrame).p.unit 
			--v74.Rotation = math.deg(math.atan2(l__unit__77.x, -l__unit__77.z)) + math.deg(math.atan2(l__unit__78.x, l__unit__78.z)) 
			--v74.ImageTransparency = v75 
		end 
		v74:Destroy() 
		return 
	end 
	if p59 == "CombatLog" then
		CombatLogTimer = ...
		return
	end
	if p59 == "Notification" then
		local Arg = ...
		StarterGui:SetCore("SendNotification", {
			Duration = Arg[3],
			Title = Arg[1],
			Text = Arg[2]
		})
		script:WaitForChild("Notification"):Play()
		return
	end
	if p59 == "FerrisWheelUPDATE" then
		local v79, v80, v81 = ... 
		task.spawn(function()
			if _G.updateFerrisWheel == false then
				_G.updateFerrisWheel = true 
				local l__Wheel__82 = v79:WaitForChild("Wheel") 
				local l__Center__83 = l__Wheel__82:WaitForChild("Center") 
				for v84, v85 in pairs(l__Wheel__82:GetDescendants()) do
					if v85:IsA("BasePart") and v85 ~= l__Center__83 then
						v85.Anchored = false 
					end 
				end 
				local v86 = {} 
				for v87, v88 in pairs(l__Wheel__82:GetDescendants()) do
					if v88:IsA("RopeConstraint") then
						table.insert(v86, { v88.Attachment0, v88.Attachment1 }) 
					end 
				end 
				_G.updateFerrisWheel = v86 
			else
				while _G.updateFerrisWheel == true do
					task.wait() 				
				end 
			end 
			v79.Wheel.Center.CFrame = v80 * CFrame.Angles(-math.pi * 0.5, 0, 0) 
			game:GetService("TweenService"):Create(v79.Wheel.Center, TweenInfo.new(v81, Enum.EasingStyle.Linear), {
				CFrame = v80
			}):Play() 
			local v89 = v79.Wheel.Center:GetPropertyChangedSignal("CFrame"):connect(function()
				for v90, v91 in pairs(_G.updateFerrisWheel) do
					local l__WorldPosition__92 = v91[1].WorldPosition 
					v91[2].Parent.Parent.Parent:SetPrimaryPartCFrame(CFrame.new((v91[1].Parent.CFrame * CFrame.new(v91[1].Position)).p, (v91[1].Parent.CFrame * CFrame.new(v91[1].Position) - Vector3.new(0, 1, 0)).p) * CFrame.Angles(math.pi * 0.5, math.pi * 0.5, 0)) 
				end 
			end) 
			task.wait(v81) 
			v89:Disconnect() 
		end) 
		return 
	end
	if p59 == "CrateOpening" then
		WeaponSkinsGUI.Visible = true
		task.wait(0.1)
		CrateOpening(...);
		UpdateInventoryStuff();
		return;
	end;
	if p59 == "UpdateEquip" then
		UpdateInventoryStuff();
		return;
	end;
	if p59 == "BullAnimationSteering" then
		local v93, v94, v95 = ...;
		local l__BullControls__96 = MainScreenGui.BullControls;
		l__BullControls__96.Visible = true;
		if v93 == 1 then
			l__BullControls__96.Up.ImageColor3 = Color3.new(1, 0, 0);
			l__BullControls__96.Down.ImageColor3 = Color3.new(0, 0, 0);
		elseif v93 == -1 then
			l__BullControls__96.Up.ImageColor3 = Color3.new(0, 0, 0);
			l__BullControls__96.Down.ImageColor3 = Color3.new(1, 0, 0);
		else
			l__BullControls__96.Up.ImageColor3 = Color3.new(0, 0, 0);
			l__BullControls__96.Down.ImageColor3 = Color3.new(0, 0, 0);
		end;
		if v94 == 1 then
			l__BullControls__96.Right.ImageColor3 = Color3.new(1, 0, 0);
			l__BullControls__96.Left.ImageColor3 = Color3.new(0, 0, 0);
		elseif v94 == -1 then
			l__BullControls__96.Right.ImageColor3 = Color3.new(0, 0, 0);
			l__BullControls__96.Left.ImageColor3 = Color3.new(1, 0, 0);
		else
			l__BullControls__96.Right.ImageColor3 = Color3.new(0, 0, 0);
			l__BullControls__96.Left.ImageColor3 = Color3.new(0, 0, 0);
		end;
		if v95.Throttle == 1 then
			game:GetService("TweenService"):Create(l__BullControls__96.Up, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
				Position = UDim2.new(0.5, 0, 0, -10)
			}):Play();
		elseif v95.Throttle == -1 then
			game:GetService("TweenService"):Create(l__BullControls__96.Down, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
				Position = UDim2.new(0.5, 0, 1, 10)
			}):Play();
		else
			game:GetService("TweenService"):Create(l__BullControls__96.Up, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
				Position = UDim2.new(0.5, 0, 0, 0)
			}):Play();
			game:GetService("TweenService"):Create(l__BullControls__96.Down, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
				Position = UDim2.new(0.5, 0, 1, 0)
			}):Play();
		end;
		if v95.Steer == 1 then
			game:GetService("TweenService"):Create(l__BullControls__96.Right, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
				Position = UDim2.new(1, 10, 0.5, 0)
			}):Play();
		elseif v95.Steer == -1 then
			game:GetService("TweenService"):Create(l__BullControls__96.Left, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
				Position = UDim2.new(0, -10, 0.5, 0)
			}):Play();
		else
			game:GetService("TweenService"):Create(l__BullControls__96.Right, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
				Position = UDim2.new(1, 0, 0.5, 0)
			}):Play();
			game:GetService("TweenService"):Create(l__BullControls__96.Left, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
				Position = UDim2.new(0, 0, 0.5, 0)
			}):Play();
		end;
		if _G.updateBullAnimation == false then
			_G.updateBullAnimation = true;
			while true do
				wait(0.1);
				if game.Players.LocalPlayer.Character.Humanoid.Sit == false then
					break;
				end;			
			end;
			_G.updateBullAnimation = false;
			l__BullControls__96.Visible = false;
			return;
		end;
	else
		if p59 == "FLAG_LOCATION" then
			local v108 = ... 
			if _G.FLAGLOCATION == nil then
				_G.FLAGLOCATION = {} 
			end 
			if _G.FLAGLOCATION[v108] ~= true then
				_G.FLAGLOCATION[v108] = true 
				while true do
					if (Character.HumanoidRootPart.Position - v108.Main.Position).magnitude > 0 then
						local v109 = game:GetService("ReplicatedStorage").DotGui:Clone() 
						v109.Dot.ImageColor3 = v108.Wedge.Color 
						v109.Enabled = true 
						v109.Active = true 
						v109.Parent = v108.Main 
						game:GetService("TweenService"):Create(v109, TweenInfo.new(1, Enum.EasingStyle.Linear), {
							Size = UDim2.new(0, 1, 0, 1)
						}):Play() 
						game:GetService("Debris"):AddItem(v109, 1) 
					end 
					task.wait(1.5) 
					if v108.Main.Anchored == true then
						break 
					end 				
				end 
				_G.FLAGLOCATION[v108] = false 
				return 
			end 
		else
			if p59 == "BAGGED" then
				local v112 = Instance.new("TextLabel") 
				v112.AnchorPoint = Vector2.new(0.5, 0) 
				v112.Position = UDim2.new(0.5, 0, 0.5, 0) 
				v112.BackgroundTransparency = 1 
				v112.Text = ... .. " bagged you" 
				v112.TextColor3 = Color3.new(1, 0, 0) 
				v112.TextSize = 35 
				v112.Font = Enum.Font.SourceSans 
				v112.Parent = MainScreenGui 
				wait(1) 
				game:GetService("TweenService"):Create(v112, TweenInfo.new(1, Enum.EasingStyle.Linear), {
					TextTransparency = 1
				}):Play() 
				wait(1) 
				v112:Destroy() 
				return 
			end 
			if p59 == "ExplodeRadius" then
				local v114, v115 = ... 
				for v116 = 1, 15 do
					if (Character.LowerTorso.Position - v114).magnitude <= v115 then
						local v117 = (1 - (Character.LowerTorso.Position - v114).magnitude / v115) * 2 
						Character.Humanoid.CameraOffset = Vector3.new(v117 * math.random(), v117 * math.random(), v117 * math.random()) 
					end 
					task.wait() 
				end 
				Character.Humanoid.CameraOffset = Vector3.new(0, 0, 0) 
				return 
			end 
			if p59 == "FLASHBANG" then
				local v113 = Character.Humanoid:LoadAnimation(script.FBAnimation) 
				v113:Play(0.100000001, 1, 0.5) 
				local v114 = Instance.new("Sound") 
				v114.SoundId = "rbxassetid://8754837104" 
				v114.Volume = 0.25 
				v114.Parent = script 
				v114:Play() 
				local v115 = Instance.new("Frame") 
				v115.Visible = true 
				v115.Size = UDim2.new(1, 0, 1, 0) 
				v115.Name = "whiteScreen" 
				v115.BackgroundColor3 = Color3.new(1, 1, 1) 
				v115.BorderSizePixel = 0 
				v115.BackgroundTransparency = 1 
				v115.Parent = MainScreenGui 
				game:GetService("TweenService"):Create(v115, TweenInfo.new(0.5, Enum.EasingStyle.Elastic), {
					BackgroundTransparency = 0
				}):Play() 
				wait(3) 
				game:GetService("TweenService"):Create(v115, TweenInfo.new(5, Enum.EasingStyle.Linear), {
					BackgroundTransparency = 1
				}):Play() 
				wait(5) 
				v113:Stop() 
				v114:Destroy() 
				v115:Destroy() 
				return 
			end 
			if p59 == "CartRide" then
				local SeatPart = Character.Humanoid.SeatPart
				if SeatPart and SeatPart:IsA("VehicleSeat") and SeatPart.Parent:FindFirstChild("RTWheel") then
					CartRide:Play(0.100000001, 1, 0)
					while Character.Humanoid.SeatPart == SeatPart do
						if SeatPart.Throttle == 1 then
							CartRide:AdjustSpeed(1)
						elseif SeatPart.Throttle == -1 then
							CartRide:AdjustSpeed(-1)
						elseif SeatPart.Throttle == 0 then
							CartRide:AdjustSpeed(0)
						end
						RunService.Heartbeat:wait()					
					end
					CartRide:Stop()
					return
				end
			end
			if p59 == "Bicycling" then
				local SeatPart = Character.Humanoid.SeatPart 
				if SeatPart and SeatPart:IsA("VehicleSeat") and SeatPart.Parent:FindFirstChild("BikeModel") then
					Bicycling:Play(0.100000001, 1, 0) 
					while Character.Humanoid.SeatPart == SeatPart do
						if SeatPart.Throttle == 1 then
							Bicycling:AdjustSpeed(1) 
						elseif SeatPart.Throttle == -1 then
							Bicycling:AdjustSpeed(-1) 
						else
							Bicycling:AdjustSpeed(0) 
						end 
						RunService.Heartbeat:wait() 					
					end 
					Bicycling:Stop() 
					return 
				end 
			else
				if p59 == "SNOWBALL_EFFECTS" then
					local v117 = Instance.new("ImageLabel") 
					local v118 = math.random() * 0.2 + 0.5 
					v117.Size = UDim2.new(v118, 0, v118, 0) 
					v117.Position = UDim2.new(math.random() - v118 / 2, 0, math.random() - v118 / 2, 0) 
					v117.SizeConstraint = Enum.SizeConstraint.RelativeXX 
					v117.Transparency = 1 
					v117.Image = "http://www.roblox.com/asset/?id=" .. u25[math.random(1, #u25)] 
					v117.Parent = MainScreenGui.SNOWBALLFRAME 
					game:GetService("Debris"):AddItem(v117, 5 + math.random() * 2) 
					for v119 = 1, 20 do
						local v120 = Instance.new("ImageLabel") 
						local v121 = math.random() * 0.05 + 0.05 
						v120.Size = UDim2.new(v121, 0, v121, 0) 
						v120.Position = UDim2.new(math.random() - v121 / 2, 0, math.random() - v121 / 2, 0) 
						v120.SizeConstraint = Enum.SizeConstraint.RelativeXX 
						v120.Transparency = 1 
						v120.Image = "http://www.roblox.com/asset/?id=" .. u26[math.random(1, #u26)] 
						v120.Parent = u26 
						game:GetService("Debris"):AddItem(v120, 3 + math.random() * 6) 
					end 
					return 
				end 
				if p59 == "AddSelectionToItem" then
					local v122, v123 = ... 
					if v122 then
						if v123:FindFirstChild("SelectionBox") == nil then
							local v124 = Instance.new("SelectionBox") 
							v124.Name = "SelectionBox" 
							v124.LineThickness = 0.02 
							v124.Color3 = BrickColor.Green().Color 
							v124.SurfaceTransparency = 0.75 
							v124.SurfaceColor3 = BrickColor.Green().Color 
							v124.Adornee = v123 
							v124.Parent = v123 
							local v125 = Instance.new("BillboardGui") 
							v125.Name = "BillboardGui" 
							v125.AlwaysOnTop = true 
							v125.Size = UDim2.new(3, 0, 3, 0) 
							local v126 = Instance.new("TextLabel") 
							v126.BackgroundTransparency = 1 
							v126.TextScaled = true 
							v126.Size = UDim2.new(1, 0, 1, 0) 
							v126.Text = "$" .. MainModule.AddComma(v123.Price.Value) 
							v126.Font = Enum.Font.GothamBold 
							v126.TextStrokeColor3 = Color3.new(0, 0, 0) 
							v126.TextStrokeTransparency = 0 
							v126.TextColor3 = BrickColor.Green().Color 
							v126.Parent = v125 
							v125.Parent = v123 
							return 
						end 
					elseif v123:FindFirstChild("SelectionBox") then
						v123.SelectionBox:Destroy() 
						v123.BillboardGui:Destroy() 
						return 
					end 
				elseif p59 == "SelectionBoxAdd" then
					local v127, v128 = ... 
					if v128 then
						if v127:FindFirstChild("SelectionBox") == nil then
							local v129 = false 
							if v127.Parent.Name ~= "Apartment" then
								v129 = true 
								local v130 = Instance.new("BillboardGui") 
								v130.Name = "BillboardGui" 
								v130.AlwaysOnTop = true 
								v130.Size = UDim2.new(3, 0, 3, 0) 
								local v131 = Instance.new("TextLabel") 
								v131.BackgroundTransparency = 1 
								v131.TextScaled = true 
								v131.Size = UDim2.new(1, 0, 1, 0) 
								v131.Text = v127.Parent.Name .. "'s House" 
								v131.Font = Enum.Font.SourceSansItalic 
								v131.TextColor3 = Color3.new(1, 1, 1) 
								v131.Parent = v130 
								v130.Parent = v127 
							else
								local v132 = Instance.new("BillboardGui") 
								v132.Name = "BillboardGui" 
								v132.AlwaysOnTop = true 
								v132.Size = UDim2.new(3, 0, 3, 0) 
								local v133 = Instance.new("TextLabel") 
								v133.BackgroundTransparency = 1 
								v133.TextScaled = true 
								v133.Size = UDim2.new(1, 0, 1, 0) 
								v133.Text = "Rent FREE"
								v133.Font = Enum.Font.GothamBold 
								v133.TextStrokeColor3 = Color3.new(0, 0, 0) 
								v133.TextStrokeTransparency = 0 
								v133.TextColor3 = BrickColor.Green().Color 
								v133.Parent = v132 
								v132.Parent = v127 
							end 
							local v134 = Instance.new("SelectionBox") 
							v134.Name = "SelectionBox" 
							v134.LineThickness = 0.02 
							v134.Color3 = v129 and BrickColor.Red().Color or BrickColor.Green().Color 
							v134.SurfaceTransparency = 0.75 
							v134.SurfaceColor3 = v129 and BrickColor.Red().Color or BrickColor.Green().Color 
							v134.Adornee = v127 
							v134.Parent = v127 
							return 
						end 
					else
						if v127:FindFirstChild("SelectionBox") then
							v127.SelectionBox:Destroy() 
						end 
						if v127:FindFirstChild("BillboardGui") then
							v127.BillboardGui:Destroy() 
							return 
						end 
					end 
				else
					if p59 == "ReportSent" then
						local v135 = Instance.new("TextLabel") 
						v135.Text = "Report sent!" 
						v135.Name = "Report SENTED!" 
						v135.BackgroundColor3 = BrickColor.Red().Color 
						v135.Size = UDim2.new(0.3, 0, 0.1, 0) 
						v135.TextScaled = true 
						v135.Position = UDim2.new(0.5, 0, 0.5, 0) 
						v135.AnchorPoint = Vector2.new(0.5, 0.5) 
						v135.Parent = MainScreenGui 
						game:GetService("TweenService"):Create(v135, TweenInfo.new(1), {
							BackgroundTransparency = 1
						}):Play() 
						wait(1) 
						v135:Destroy() 
						return 
					end 
					if p59 == "CheckPlayerClose" then
						if _G.GUN_COMBAT_TOGGLE then
							for v136, v137 in pairs(workspace.Players:GetChildren()) do
								if v137 ~= Character and v137:FindFirstChild("Humanoid") and v137.Humanoid.Health > 0 and v137:FindFirstChild("UpperTorso") and (v137.UpperTorso.Position - Character.UpperTorso.Position).magnitude < 5 then
									MainEvent:FireServer("GunCombatToggle", true) 
									return 
								end 
							end 
							MainEvent:FireServer("GunCombatToggle", false) 
							return 
						else
							MainEvent:FireServer("GunCombatToggle", false) 
							return 
						end 
					end 
					if p59 == "BOOMBOX" then
						local v138 = ... 
						MainScreenGui.BoomboxFrame.TextButton.MouseButton1Click:connect(function()
							MainEvent:FireServer("Boombox", MainScreenGui.BoomboxFrame.TextBox.Text) 
						end) 
						MainScreenGui.BoomboxFrame.TextButton2.MouseButton1Click:connect(function()
							MainEvent:FireServer("BoomboxStop") 
						end) 
						MainScreenGui.BoomboxFrame.Visible = true 
						v138.Equipped:connect(function()
							MainScreenGui.BoomboxFrame.Visible = true 
						end) 
						v138.Unequipped:connect(function()
							MainScreenGui.BoomboxFrame.Visible = false 
						end) 
						return 
					end 
					if p59 == "updateCrewStuff" then
						updateCrewStuff() 
						return 
					end 
					if p59 == "SecurityCamera" then
						local l__CFrame__139 = (...).Eye.CFrame 
						CurrentCamera.CameraType = Enum.CameraType.Scriptable 
						CurrentCamera.CFrame = CFrame.new(l__CFrame__139.Position, l__CFrame__139.Position + l__CFrame__139.upVector) 
						MainScreenGui.SecurityCamera.Visible = true 
						local u29 = nil 
						u29 = Character.Humanoid.Jumping:connect(function()
							u29:disconnect() 
							MainScreenGui.SecurityCamera.Visible = false 
							CurrentCamera.CameraType = Enum.CameraType.Custom 
						end) 
						return 
					end 
					if p59 == "FireworkText" then
						if MainScreenGui:FindFirstChild("Fireworktext_") then
							return 
						else
							local v140 = Instance.new("TextBox") 
							v140.Name = "Fireworktext_" 
							v140.Size = UDim2.new(0, 300, 0, 50) 
							v140.BackgroundColor3 = Color3.new(1, 1, 1) 
							v140.BorderSizePixel = 0 
							v140.AnchorPoint = Vector2.new(0.5, 0.5) 
							v140.Position = UDim2.new(0.5, 0, 0.5, 0) 
							v140.Text = "Write anything less than 40 characters" 
							local v141 = Instance.new("TextButton") 
							v141.AnchorPoint = Vector2.new(0.5, 0) 
							v141.Position = UDim2.new(0.5, 0, 1.25, 0) 
							v141.BorderSizePixel = 0 
							v141.Size = UDim2.new(0.5, 0, 1, 0) 
							v141.Text = "CONFIRM" 
							v141.Font = Enum.Font.SourceSansSemibold 
							v141.TextSize = 30 
							v141.TextStrokeTransparency = 0 
							v141.TextColor3 = Color3.new(1, 1, 1) 
							v141.TextStrokeColor3 = Color3.new(0, 0, 0) 
							v141.BackgroundColor3 = Color3.new(0.333333, 1, 0.498039) 
							v141.Parent = v140 
							local v142 = Instance.new("UICorner") 
							v142.CornerRadius = UDim.new(0.5, 0) 
							v142.Parent = v141 
							v142:Clone().Parent = v140 
							v140.Parent = MainScreenGui 
							v140.Changed:connect(function()
								v140.Text = string.sub(v140.Text, 0, 40) 
							end) 
							local u30 = false 
							v141.Activated:connect(function()
								MainEvent:FireServer("FireworkText", v140.Text) 
								u30 = true 
							end) 
							while true do
								RunService.Heartbeat:wait() 
								if Character:FindFirstChild("[Firework]") == nil then
									break 
								end 
								if u30 == true then
									break 
								end 							
							end 
							v140:Destroy() 
							return 
						end 
					else
						if p59 == "EXPLODE_FIREWORK" then
							local v143, v144 = ... 
							FireworksModule:Fire(v143, v144) 
							return 
						end 
						if p59 == "DropMoney" then
							if ... == false then
								MainScreenGui.MoneyDrop.Visible = false 
							else
								MainScreenGui.MoneyDrop.Visible = not MainScreenGui.MoneyDrop.Visible 
							end 
							if not _G.MoneyDropConnections then
								_G.MoneyDropConnections = true 
								local u31 = false 
								MainScreenGui.MoneyDrop.TextButton.MouseButton1Click:connect(function()
									if u31 == false then
										u31 = true
										MainEvent:FireServer("DropMoney", MainScreenGui.MoneyDrop.TextBox.Text) 
										wait(0.1)
										u31 = false 
									end 
								end) 
							end 
						end 
					end 
				end 
			end 
		end 
	end 
end) 

local LocalPlayer = game.Players.LocalPlayer
local Settings = game.StarterGui.MainScreenGui.Crew.SecondLayer.AimTrainerGrounds 
local TPFrame = game.StarterGui["ATG TPFRAME"]
local Place = 157382392
local TeleportService = game:GetService("TeleportService")


game.StarterGui.MainScreenGui.Crew.SecondLayer.AimTrainerGrounds.Activated:Connect(function()
	print("Activated")
	TPFrame.Enabled = not TPFrame.Enabled
end)

local wait_1 = 0.5

game.StarterGui["ATG TPFRAME"].Teleport.TextButton.Activated:Connect(function()
	print("Activated")
	spawn(function()
		TeleportService:Teleport(Place, LocalPlayer)
	end)
	game.StarterGui.TELEPORTGUI.TeleportGUI.Visible = true
	spawn(function()
		for i = 1, math.huge do
			task.wait(wait_1)
			game.StarterGui.TELEPORTGUI.TeleportGUI.Littledots.Text = ".."
			task.wait(wait_1)
			game.StarterGui.TELEPORTGUI.TeleportGUI.Littledots.Text = "..."
			task.wait(wait_1)
			game.StarterGui.TELEPORTGUI.TeleportGUI.Littledots.Text = ".."
			task.wait(wait_1)
			game.StarterGui.TELEPORTGUI.TeleportGUI.Littledots.Text = "."
		end
	end)
end)

MainScreenGui:WaitForChild("GunCombatToggle") 
if _G.GUN_COMBAT_TOGGLE then
	MainScreenGui.GunCombatToggle.BackgroundColor3 = Color3.fromRGB(176, 255, 102) 
else
	MainScreenGui.GunCombatToggle.BackgroundColor3 = Color3.fromRGB(255, 108, 89) 
end 
MainScreenGui.GunCombatToggle.MouseButton1Click:connect(function()
	_G.GUN_COMBAT_TOGGLE = not _G.GUN_COMBAT_TOGGLE 
	if _G.GUN_COMBAT_TOGGLE then
		MainScreenGui.GunCombatToggle.BackgroundColor3 = Color3.fromRGB(176, 255, 102) 
		return 
	end 
	MainScreenGui.GunCombatToggle.BackgroundColor3 = Color3.fromRGB(255, 108, 89) 
end) 
MainScreenGui.AmmoFrame:WaitForChild("Frame") 
Character.ChildAdded:connect(function(p61)
	if p61:IsA("Tool") then
		local v145 = MainModule.GunHold(Character) 
		if v145 then
			for v146, v147 in pairs(MainScreenGui.AmmoFrame.Frame:GetChildren()) do
				if v147:IsA("ImageLabel") then
					v147:Destroy() 
				end 
			end 
			local maxammoXD = v145[1].MaxAmmo
			for v149 = 1, maxammoXD.Value do
				local v150 = game:GetService("ReplicatedStorage").AmmoG:Clone() 
				v150.Name = maxammoXD.Value + 1 - v149 
				v150.Parent = MainScreenGui.AmmoFrame.Frame 
			end 
		end 
	end 
end) 
RunService:BindToRenderStep("GunAmmo", Enum.RenderPriority.Last.Value - 1, function()
	local v151 = MainModule.GunHold(Character) 
	if v151 then
		if MainScreenGui.AmmoFrame.Visible == false then
			MainScreenGui.AmmoFrame.Visible = true 
		end 
		if v151[1] then
			local l__Value__152 = v151[1].Ammo.Value
			MainScreenGui.AmmoFrame.AmmoText.Text = "∞"
			local maxammoXD = v151[1].MaxAmmo
			for v154 = 1, maxammoXD.Value do
				if v154 <= l__Value__152 then
					MainScreenGui.AmmoFrame.Frame[tostring(v154)].ImageColor3 = Color3.fromRGB(255, 255, 255) 
				else
					MainScreenGui.AmmoFrame.Frame[tostring(v154)].ImageColor3 = Color3.fromRGB(121, 121, 121) 
				end 
			end 
			return 
		end 
	elseif MainScreenGui.AmmoFrame.Visible == true then
		MainScreenGui.AmmoFrame.Visible = false 
	end 
end) 
_G.TimerMoney = _G.TimerMoney or tick() 
Character:WaitForChild("Humanoid") 
local u32 = {
	Timer = tick(), 
	Time = 0
} 
local u33 = false 
Character.Humanoid.Jumping:connect(function()
	if tick() - u32.Timer > 2 then
		u32.Time = 0 
	end 
	u32.Time = u32.Time + 1 
	u32.Timer = tick() 
	if u32.Time > 4 and u33 == false then
		u33 = true 
		wait(1.5) 
		u33 = false 
	end 
end) 

local function u34(p62, p63)
	if LocalPlayer.DataFolder.CursorImage.Value ~= "" then
		MainScreenGui.Aim.CursorImage.Image = ("rbxthumb://type=Asset&id=%s&w=420&h=420"):format(LocalPlayer.DataFolder.CursorImage.Value);
		MainScreenGui.Aim.BackgroundTransparency = 1;
		MainScreenGui.Aim.CursorImage.Visible = true;
		MainScreenGui.Aim.Top.Visible = false;
		MainScreenGui.Aim.Bottom.Visible = false;
		MainScreenGui.Aim.Right.Visible = false;
		MainScreenGui.Aim.Left.Visible = false;
	else
		MainScreenGui.Aim.BackgroundTransparency = 0;
		MainScreenGui.Aim.CursorImage.Visible = false;
		MainScreenGui.Aim.Top.Visible = true;
		MainScreenGui.Aim.Bottom.Visible = true;
		MainScreenGui.Aim.Right.Visible = true;
		MainScreenGui.Aim.Left.Visible = true;
	end;
	if p62 then
		_G.Aimed = true 
		_G.UpdateAimed(true) 
		MainScreenGui.Aim.Visible = true 
		MainScreenGui.Aim.CursorImage.Size = MainScreenGui.Aim.CursorImage.Size:lerp(UDim2.new(0, 20, 0, 20), 0.8);
		MainScreenGui.Aim.Top.Position = MainScreenGui.Aim.Top.Position:lerp(UDim2.new(0.5, 0, 0.5, -9), 0.8) 
		MainScreenGui.Aim.Bottom.Position = MainScreenGui.Aim.Bottom.Position:lerp(UDim2.new(0.5, 0, 0.5, 9), 0.8) 
		MainScreenGui.Aim.Right.Position = MainScreenGui.Aim.Right.Position:lerp(UDim2.new(0.5, 9, 0.5, 0), 0.8) 
		MainScreenGui.Aim.Left.Position = MainScreenGui.Aim.Left.Position:lerp(UDim2.new(0.5, -9, 0.5, 0), 0.8) 
		if not _G.MobileShiftLock then
			MainScreenGui.Aim.Position = UDim2.new(0, Mouse.x, 0, Mouse.y) 
		else
			MainScreenGui.Aim.Position = UDim2.new(0.5, 0, 0.5, -19) 
		end 
		Mouse.Icon = "rbxassetid://33410686" 
		if not SmallGunAim.IsPlaying then
			SmallGunAim:Play() 
			return 
		end 
	else
		_G.Aimed = false 
		local v155
		if p63 then
			v155 = true 
		else
			v155 = false 
		end 
		MainScreenGui.Aim.Visible = v155 
		MainScreenGui.Aim.CursorImage.Size = MainScreenGui.Aim.CursorImage.Size:lerp(UDim2.new(0, 28, 0, 28), 1);
		MainScreenGui.Aim.Top.Position = MainScreenGui.Aim.Top.Position:lerp(UDim2.new(0.5, 0, 0.5, -15), 1) 
		MainScreenGui.Aim.Bottom.Position = MainScreenGui.Aim.Bottom.Position:lerp(UDim2.new(0.5, 0, 0.5, 15), 1) 
		MainScreenGui.Aim.Right.Position = MainScreenGui.Aim.Right.Position:lerp(UDim2.new(0.5, 15, 0.5, 0), 1) 
		MainScreenGui.Aim.Left.Position = MainScreenGui.Aim.Left.Position:lerp(UDim2.new(0.5, -15, 0.5, 0), 1) 
		if not _G.MobileShiftLock then
			MainScreenGui.Aim.Position = UDim2.new(0, Mouse.x, 0, Mouse.y) 
		else
			MainScreenGui.Aim.Position = UDim2.new(0.5, 0, 0.5, -19) 
		end 
		local v156
		if p63 then
			v156 = "rbxassetid://33410686" 
		else
			v156 = "" 
		end 
		Mouse.Icon = v156 
		if SmallGunAim.IsPlaying then
			SmallGunAim:Stop() 
			_G.UpdateAimed(false) 
		end 
	end 
end 

local CoolNumber = nil;
function CursorImageCheck()
	return tonumber(CoolNumber);
end;
local l__MarketplaceService__109 = game:GetService("MarketplaceService");
function findImageDecal(p73)
	local u110 = nil;
	local u111 = p73;
	pcall(function()
		u110 = l__MarketplaceService__109:GetProductInfo(u111);
	end);
	if not u110 then
		return false;
	end;
	MainScreenGui.Crew.Settings.ScrollingFrame.Cursor.ImageLabel.Image = "rbxassetid://16564647540";
	while true do
		if p73 - u111 < 20 then

		else
			break;
		end;
		local u112 = nil;
		pcall(function()
			u112 = l__MarketplaceService__109:GetProductInfo(u111);
		end);
		if u112 then
			if u112.AssetTypeId == 1 then
				if u112.Creator.Id == u112.Creator.Id then
					return p73;
				end;
			end;
		end;
		u111 = u111 - 1;
		if (p73 - u111) % 25 == 0 then
			task.wait();
		end;
		if (p73 - u111) % 2 == 0 then
			MainScreenGui.Crew.Settings.ScrollingFrame.Cursor.ImageLabel.BackgroundColor3 = Color3.new(1, 0, 0);
		else
			MainScreenGui.Crew.Settings.ScrollingFrame.Cursor.ImageLabel.BackgroundColor3 = Color3.fromRGB(70, 70, 70);
		end;
	end;
	return false;
end;
local u113 = false;
local function u114(p74)
	MainScreenGui.Crew.Settings.ScrollingFrame.Cursor.ImageLabel.BackgroundColor3 = Color3.fromRGB(70, 70, 70);
	if p74 and tonumber(p74) and p74 ~= "no cursor" and p74 ~= nil and p74 ~= 0 then
		MainScreenGui.Crew.Settings.ScrollingFrame.Cursor.TextBox.Text = p74;
		MainScreenGui.Crew.Settings.ScrollingFrame.Cursor.ImageLabel.Image = ("rbxthumb://type=Asset&id=%s&w=420&h=420"):format(p74);
		MainScreenGui.Aim.CursorImage.Image = ("rbxthumb://type=Asset&id=%s&w=420&h=420"):format(p74);
		MainEvent:FireServer("UpdateCursorImage", p74);

		return;
	end;
	MainScreenGui.Crew.Settings.ScrollingFrame.Cursor.TextBox.Text = "Enter a valid Image-ID";
	MainScreenGui.Crew.Settings.ScrollingFrame.Cursor.ImageLabel.Image = "rbxassetid://16564652394";
end;
MainScreenGui.Crew.Settings.Close.Activated:Connect(function()
	MainScreenGui.Crew.Settings.Visible = false
end)
MainScreenGui.Crew.Settings.ScrollingFrame.Cursor.TextBox.FocusLost:connect(function()
	if u113 == false then
		u113 = true;
		MainScreenGui.Crew.Settings.ScrollingFrame.Cursor.TextBox.Active = false;
		MainScreenGui.Crew.Settings.ScrollingFrame.Cursor.TextBox.TextEditable = false;
		local l__Text__495 = MainScreenGui.Crew.Settings.ScrollingFrame.Cursor.TextBox.Text;
		MainScreenGui.Crew.Settings.ScrollingFrame.Cursor.TextBox.Text = "Searching: " .. l__Text__495;
		if tonumber(l__Text__495) then
			u114((findImageDecal(tonumber(l__Text__495))));
		else
			u114(nil);
		end;
		MainScreenGui.Crew.Settings.ScrollingFrame.Cursor.TextBox.Active = true;
		MainScreenGui.Crew.Settings.ScrollingFrame.Cursor.TextBox.TextEditable = true;
		u113 = false;
	end;
end);
local u35 = false 
local u36 = false 
local BRWon = false 
local u38 = tick() 
local u39 = {} 
local u40 = 0 
local u42 = false 
RunService.Heartbeat:connect(function()
	pcall(function()
		local v158 = 16 
		local v159 = 50 
		if BodyEffects.Movement:findFirstChild("SuperSpeed") then
			v158 = 70 
		end 
		if BodyEffects.Movement:findFirstChild("FasterSpeed") then
			v158 = 28 
		end 
		if BodyEffects.Movement:findFirstChild("KatanaWalk") then
			v158 = 34 
		end 
		if BodyEffects.Movement:findFirstChild("SpeedBoost") then
			v158 = 18 
		end 
		if BodyEffects.Movement:findFirstChild("HamonSpeed") then
			v158 = 40
		end 
		if BodyEffects.Movement:findFirstChild("KnifeSpeed") then
			v158 = 20
			v159 = 57
		end 
		if BodyEffects.Movement:findFirstChild("HighJump") then
			v159 = 75 
		end 
		if u12 or Character.Head:FindFirstChild("GOT_PEPPER_SPRAY") then
			v158 = v158 * 0.4 
		end 
		if Character.Head:FindFirstChild("GOT_PEPPER_SPRAY") then
			if MainScreenGui.PepperSpray.Visible == false then
				MainScreenGui.PepperSpray.Visible = true
				game.Lighting.PepperSprayBlur.Enabled = true 
			end 
			local v160 = tick() / 2 % 1 
			MainScreenGui.PepperSpray.BackgroundTransparency = 0.6 + v160 * 0.2 
			MainScreenGui.PepperSpray.BackgroundColor3 = Color3.fromRGB(255, 33, 33):Lerp(Color3.fromRGB(255, 120, 75), v160) 
			local v161 = tick() * 10 
			game.Lighting.PepperSprayBlur.Size = 8 + (math.floor(v161 / 6) % 2 == 0 and v161 % 6 or 6 - v161 % 6) 
		elseif MainScreenGui.PepperSpray.Visible == true then
			MainScreenGui.PepperSpray.Visible = false 
			game.Lighting.PepperSprayBlur.Enabled = false 
		end 
		if Character.Humanoid.Health < 55 then
			v158 = v158 * 0.8 
		end 
		if BodyEffects.Grabbed.Value ~= nil then
			v158 = v158 - 4 
		end 
		if not u12 and u6 and Character.Humanoid.Health > 55 and Character.Humanoid.MoveDirection.magnitude > 0 and BodyEffects["K.O"].Value == false and BodyEffects.Movement:FindFirstChild("NoWalkSpeed") == nil and BodyEffects.Movement:FindFirstChild("ReduceWalk") == nil and (BodyEffects.Movement:FindFirstChild("NoJumping") == nil and BodyEffects:FindFirstChild("Block") == nil) then
			local v162 = false 
			if BodyEffects:findFirstChild("Symbiote") and BodyEffects.Symbiote.Value == false then
				v162 = true 
			end 
			if not v162 then
				v158 = v158 + 6 
				if BodyEffects.Movement:findFirstChild("SuperSpeed") then
					v158 = v158 + 30 
				end 
				if BodyEffects.Movement:findFirstChild("FasterSpeed") then
					v158 = v158 + 9
				end 
				if BodyEffects.Movement:findFirstChild("HamonSpeed") then
					v158 = v158 + 12
				end 
				if BodyEffects.Movement:findFirstChild("FastSprint") then
					v158 = v158 + 9 
				end 
				if BodyEffects.Movement:findFirstChild("KatanaWalk") then
					v158 = v158 + 8
				end 
				if BodyEffects.Movement:findFirstChild("SpeedBoost") then
					v158 = v158 + 1 
				end 
			end 
		end 

		if AutoShoot then
			if MainModule.GunHold(Character) then
				Character:FindFirstChildOfClass("Tool"):Activate()
			end
		end
		if BodyEffects:FindFirstChild("Block") then
			v158 = 5 
		end 
		if BodyEffects["K.O"].Value == true or BodyEffects.Movement:FindFirstChild("NoWalkSpeed") then
			v158 = 0 
		end 
		if BodyEffects.Movement:FindFirstChild("HulkJump") then
			v159 = 90 
		end 
		if BodyEffects["K.O"].Value == true or (BodyEffects.Movement:FindFirstChild("NoJumping") or u33) then
			v159 = 0 
		end 
		if BodyEffects.Movement:FindFirstChild("ReduceWalk") or BodyEffects.Reload.Value == true then
			v158 = v158 - 5 
		end
		local v163 = math.max(0, v158) 
		_G.CurrentWS = v163 
		Character.Humanoid.WalkSpeed = v163 
		Character.Humanoid.JumpPower = math.max(0, v159) 
		MainScreenGui.Bar.Energy.bar.Size = UDim2.new(BodyEffects.Defense.Value / 100 * 0.95, 0, 0.83, 0) 
		MainScreenGui.Bar.Armor.bar.Size = UDim2.new(BodyEffects.Armor.Value / game:GetService("ReplicatedStorage").Values.MaxArmor.Value * 0.95, 0, 0.83, 0) 
		MainScreenGui.Bar.HP.bar.Size = UDim2.new(Character.Humanoid.Health / Character.Humanoid.MaxHealth * 0.95, 0, 0.83, 0) 
		MainScreenGui.Bar.HP.bar.Size = UDim2.new(Character.Humanoid.Health / Character.Humanoid.MaxHealth * 0.95, 0, 0.83, 0) 
		MainScreenGui.Bar.HP.Amount.Text =  math.floor(Character.Humanoid.Health).."/"..math.floor(Character.Humanoid.MaxHealth)
		if LocalPlayer.DataFolder.Information.ArmorSave.Value > 0 then
			MainScreenGui.Bar.Armor.Amount.Text = math.floor(LocalPlayer.DataFolder.Information.ArmorSave.Value).."/"..math.floor(ReplicatedStorage.Values.MaxArmor.Value)
		else
			MainScreenGui.Bar.Armor.Amount.Text = math.floor(BodyEffects.Armor.Value).."/"..math.floor(ReplicatedStorage.Values.MaxArmor.Value)
		end
		if u12 then
			if not Crouching.IsPlaying then
				Crouching:Play() 
			end 
			if Character.Humanoid.MoveDirection.magnitude > 0 then
				Crouching:AdjustSpeed(1) 
			else
				Crouching:AdjustSpeed(0) 
			end 
		elseif Crouching.IsPlaying then
			Crouching:Stop() 
		end 
		if CombatLogTimer ~= 0 then
			CombatLog.Visible = true

			if COOLDOWN == false then
				task.spawn(function()
					COOLDOWN = true
					local CombatTweeInfo = TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)

					local Tween = TweenService:Create(CombatLog, CombatTweeInfo, { TextTransparency = 1 })
					local Tween3 = TweenService:Create(CombatLog.UIStroke, CombatTweeInfo, { Transparency = 1 })
					local Tween2 = TweenService:Create(CombatLog, CombatTweeInfo, { TextTransparency = 0 })
					local Tween4 = TweenService:Create(CombatLog.UIStroke, CombatTweeInfo, { Transparency = 0 })

					Tween:Play()
					Tween3:Play()
					Tween.Completed:Wait()

					Tween2:Play()
					Tween4:Play()
					Tween2.Completed:Wait()

					COOLDOWN = false
				end)
			end

			if BodyEffects.Dead.Value == true then
				CombatLogTimer = 0
			end

			if TIMERCOOLDOWN == false then
				task.spawn(function()
					TIMERCOOLDOWN = true
					CombatLogTimer -= 1
					wait(1)
					TIMERCOOLDOWN = false
				end)
			end
		else
			if CombatLog.Visible == true then
				CombatLog.Visible = false
			end
		end
		local v164 = MainModule.GunHold(Character) 
		_G.HoldGunBool = v164 
		if v164 and BodyEffects:FindFirstChild("Block") == nil then
			local v165 = nil
			if _G.MobileShiftLock then
				v165 = CurrentCamera.CFrame.p + CurrentCamera.CFrame.LookVector * 60 
			else
				v165 = Mouse.Hit.p 
			end 
			MainEvent:FireServer("UpdateMousePos", v165) 
			if MainModule.IsMobile() then
				MainScreenGui.ShootButton.Visible = true 
			end 
			if u9 then
				u34(true, nil) 
			else
				u34(false, true) 
			end 
			MainScreenGui.GunCombatToggle.Visible = false 
		else
			MainScreenGui.ShootButton.Visible = false 
			MainScreenGui.GunCombatToggle.Visible = false 
			u34(false) 
		end 
		if tick() - _G.TimerMoney > 360 then
			_G.TimerMoney = tick() 
			MainEvent:FireServer("TimerMoney") 
		end 
		if LocalPlayer.DataFolder.Information.Jail.Value == 1 then
			return
		end
		if MainModule.IsMobile() then
			if not (not Character:FindFirstChild("Combat")) or not (not Character:FindFirstChild("[Pitchfork]")) or not (not Character:FindFirstChild("[Knife]")) or not (not Character:FindFirstChild("katana")) or not (not Character:FindFirstChild("[Bat]")) or not (not Character:FindFirstChild("[Shovel]")) or not (not Character:FindFirstChild("[SledgeHammer]")) or Character:FindFirstChild("[StopSign]") then
				MainScreenGui.ChargeButton.Visible = true 
			else
				MainScreenGui.ChargeButton.Visible = false 
			end 
			if Character:FindFirstChild("[Taser]") then
				MainScreenGui.TaseButton.Visible = true 
			else
				MainScreenGui.TaseButton.Visible = false 
			end 
			MainScreenGui.Leaderboard.Visible = false 
			if u36 == false then
				u36 = true 
				game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false) 
			end 
		else
			MainScreenGui.Leaderboard.Close.Visible = false 
			if u36 then
				u36 = false 
				game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false) 
			end 
		end 
		if _G.Snowing then
			if _G.SnowingDebug == nil then
				_G.SnowingDebug = tick() 
			end 
			local v166 = _G.SnowBlock 
			if v166 == nil then
				v166 = game:GetService("ReplicatedStorage").SnowBlock:Clone() 
				v166.Parent = workspace.Ignored 
				_G.SnowBlock = v166 
			end 
			v166.CFrame = CFrame.new(CurrentCamera.CFrame.p) + Vector3.new(0, 10, 0) + CurrentCamera.CFrame.lookVector * Vector3.new(3, 0, 3) 
			if tick() - _G.SnowingDebug > 0.8 then
				local l__p__167 = CurrentCamera.CFrame.p 
				local v168 = workspace:FindPartOnRayWithWhitelist(Ray.new(Vector3.new(l__p__167.x, 250, l__p__167.z), Vector3.new(0, l__p__167.y - 250, 0)), { workspace.MAP }) 
				if v168 and v168.Material ~= Enum.Material.Grass then
					v166.ParticleEmitter.Enabled = false 
					game.Lighting.SnowBlur.Enabled = false 
				else
					game.Lighting.SnowBlur.Enabled = true 
					v166.ParticleEmitter.Enabled = true 
				end 
				_G.SnowingDebug = tick() 
			end 
		end 
		if LocalPlayer:FindFirstChild("OwnHouseTag") and MainScreenGui.Crew.SecondLayer.Edit.Visible == false then
			MainScreenGui.Crew.SecondLayer.Edit.Visible = true 
		end 
		if Main ~= false then
			local v169 = nil 
			local v170 = CurrentCamera:FindFirstChild(Main[1]) 
			if v170 == nil then
				v170 = game:GetService("ReplicatedStorage").HouseItemSale[Main[1]]:Clone() 
				for v171, v172 in pairs(v170:GetChildren()) do
					if v172:IsA("BasePart") then
						v172.CanCollide = false 
					end 
				end 
				local v173 = Instance.new("SelectionBox") 
				v173.Name = "SelectionBox" 
				v173.Adornee = v170 
				v173.Color3 = BrickColor.Green().Color 
				v173.SurfaceColor3 = BrickColor.Green().Color 
				v173.SurfaceTransparency = 0.5 
				v173.LineThickness = 0.01 
				v173.Parent = v170 
				v170.Parent = CurrentCamera 
			end 
		end
	end) 
end) 

--[[

local MPS = MainScreenGui.MarketPlace

	MainScreenGui.MarketPlace.CancelButton.MouseButton1Click:Connect(function()

	MPS.Visible = false
	end)

  ]]

local InventoryDebounce = false

local InventoryModule = require(ReplicatedStorage.Inventory)
local IconModule = require(ReplicatedStorage.Inventory.Icon)
local FRAMES_LOADED = {}

function UpdateInventoryStuff()
	local InventoryData = game:GetService("HttpService"):JSONDecode(LocalPlayer.DataFolder.Information.InventoryData.Value)
	local EquippedData = game:GetService("HttpService"):JSONDecode(LocalPlayer.DataFolder.Information.EquippedData.Value)

	for i,v in pairs(WeaponSkinsGUI.Holder.Contents.Entries:GetChildren()) do
		if v:IsA("Frame") and v.Name ~= "ItemTemplate" then
			v.Preview.LockImageLabel.Visible = true
			v.Preview.Equipped.Visible = false

			if InventoryData[WeaponSkinsGUI.Title.Text] and InventoryData[WeaponSkinsGUI.Title.Text][v.Name] and InventoryData[WeaponSkinsGUI.Title.Text][v.Name] == true then
				v.Preview.LockImageLabel.Visible = false
			end

			if EquippedData[WeaponSkinsGUI.Title.Text] then
				if v.Name == EquippedData[WeaponSkinsGUI.Title.Text] then
					v.Preview.Equipped.Visible = true
				end
			end
		end
	end
end

local function PurchaseFrame(HowMuchToBuy)
	if InventoryModule[WeaponSkinsGUI.Title.Text] and InventoryModule[WeaponSkinsGUI.Title.Text] ~= "Select" then
		local DIDICLICKIE = false

		if HowMuchToBuy == "Unlock" then
			WeaponSkinsGUI.PurchaseFrame.TextLabel.Text = "Are you sure you would like to buy 1x "..WeaponSkinsGUI.Title.Text.." Crates?"
			WeaponSkinsGUI.PurchaseType.Robux.Text = "ROBUX ("..tostring(InventoryModule[WeaponSkinsGUI.Title.Text].CostUnlock1x).."R$)"
			WeaponSkinsGUI.PurchaseType.Currency.Text = "CASH ("..tostring(InventoryModule[WeaponSkinsGUI.Title.Text].CostUnlockCash1x).."$)"
			WeaponSkinsGUI.PurchaseType.TextLabel.Text = "How do you want to purchase the crate?"
		elseif HowMuchToBuy == "Unlock10x" then
			WeaponSkinsGUI.PurchaseFrame.TextLabel.Text = "Are you sure you would like to buy 10x "..WeaponSkinsGUI.Title.Text.." Crates?"
			WeaponSkinsGUI.PurchaseType.Robux.Text = "ROBUX ("..tostring(InventoryModule[WeaponSkinsGUI.Title.Text].CostUnlock10x).."R$)"
			WeaponSkinsGUI.PurchaseType.Currency.Text = "CASH ("..tostring(InventoryModule[WeaponSkinsGUI.Title.Text].CostUnlockCash10x).."$)"
			WeaponSkinsGUI.PurchaseType.TextLabel.Text = "How do you want to purchase the 10 crates?"
		end

		WeaponSkinsGUI.PurchaseType.Visible = true

		if WeaponSkinsGUI.Title.Text == "Knife Skins" or WeaponSkinsGUI.Title.Text == "Gun Skins" then
			DIDICLICKIE = true
			WeaponSkinsGUI.PurchaseType.Visible = false
			MainScreenGui.ProductPurchaseFrame.Visible = true
			MainScreenGui.ProductPurchaseFrame.Music_Label.Text = "you cannot buy this."
		end

		local RobuxPurchaseConnection = WeaponSkinsGUI.PurchaseType.Robux.Activated:Connect(function()
			DIDICLICKIE = true
			MainEvent:FireServer("PurchaseSkinCrate", InventoryModule[WeaponSkinsGUI.Title.Text], HowMuchToBuy)
			WeaponSkinsGUI.PurchaseType.Visible = false
		end)

		local CashPurchaseConnection = WeaponSkinsGUI.PurchaseType.Currency.Activated:Connect(function()
			DIDICLICKIE = true
			MainEvent:FireServer("PurchaseSkinCrateCash", WeaponSkinsGUI.Title.Text, HowMuchToBuy)
			WeaponSkinsGUI.PurchaseType.Visible = false
		end)

		repeat wait() until DIDICLICKIE ~= false

		if RobuxPurchaseConnection then
			RobuxPurchaseConnection:Disconnect()
		end

		if CashPurchaseConnection then
			CashPurchaseConnection:Disconnect()
		end

		WeaponSkinsGUI.PurchaseType.Visible = false
	end
end

local function LoadInventory(OpenXD)
	if OpenXD == false then
		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)

		local InventoryData = game:GetService("HttpService"):JSONDecode(LocalPlayer.DataFolder.Information.InventoryData.Value)
		local EquippedData = game:GetService("HttpService"):JSONDecode(LocalPlayer.DataFolder.Information.EquippedData.Value)

		for i_,v in pairs(IconModule) do
			if not table.find(FRAMES_LOADED, i_) then
				local CategoryFrame = WeaponSkinsGUI.Categories.Container.Template:Clone()

				CategoryFrame.MouseButton1Click:Connect(function()
					WeaponSkinsGUI.Open1.TextLabel.Text =  "OPEN 1x "..i_.." CRATE"
					WeaponSkinsGUI.Open10.TextLabel.Text = "OPEN 10x "..i_.." CRATE"
					WeaponSkinsGUI.PurchaseFrame.Visible = false
					WeaponSkinsGUI.PurchaseType.Visible = false
					WeaponSkinsGUI.Open1.Visible = true
					WeaponSkinsGUI.Open10.Visible = true

					CategoryFrame.Title.Text = i_

					WeaponSkinsGUI.Title.Text = i_

					for iXD,vXD in pairs(WeaponSkinsGUI.Categories.Container:GetChildren()) do
						if vXD:IsA("TextButton") and vXD:FindFirstChildOfClass("UIStroke") then
							vXD:FindFirstChildOfClass("UIStroke").Enabled = true
							vXD:FindFirstChildOfClass("UIStroke").Thickness = 1.6
							vXD:FindFirstChildOfClass("UIStroke").Transparency = 0.8
							vXD:FindFirstChildOfClass("UIStroke").Color = Color3.new(1, 1, 1)
						end
					end

					CategoryFrame:FindFirstChildOfClass("UIStroke").Enabled = true
					CategoryFrame:FindFirstChildOfClass("UIStroke").Color = Color3.new(0.254902, 1, 0.12549)
					CategoryFrame:FindFirstChildOfClass("UIStroke").Thickness = 2
					CategoryFrame:FindFirstChildOfClass("UIStroke").Transparency = 0.5

					for iXD,vXD in pairs(WeaponSkinsGUI.Holder.Contents.Entries:GetChildren()) do
						if vXD:IsA("Frame") and vXD.Name ~= "ItemTemplate" then
							vXD:Destroy()
						end
					end

					for i,v in pairs(InventoryModule[i_]) do
						if i ~= "Unlock1xID" and i ~= "Unlock10xID" and i ~= "CostUnlock1x" and i ~= "CostUnlock10x" and i ~= "CostUnlockCash1x"and i ~= "CostUnlockCash10x" then
							local ItemFrame = WeaponSkinsGUI.Holder.Contents.Entries.ItemTemplate:Clone()
							ItemFrame.Name = i

							if i_ == "Gun Skins" then
								if i == "Golden Age" or i == "Shadow" or i == "8BIT" or i == "Water" or i == "Kitty" or i == "Tact" or i == "Electricity" or i == "Ice Magic" or i == "Red Angel" then
									ItemFrame.LayoutOrder = -1
								end
							end

							local LockImageLabel = Instance.new("ImageLabel")
							LockImageLabel.Name = "LockImageLabel"
							LockImageLabel.Image = "rbxassetid://16564634360"
							LockImageLabel.Size = UDim2.new(0.4, 0, 0.4, 0)
							LockImageLabel.BackgroundTransparency = 1
							LockImageLabel.Position = UDim2.new(0.6, 0, 0.6, 0)
							LockImageLabel.ImageColor3 = Color3.new(0.807843, 0.203922, 0.203922)
							LockImageLabel.Parent = ItemFrame.Preview

							local Equipped = Instance.new("TextLabel")
							Equipped.Name = "Equipped"
							Equipped.Text = "E"
							Equipped.TextColor3 = Color3.new(0.321569, 1, 0.490196)
							Equipped.TextStrokeTransparency = 0
							Equipped.TextStrokeColor3 = Color3.new(0, 0, 0)
							Equipped.Size = UDim2.new(0.4, 0, 0.4, 0)
							Equipped.Position = UDim2.new(0.6, 0, 0.6, 0)
							Equipped.Font = Enum.Font.Oswald
							Equipped.TextScaled = true
							Equipped.BackgroundTransparency = 1
							Equipped.Visible = false
							Equipped.Parent = ItemFrame.Preview

							ItemFrame.Visible = true
							ItemFrame.Preview.ImageLabel.Image = v.TextureID
							ItemFrame.Preview.ImageLabel.ImageColor3 = v.Color
							ItemFrame.UIStroke.Color = MainScreenGui.WeaponSkinsGUI.Rarities:FindFirstChild(v.Rarity).BackgroundColor3
							ItemFrame.Rarity.TextColor3 = MainScreenGui.WeaponSkinsGUI.Rarities:FindFirstChild(v.Rarity).BackgroundColor3
							ItemFrame.Rarity.Text = v.Rarity
							ItemFrame.ItemName.Text = i


							if v.Exclusive and v.Exclusive == true then
								ItemFrame.Limited.Visible = true
							end

							ItemFrame.Button.Activated:Connect(function()
								if LockImageLabel.Visible ~= true then
									MainEvent:FireServer("EquipWeaponSkins", i_, i)
								else
									PurchaseFrame("Unlock")
								end
							end)

							ItemFrame.Parent = WeaponSkinsGUI.Holder.Contents.Entries
						end
					end

					UpdateInventoryStuff()
				end)

				CategoryFrame.Name = i_
				CategoryFrame.Title.Text = i_
				table.insert(FRAMES_LOADED, i_)
				CategoryFrame.ImageLabel.Image = v
				CategoryFrame.Parent = WeaponSkinsGUI.Categories.Container
				CategoryFrame.Visible = true
			end
		end
		for _,v in pairs(WeaponSkinsGUI.Categories.Container:GetChildren()) do
			if v.Name ~= "Template" and v:IsA("TextButton") then
				local AmountXDD = 0

				for i,v in pairs(InventoryModule[v.Name]) do
					if i ~= "Unlock1xID" and i ~= "Unlock10xID" and i ~= "CostUnlock1x" and i ~= "CostUnlock10x"and i ~= "CostUnlockCash1x"and i ~= "CostUnlockCash10x" then
						AmountXDD += 1
					end
				end

				if InventoryData[v.Name] then
					for i_, v_ in pairs(InventoryData[v.Name]) do
						if InventoryModule[v.Name][i_] and v_ == true then
							AmountXDD += -1
						end
					end
				end

				v.AvailableCount.Text = AmountXDD .. " available"
			end
		end

		UpdateInventoryStuff()
		WeaponSkinsGUI.Visible = true
	else
		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
		WeaponSkinsGUI.Visible = false
	end

	wait(0.5)
	InventoryDebounce = false
end

local opened = false
local cd = false

MainScreenGui.Crew.SecondLayer.ArrowTing.Activated:Connect(function()
	if opened == false and cd == false then
		cd = true
		MainScreenGui.Crew.SecondLayer.ArrowTing.Image = "http://www.roblox.com/asset/?id=6031091000"
		opened = true
		for i, v in pairs(MainScreenGui.Crew.SecondLayer:GetDescendants()) do
			if v:GetAttribute("IsArrow") then
				v.Visible = true
			end
		end
		task.delay(0.3, function()
			cd = false
		end)
	else
		if opened == true and cd == false then
			cd = true
			MainScreenGui.Crew.SecondLayer.ArrowTing.Image = "http://www.roblox.com/asset/?id=6031090995"
			opened = false
			for i, v in pairs(MainScreenGui.Crew.SecondLayer:GetDescendants()) do
				if v:GetAttribute("IsArrow") then
					v.Visible = false
				end
			end
			task.delay(0.3, function()
				cd = false
			end)
		end
	end
end)

MainScreenGui.Crew.BottomLeft.Aura.Activated:Connect(function()
	MainScreenGui.AuraUI.Visible = not MainScreenGui.AuraUI.Visible
end)

--[[
MainScreenGui.Crew.BottomLeft.Emoji.Activated:Connect(function()
	MainScreenGui.EmojiShop.Visible = not MainScreenGui.EmojiShop.Visible
end)
]]
MainScreenGui.Crew.CenterTop.Inventory.Activated:Connect(function()
	if InventoryDebounce == false then
		InventoryDebounce = true
		LoadInventory(script.Parent.MainScreenGui.WeaponSkinsGUI.Visible)
	end
end)

spawn(function()
	for i, v in pairs(MainScreenGui:GetDescendants()) do
		if v:IsA("UIGradient") and not v:GetAttribute("GradientVFXDisabled") then
			spawn(function()
				for i = 1, math.huge do
					v.Rotation = 0
					TweenService:Create(v, TweenInfo.new(400, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
						Rotation = 99999
					}):Play()
					task.wait(400)
					TweenService:Create(v, TweenInfo.new(400, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
						Rotation = 0
					}):Play()
					task.wait(400)
				end
			end)
		end
	end
end)

WeaponSkinsGUI.Code.TextBox.FocusLost:Connect(function()
	MainEvent:FireServer("EnterPromoCode", WeaponSkinsGUI.Code.TextBox.Text)
end)

WeaponSkinsGUI.close.Activated:Connect(function()
	LoadInventory(script.Parent.MainScreenGui.WeaponSkinsGUI.Visible)
end)

WeaponSkinsGUI.Open1.Activated:Connect(function()
	PurchaseFrame("Unlock")
end)

WeaponSkinsGUI.Open10.Activated:Connect(function()
	PurchaseFrame("Unlock10x")
end)

local function OpenCrate(Case, TheStuffXD, Drop)
	LoadInventory(true)
	MainScreenGui.CrateOpening.CrateOpening.Crate.ViewportFrame:ClearAllChildren()
	local WorldModel = Instance.new("WorldModel")
	WorldModel.Parent = MainScreenGui.CrateOpening.CrateOpening.Crate.ViewportFrame
	local Crate = ReplicatedStorage.Inventory.Crate:Clone()
	Crate.Parent = WorldModel
	local Camera = Instance.new("Camera")
	Camera.CFrame = CFrame.new(Crate.HumanoidRootPart.Position + Crate.HumanoidRootPart.CFrame.LookVector * 5 + Crate.HumanoidRootPart.CFrame.UpVector * 4, Crate.HumanoidRootPart.Position)
	Camera.Parent = MainScreenGui.CrateOpening.CrateOpening.Crate.ViewportFrame
	Camera.FieldOfView = 50
	MainScreenGui.CrateOpening.CrateOpening.Crate.ViewportFrame.CurrentCamera = Camera
	local IdleAnimation = Crate.AnimationController.Animator:LoadAnimation(Crate.AnimationController.IdleAnimation)
	local OpenAnimation = Crate.AnimationController.Animator:LoadAnimation(Crate.AnimationController.OpenAnimation)
	IdleAnimation:Play()
	local SpinSound = script.SpinSound:Clone()
	SpinSound.Parent = script
	SpinSound.Volume = 0
	SpinSound:Play()
	local SpinSoundTween = TweenService:Create(SpinSound, TweenInfo.new(0.8, Enum.EasingStyle.Linear), {
		Volume = 0.5
	})
	SpinSoundTween:Play()

	local Items = {}
	local Item = nil

	for i = 1,30 do
		local RandomKey = nil
		local RandomThing = nil
		if i == 18 then
			RandomKey = Drop
			RandomThing = TheStuffXD[Drop]
		else
			local RandoKEYY = {}
			for i,v in TheStuffXD do
				--if TheStuffXD[i]["Exclusive"] == false then continue end
				--print(i)
				if i == "Unlock1xID" or i == "Unlock10xID" or i == "CostUnlock1x" or i == "CostUnlock10x" or i == "CostUnlockCash1x" or i == "CostUnlockCash10x" then continue end
				table.insert(RandoKEYY, i)
			end
			RandomKey = RandoKEYY[math.random(#RandoKEYY)]
			RandomThing = TheStuffXD[RandomKey]

			--warn(RandomKey)
			--warn(RandomThing)
			--warn(RandoKEYY)
		end
		local SkinEntry = MainScreenGui.CrateOpening.CrateOpening.Entries.Container.Contents.SkinEntryTemplate:Clone()
		SkinEntry.Visible = true
		--warn(RandomThing)
		if typeof(RandomThing) == "table" then
			SkinEntry.SkinInfo.Container.Rarity.Text = RandomThing["Rarity"]
			SkinEntry.SkinInfo.Container.Rarity.TextColor3 = MainScreenGui.WeaponSkinsGUI.Rarities:FindFirstChild(RandomThing["Rarity"]).BackgroundColor3
			SkinEntry.Preview.ImageLabel.Image = RandomThing["TextureID"]
			SkinEntry.Preview.ImageLabel.ImageColor3 = MainScreenGui.WeaponSkinsGUI.Rarities:FindFirstChild(RandomThing["Rarity"]).BackgroundColor3
			SkinEntry.SkinInfo.Container.SkinName.Text = RandomKey
			SkinEntry.UIStroke.UIGradient.Color = ColorSequence.new(RandomThing["Color"],RandomThing["Color"])
			if RandomThing["Exclusive"] and RandomThing["Exclusive"] == true then
				SkinEntry.Limited.Visible = true
			end
		end
		SkinEntry.Parent = MainScreenGui.CrateOpening.CrateOpening.Entries.Container.Contents
		table.insert(Items,SkinEntry)
		if i == 18 then
			Item = SkinEntry
		end
	end

	MainScreenGui.CrateOpening.Visible = true

	local WaitTime = 0
	local Skipped = false

	local SkipConnection = MainScreenGui.CrateOpening.CrateOpening.Skip.Activated:Connect(function()
		Skipped = true
	end)

	local SizeTween = TweenService:Create(MainScreenGui.CrateOpening.CrateOpening.Entries.Container.Contents, TweenInfo.new(3, Enum.EasingStyle.Quad), {
		Position = UDim2.new(0, -MainScreenGui.CrateOpening.CrateOpening.Entries.Container.Contents.AbsoluteSize.X * 0.5 + Item.AbsoluteSize.X * 0.5, 0, 0)
	})

	SizeTween:Play()

	while WaitTime < 3 and Skipped == false do
		WaitTime += task.wait()
	end

	SkipConnection:Disconnect()

	if Skipped then
		SizeTween:Cancel()
	else
		task.wait(0.6)
	end

	if SpinSoundTween.PlaybackState == Enum.PlaybackState.Playing then
		SpinSoundTween:Cancel()
	end

	TweenService:Create(SpinSound, TweenInfo.new(0.4, Enum.EasingStyle.Linear), {
		Volume = 0
	}):Play()

	TweenService:Create(MainScreenGui.CrateOpening.CrateOpening.Entries, TweenInfo.new(0.4, Enum.EasingStyle.Linear), {
		Size = UDim2.new(1, 0, 0, 0)
	}):Play()

	TweenService:Create(MainScreenGui.CrateOpening.CrateOpening.Crate, TweenInfo.new(0.4, Enum.EasingStyle.Linear), {
		Size = UDim2.new(1, 0, 0.822, 0)
	}):Play()
	task.wait(0.4)
	SpinSound:Destroy()
	pcall(function()
		TweenService:Create(Camera, TweenInfo.new(0.75, Enum.EasingStyle.Bounce), {
			FieldOfView = 70,
			CFrame = CFrame.new(Crate.HumanoidRootPart.Position + Crate.HumanoidRootPart.CFrame.LookVector * 8 + Crate.HumanoidRootPart.CFrame.UpVector * 8, Crate.HumanoidRootPart.Position)
		}):Play()
	end)
	IdleAnimation:Stop()
	OpenAnimation:Play()
	task.wait(0.5)
	MainScreenGui.CrateOpening.CrateOpening.Unboxed.SkinEntryTemplate.Preview.ImageLabel.Image = TheStuffXD[Drop]["TextureID"]
	MainScreenGui.CrateOpening.CrateOpening.Unboxed.SkinEntryTemplate.Preview.ImageLabel.ImageColor3 = TheStuffXD[Drop]["Color"]
	MainScreenGui.CrateOpening.CrateOpening.Unboxed.SkinEntryTemplate.SkinInfo.Container.Rarity.Text = TheStuffXD[Drop]["Rarity"]
	MainScreenGui.CrateOpening.CrateOpening.Unboxed.SkinEntryTemplate.SkinInfo.Container.SkinName.Text = Drop
	MainScreenGui.CrateOpening.CrateOpening.Unboxed.SkinEntryTemplate.SkinInfo.Container.Rarity.TextColor3 = TheStuffXD[Drop]["Color"]
	MainScreenGui.CrateOpening.CrateOpening.Unboxed.SkinEntryTemplate.UIStroke.UIGradient.Color = ColorSequence.new(TheStuffXD[Drop]["Color"],TheStuffXD[Drop]["Color"])
	if TheStuffXD[Drop]["Exclusive"] and TheStuffXD[Drop]["Exclusive"] == true then
		MainScreenGui.CrateOpening.CrateOpening.Unboxed.SkinEntryTemplate.Limited.Visible = true
	else
		MainScreenGui.CrateOpening.CrateOpening.Unboxed.SkinEntryTemplate.Limited.Visible = false
	end
	MainScreenGui.CrateOpening.CrateOpening.Unboxed.SkinEntryTemplate.Size = UDim2.new(0,0,0,0)
	MainScreenGui.CrateOpening.CrateOpening.Entries.Visible = true
	script.OpenSound:Play()
	task.wait(0.5)
	OpenAnimation:AdjustSpeed(0)
	MainScreenGui.CrateOpening.CrateOpening.ATitle.Text = TheStuffXD[Drop]["Rarity"] .. " " .. Drop
	MainScreenGui.CrateOpening.CrateOpening.ATitle.TextColor3 = TheStuffXD[Drop]["Color"]
	MainScreenGui.CrateOpening.CrateOpening.Skip.Text = "CLOSE"
	MainScreenGui.CrateOpening.CrateOpening.Unboxed.SkinEntryTemplate.Visible = true
	game:GetService("TweenService"):Create(MainScreenGui.CrateOpening.CrateOpening.Unboxed.SkinEntryTemplate,TweenInfo.new(0.5),{Size = UDim2.new(0.274,0,0.725,0)}):Play()
	task.wait(0.3)
	for _, v in pairs(Crate:GetChildren()) do
		if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
			TweenService:Create(v, TweenInfo.new(0.4, Enum.EasingStyle.Linear), {
				Transparency = 1
			}):Play()
		end
	end
	task.wait(0.2)
	local Closed = false
	local CloseConnection = MainScreenGui.CrateOpening.CrateOpening.Skip.Activated:Connect(function()
		Closed = true
	end)
	while Closed == false do
		task.wait()
	end

	CloseConnection:Disconnect()

	MainScreenGui.CrateOpening.Visible = false

	for i = 1, #Items do
		Items[i]:Destroy()
	end

	MainScreenGui.CrateOpening.CrateOpening.Unboxed.SkinEntryTemplate.Visible = false
	MainScreenGui.CrateOpening.CrateOpening.Skip.Text = "SKIP"
	MainScreenGui.CrateOpening.CrateOpening.ATitle.Text = "Unboxing Crate Skins"
	MainScreenGui.CrateOpening.CrateOpening.ATitle.TextColor3 = Color3.new(1, 1, 1)
	MainScreenGui.CrateOpening.CrateOpening.Entries.Size = UDim2.new(1, 0, 0.474, 0)
	MainScreenGui.CrateOpening.CrateOpening.Crate.Size = UDim2.new(1, 0, 0.348, 0)
	MainScreenGui.CrateOpening.CrateOpening.Entries.Visible = true
	MainScreenGui.CrateOpening.CrateOpening.Entries.Container.Contents.Position = UDim2.new(0, 0, 0, 0)
	LoadInventory(false)
end

function CrateOpening(Case, TheStuffXDDD, Drop)
	--if MainScreenGui.WeaponSkinsGUI.Visible == false then
	--	LoadInventory(script.Parent.MainScreenGui.WeaponSkinsGUI.Visible)
	--end

	if CanOpenCrate then
		CanOpenCrate = false
		OpenCrate(Case, TheStuffXDDD, Drop)
		CanOpenCrate = true
		return
	end

	while true do
		wait()
		if not CanOpenCrate then
		else
			break
		end
	end

	CrateOpening(Case, TheStuffXDDD, Drop)
end

BodyEffects.ChildAdded:connect(function(p75)
	if p75.Name == "CharCam" and p75.Value ~= nil and p75.Value:findFirstChild("Humanoid") then
		CurrentCamera.CameraSubject = p75.Value.Humanoid 
		p75.Value.Changed:connect(function()
			if p75.Value.Parent == nil then
				p75:Destroy() 
				CurrentCamera.CameraSubject = Character.Humanoid 
			end 
		end) 
	end 
end) 
BodyEffects.ChildRemoved:connect(function(p76)
	if p76.Name == "CharCam" then
		CurrentCamera.CameraSubject = Character.Humanoid 
	end 
end)
MainScreenGui.Promote.ImageButton.MouseButton1Click:connect(function()
	MainScreenGui.Promotion.Visible = not MainScreenGui.Promotion.Visible 
end)
for v299, v300 in pairs(MainScreenGui.Promotion:GetChildren()) do
	if (v300:IsA("TextButton") or v300:IsA("ImageButton")) and v300.Name ~= "Close" then
		v300.MouseButton1Click:connect(function()
			MainEvent:FireServer("GamePurchase", v300.Name) 
		end) 
	elseif v300.Name == "Close" then
		v300.MouseButton1Click:connect(function()
			MainScreenGui.Promotion.Visible = false 
		end) 
	end 
end 
MainScreenGui:WaitForChild("ChargeButton") 
local u67 = false 
MainScreenGui.ChargeButton.MouseButton1Click:connect(function()
	if u67 == false then
		u67 = true 
		MainEvent:FireServer("ChargeButton") 
		wait() 
		u67 = false 
	end 
end) 
MainScreenGui:WaitForChild("ShootButton") 
MainScreenGui.ShootButton.MouseButton1Click:connect(function()
	if u67 == false then
		u67 = true 
		MainEvent:FireServer("ShootButton") 
		wait() 
		u67 = false 
	end 
end) 
MainScreenGui:WaitForChild("TaseButton") 
MainScreenGui.TaseButton.MouseButton1Click:connect(function()
	if u67 == false then
		u67 = true 
		MainEvent:FireServer("TaserSHOCK") 
		wait() 
		u67 = false 
	end 
end) 
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false) 
local u68 = false 
local misctable = {}

local function updateLeaderboard()
	if u68 == false then
		u68 = true 
		for v301, v302 in pairs(misctable) do
			pcall(function()
				v302:disconnect() 
			end) 
		end 
		for v303, v304 in pairs(MainScreenGui.Leaderboard.PlayerScroll:GetChildren()) do
			if not v304:IsA("UIListLayout") and not v304:IsA("UIPadding") then
				v304:Destroy()
			end
		end
		local v307 = {} 
		local v309 = {} 
		for v311, v312 in pairs((game.Players:GetChildren())) do
			pcall(function()
				if v312 ~= LocalPlayer then
					table.insert(v307, v312) 
				end
			end) 
		end 
		pcall(function()
			table.sort(v307, function(p77, p78)
				return p78.DataFolder.Information.Streaks.Value < p77.DataFolder.Information.Streaks.Value 
			end) 
		end) 
		table.insert(v309, LocalPlayer) 
		for v313 = 1, #v307 do
			table.insert(v309, v307[v313]) 
		end 
		local u71 = 0 
		for v315, v316 in pairs(v309) do
			pcall(function()	
				local template = MainScreenGui.Leaderboard.Templates.PlayerTemplate:Clone()
				template.PlayerName.Text = v316.Name
				template.Streak.Text = MainModule.AddComma(v316.DataFolder.Information.Streaks.Value) 
				template.Parent = MainScreenGui.Leaderboard.PlayerScroll
				template.Visible = true
				table.insert(misctable, (v316.DataFolder.Information.Streaks.Changed:connect(function()
					template.Streak.Text = MainModule.AddComma(v316.DataFolder.Information.Streaks.Value) 
				end)))
				u71 = u71 + 1
			end) 
		end 
		MainScreenGui.Leaderboard.PlayerScroll.CanvasSize = UDim2.new(0, 0, 0, (30 * u71) + 5) 
		u68 = false 
	end 
end 
updateLeaderboard() 

game.Players.PlayerAdded:connect(function(p81)
	p81:WaitForChild("DataFolder", 1/0) 
	updateLeaderboard() 
end)
game.Players.PlayerRemoving:connect(function(p82)
	updateLeaderboard()
end) 
u69 = MainScreenGui.Crew.BottomLeft.Report 
local v327 = Instance.new("Frame") 
v327.Name = "REPORT_FRAME" 
v327.AnchorPoint = Vector2.new(0.5, 0.5) 
v327.Size = UDim2.new(0.3, 0, 0.4, 0) 
v327.Position = UDim2.new(0.5, 0, 0.5, 0) 
v327.Style = Enum.FrameStyle.DropShadow 
local v328 = Instance.new("ScrollingFrame") 
v328.Name = "REPORT GUI" 
v328.Size = UDim2.new(1, 0, 1, 0) 
v328.BackgroundTransparency = 1 
v328.BorderSizePixel = 0 
v328.Parent = v327 
local u73 = false 
local u74 = false 
local function MakePLAYER_REPORT()
	local v329 = 0 
	local v330 = game.Players:GetChildren() 
	table.sort(v330, function(p83, p84)
		return p83:GetFullName() < p84:GetFullName() 
	end) 
	for v331, v332 in pairs(v330) do
		local v333 = Instance.new("TextLabel") 
		v333.Size = UDim2.new(0.25, 0, 0, 45) 
		v333.Position = UDim2.new(0, 0, 0, v329 * 50) 
		v333.BackgroundColor3 = BrickColor.White().Color 
		v333.Text = v332.Name 
		v333.BorderSizePixel = 0 
		v333.TextScaled = true 
		v333.Parent = v328 
		local v334 = Instance.new("TextButton") 
		v334.Text = "Exploiting" 
		v334.Position = UDim2.new(0.75, 0, 0, v329 * 50) 
		v334.BorderSizePixel = 1 
		v334.Size = UDim2.new(0.25, 0, 0, 45) 
		v334.BackgroundColor3 = BrickColor.Red().Color 
		v334.TextScaled = true 
		v334.Parent = v328 
		local v335 = v333:Clone() 
		v335.Size = UDim2.new(0.25, 0, 0, 45) 
		v335.Position = UDim2.new(0.25, 0, 0, v329 * 50) 
		v335.BackgroundColor3 = BrickColor.White().Color 
		v335.TextColor3 = BrickColor.Red().Color 
		v335.Text = " /Report: " 
		v335.Parent = v328 
		local v336 = v334:Clone() 
		v336.Size = UDim2.new(0.25, 0, 0, 45) 
		v336.BackgroundColor3 = BrickColor.White().Color 
		v336.Position = UDim2.new(0.5, 0, 0, v329 * 50) 
		v336.Text = "Inappropriate Audio" 
		v336.Font = v333.Font 
		v336.TextScaled = true 
		v336.Parent = v328 
		v329 = v329 + 1 
		local u76 = false 
		v336.MouseButton1Click:connect(function()
			if u76 == false then
				u76 = true 
				MainEvent:FireServer("REPORT_PLAYER", v332, "Audio") 
				wait() 
				u76 = false 
			end 
		end) 
		v334.MouseButton1Click:connect(function()
			if u76 == false then
				u76 = true 
				MainEvent:FireServer("REPORT_PLAYER", v332, "Exploiting") 
				wait() 
				u76 = false 
			end 
		end) 
	end 
	v328.CanvasSize = UDim2.new(0, 0, 0, v329 * 50) 
	v327.Parent = MainScreenGui 
end 
u69.MouseButton1Click:connect(function()
	if u73 == false then
		u73 = true 
		u74 = not u74 
		if u74 then
			MakePLAYER_REPORT() 
		else
			for v337, v338 in pairs(v328:GetChildren()) do
				v338:Destroy() 
			end 
			v327.Parent = nil 
		end 
		wait() 
		u73 = false 
	end 
end) 
u69 = MainScreenGui.Crew.CenterTop.Crew 
function updateCrewStuff()
	MainScreenGui.Crew.JoinFrame.Visible = false 
	MainScreenGui.Crew.CrewFrame.Visible = not MainScreenGui.Crew.CrewFrame.Visible 
	local v339 = UDim2.new(0, 0, 0, 0) 
	local v340, v341, v342 = pairs(MainScreenGui.Crew.CrewFrame.Frame.Frame.ScrollingFrame:GetChildren()) 
	while true do
		local v343, v344 = v340(v341, v342) 
		if v343 then

		else
			break 
		end 
		v342 = v343 
		if v344.Name ~= "UIListLayout" then
			v344:Destroy() 
		end 	
	end 
	local v345, v346, v347 = pairs(game.Players:GetChildren()) 
	while true do
		local v348, v349 = v345(v346, v347) 
		if v348 then

		else
			break 
		end 
		v347 = v348 
		local u77 = v339 
		pcall(function()
			if MainModule.CheckTeam(LocalPlayer, v349, true) then
				local v350 = Instance.new("TextLabel") 
				v350.Size = UDim2.new(1, 0, 0, 30) 
				v350.Font = Enum.Font.Highway 
				v350.TextSize = 14 
				v350.BackgroundColor3 = Color3.new(1, 1, 1) 
				v350.BorderSizePixel = 0 
				v350.Text = v349.Name 
				v350.Parent = MainScreenGui.Crew.CrewFrame.Frame.Frame.ScrollingFrame 
				u77 = u77 + UDim2.new(0, 0, 0, 40) 
			end 
		end) 	
	end 
	MainScreenGui.Crew.CrewFrame.Frame.Frame.ScrollingFrame.CanvasSize = v339 
	MainScreenGui.Crew.CrewFrame.ImageLabel.Image = MainModule.GroupImage(LocalPlayer) 
end 
local v351 = MainModule.GroupImage(LocalPlayer) 
if v351 then
	MainScreenGui.Crew.CrewFrame.ImageLabel.Image = v351 
end 
u69.MouseButton1Click:connect(function()
	if MainModule.CheckInCrew(LocalPlayer) then
		updateCrewStuff() 
		return 
	end 
	MainScreenGui.Crew.JoinFrame.Visible = not MainScreenGui.Crew.JoinFrame.Visible 
end) 
MainScreenGui.Crew.JoinFrame.TextButton.MouseButton1Click:connect(function()
	if not MainModule.CheckInCrew(LocalPlayer) then
		MainEvent:FireServer("JoinCrew", MainScreenGui.Crew.JoinFrame.TextBox.Text) 
	end 
end) 
local Image = MainScreenGui.Crew.CrewFrame.ImageLabel.Image 
MainScreenGui.Crew.CrewFrame.TextButton.MouseButton1Click:connect(function()
	if MainModule.CheckInCrew(LocalPlayer) then
		MainEvent:FireServer("LeaveCrew") 
		MainScreenGui.Crew.CrewFrame.ImageLabel.Image = Image 
		MainScreenGui.Crew.JoinFrame.Visible = true 
		MainScreenGui.Crew.CrewFrame.Visible = false 
	end 
end) 

local entireting = MainScreenGui.ProductPurchaseFrame

--[[MainScreenGui.Crew.CenterTop.Shop.MouseButton1Click:Connect(function()
	entireting.Visible = true
	entireting.Music_Label.Text = "This is currently not out."
end)]]

entireting.DaButton.MouseEnter:Connect(function()
	game.TweenService:Create(entireting.DaButton.UIStroke, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), {
		Transparency = 0,
		Thickness = 1.6
	}):Play()
end)

entireting.DaButton.Activated:Connect(function()
	entireting.Visible = false
end)

entireting.DaButton.MouseLeave:Connect(function()
	game.TweenService:Create(entireting.DaButton.UIStroke, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), {
		Transparency = 0.5,
		Thickness = 1.8
	}):Play()
end)

local ScrollUI_Aura = MainScreenGui.AuraUI.Scroll

local thumbType = Enum.ThumbnailType.HeadShot
local thumbSize = Enum.ThumbnailSize.Size420x420
local content, isReady = game:GetService("Players"):GetUserThumbnailAsync(LocalPlayer.UserId,thumbType,thumbSize)



local macro = MainScreenGui.Crew.BottomLeft.Macro
local mouselock = MainScreenGui.Crew.BottomLeft.MouseLock

if game:GetService("UserInputService").TouchEnabled then
	macro.Visible = true
	mouselock.Visible = true
else
	macro.Visible = false
	mouselock.Visible = false
end

local Active = false

if UserInputService.TouchEnabled == true then

	macro.MouseButton1Click:Connect(function()
		Active = not Active
	end)

	local function MobileShiftLock()
		if Active == true then
			local char = LocalPlayer.Character
			if char ~= nil then
				local Head = char:FindFirstChild("Head")
				local HumanoidRootPart = char:FindFirstChild("HumanoidRootPart")
				local Humanoid = char:FindFirstChild("Humanoid")

				local Camera = workspace.CurrentCamera
				if HumanoidRootPart ~= nil and Humanoid.Sit == false then
					local LookVector = Camera.CFrame.LookVector
					HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position) * CFrame.Angles(0, math.atan2(-LookVector.X, -LookVector.Z), 0)
				end
				if Head ~= nil then
					local InFirstPerson = (Camera.Focus.p - Camera.CoordinateFrame.p).magnitude
					InFirstPerson = (InFirstPerson<1) and (0.5-(InFirstPerson-0.5)/1) or 0
					if InFirstPerson < 0.2 then
					end
				end
			end
		end
	end
	RunService:BindToRenderStep("MobileShiftLock", 40, MobileShiftLock)
end

MainEvent.OnClientEvent:Connect(function(Reason)
	if Reason == "HitMarkerReached" then
		if hitmarker_val ~= false then
			MainScreenGui.Aim.HitMarker.Visible = true
			local sound = Instance.new("Sound")
			sound.SoundId = "rbxassetid://6773912589"
			sound.Volume = 0.6
			sound.Parent = script
			sound:Play()
			game.Debris:AddItem(sound, 0.6)
			task.delay(0.1, function()
				MainScreenGui.Aim.HitMarker.Visible = false
			end)
		end
	end
end)

MainEvent.OnClientEvent:Connect(function(Reason, Text, Duration)
	if Reason == "Notify" then
		local notitext = Instance.new("TextLabel")
		notitext.Size = UDim2.new(0.992, 0,0.04, 0)
		notitext.TextColor3 = Color3.new(1, 1, 1)
		notitext.BackgroundTransparency = 1
		notitext.TextStrokeTransparency = 0.2
		notitext.TextScaled = true
		notitext.Text = Text
		notitext.Name = Text
		notitext.Parent = MainScreenGui.Notifications
		notitext.Visible = true
		task.delay(Duration, function()
			local ting = game.TweenService:Create(notitext, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), {
				TextTransparency = 1,
				TextStrokeTransparency = 1
			}):Play()
			ting.Completed:Connect(function()
				notitext:Destroy()
			end)
		end)
	end
end)

for i, v in pairs(MainScreenGui.Crew.BottomLeft:GetChildren()) do
	if v:IsA("ImageButton") and v.Name ~= "Macro" and v.Name ~= "MouseLock" then
		v.MouseEnter:Connect(function()
			game.TweenService:Create(v, TweenInfo.new(0.7, Enum.EasingStyle.Back), {
				Rotation = 15,
				Size = UDim2.new(0, 33,0, 33)
			}):Play()
		end)
		v.MouseLeave:Connect(function()
			game.TweenService:Create(v, TweenInfo.new(0.7, Enum.EasingStyle.Back), {
				Rotation = 0,
				Size = UDim2.new(0, 31,0, 31)
			}):Play()
		end)
	end
end

for i, v in pairs(MainScreenGui.Crew.SecondLayer:GetChildren()) do
	if v:IsA("ImageButton") then
		v.MouseEnter:Connect(function()
			game.TweenService:Create(v, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {
				Rotation = 15,
				Size = UDim2.new(0, 33,0, 33)
			}):Play();
		end)
		v.MouseLeave:Connect(function()
			game.TweenService:Create(v, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {
				Rotation = 0,
				Size = UDim2.new(0, 31,0, 31)
			}):Play();
		end)
	end
end

for i, v in pairs(MainScreenGui.Crew.Settings.CrosshairsList.ScrollingFrame:GetChildren()) do
	if v:IsA("Frame") then
		v.Tap.Activated:Connect(function()
			MainScreenGui.Crew.Settings.ScrollingFrame.Cursor.TextBox.Text = v.ID.Text
			LocalPlayer:WaitForChild("DataFolder").CursorImage.Value = v.ID.Text
			MainScreenGui.Crew.Settings.ScrollingFrame.Cursor.ImageLabel.Image = "rbxassetid://"..v.ID.Text
		end)
	end
end

--[[

ScrollUI_Aura.Broly.Toggle.Activated:Connect(function()
	if MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 691780666) then
		if ScrollUI_Aura.Broly.ToggleBool.Value == true then
			MainEvent:FireServer("Broly", false)
			ScrollUI_Aura.Broly.Toggle.Text = "OFF"
			ScrollUI_Aura.Broly.Toggle.BackgroundColor3 = Color3.new(0.596078, 0, 0.0117647)
			ScrollUI_Aura.Broly.ToggleBool.Value = false
		else
			MainEvent:FireServer("Broly", true)
			ScrollUI_Aura.Broly.Toggle.Text = "ON"
			ScrollUI_Aura.Broly.Toggle.BackgroundColor3 = Color3.new(0.0862745, 0.52549, 0)
			ScrollUI_Aura.Broly.ToggleBool.Value = true
		end
	else
		MarketplaceService:PromptGamePassPurchase(LocalPlayer, 691780666)
	end
end)


ScrollUI_Aura.Unkown.Toggle.Activated:Connect(function()
	if MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 692229158) then
		if ScrollUI_Aura.Unkown.ToggleBool.Value == true then
			MainEvent:FireServer("Unkown", false)
			ScrollUI_Aura.Unkown.Toggle.Text = "OFF"
			ScrollUI_Aura.Unkown.Toggle.BackgroundColor3 = Color3.new(0.596078, 0, 0.0117647)
			ScrollUI_Aura.Unkown.ToggleBool.Value = false
		else
			MainEvent:FireServer("Unkown", true)
			ScrollUI_Aura.Unkown.Toggle.Text = "ON"
			ScrollUI_Aura.Unkown.Toggle.BackgroundColor3 = Color3.new(0.0862745, 0.52549, 0)
			ScrollUI_Aura.Unkown.ToggleBool.Value = true
		end
	else
		MarketplaceService:PromptGamePassPurchase(LocalPlayer, 692229158)
	end
end)

ScrollUI_Aura.Kitty.Toggle.Activated:Connect(function()
	if MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 692265348) then
		if ScrollUI_Aura.Kitty.ToggleBool.Value == true then
			MainEvent:FireServer("Kitty", false)
			ScrollUI_Aura.Kitty.Toggle.Text = "OFF"
			ScrollUI_Aura.Kitty.Toggle.BackgroundColor3 = Color3.new(0.596078, 0, 0.0117647)
			ScrollUI_Aura.Kitty.ToggleBool.Value = false
		else
			MainEvent:FireServer("Kitty", true)
			ScrollUI_Aura.Kitty.Toggle.Text = "ON"
			ScrollUI_Aura.Kitty.Toggle.BackgroundColor3 = Color3.new(0.0862745, 0.52549, 0)
			ScrollUI_Aura.Kitty.ToggleBool.Value = true
		end
	else
		MarketplaceService:PromptGamePassPurchase(LocalPlayer, 692265348)
	end
end)

ScrollUI_Aura.Resort.Toggle.Activated:Connect(function()
	if MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 694059447) then
		if ScrollUI_Aura.Resort.ToggleBool.Value == true then
			MainEvent:FireServer("Resort", false)
			ScrollUI_Aura.Resort.Toggle.Text = "OFF"
			ScrollUI_Aura.Resort.Toggle.BackgroundColor3 = Color3.new(0.596078, 0, 0.0117647)
			ScrollUI_Aura.Resort.ToggleBool.Value = false
		else
			MainEvent:FireServer("Resort", true)
			ScrollUI_Aura.Resort.Toggle.Text = "ON"
			ScrollUI_Aura.Resort.Toggle.BackgroundColor3 = Color3.new(0.0862745, 0.52549, 0)
			ScrollUI_Aura.Resort.ToggleBool.Value = true
		end
	else
		MarketplaceService:PromptGamePassPurchase(LocalPlayer, 694059447)
	end
end)


ScrollUI_Aura.Summer.Toggle.Activated:Connect(function()
	if MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 692047390) then
		if ScrollUI_Aura.Summer.ToggleBool.Value == true then
			MainEvent:FireServer("Summer", false)
			ScrollUI_Aura.Summer.Toggle.Text = "OFF"
			ScrollUI_Aura.Summer.Toggle.BackgroundColor3 = Color3.new(0.596078, 0, 0.0117647)
			ScrollUI_Aura.Summer.ToggleBool.Value = false
		else
			MainEvent:FireServer("Summer", true)
			ScrollUI_Aura.Summer.Toggle.Text = "ON"
			ScrollUI_Aura.Summer.Toggle.BackgroundColor3 = Color3.new(0.584314, 0, 0.00784314)
			ScrollUI_Aura.Summer.ToggleBool.Value = true
		end
	else
		MarketplaceService:PromptGamePassPurchase(LocalPlayer, 692047390)
	end
end)

ScrollUI_Aura.Kitty.Toggle.Activated:Connect(function()
	if MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 693317729) then
		if ScrollUI_Aura.Kitty.ToggleBool.Value == true then
			MainEvent:FireServer("Kitty", false)
			ScrollUI_Aura.Kitty.Toggle.Text = "OFF"
			ScrollUI_Aura.Kitty.Toggle.BackgroundColor3 = Color3.new(0.596078, 0, 0.0117647)
			ScrollUI_Aura.Kitty.ToggleBool.Value = false
		else
			MainEvent:FireServer("Kitty", true)
			ScrollUI_Aura.Kitty.Toggle.Text = "ON"
			ScrollUI_Aura.Kitty.Toggle.BackgroundColor3 = Color3.new(0.0862745, 0.52549, 0)
			ScrollUI_Aura.Kitty.ToggleBool.Value = true
		end
	else
		MarketplaceService:PromptGamePassPurchase(LocalPlayer, 693317729)
	end
end)
ScrollUI_Aura.Kitty.Toggle.Activated:Connect(function()
	if MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 693317729) then
		if ScrollUI_Aura.Kitty.ToggleBool.Value == true then
			MainEvent:FireServer("Kitty", false)
			ScrollUI_Aura.Kitty.Toggle.Text = "OFF"
			ScrollUI_Aura.Kitty.Toggle.BackgroundColor3 = Color3.new(0.596078, 0, 0.0117647)
			ScrollUI_Aura.Kitty.ToggleBool.Value = false
		else
			MainEvent:FireServer("Kitty", true)
			ScrollUI_Aura.Kitty.Toggle.Text = "ON"
			ScrollUI_Aura.Kitty.Toggle.BackgroundColor3 = Color3.new(0.0862745, 0.52549, 0)
			ScrollUI_Aura.Kitty.ToggleBool.Value = true
		end
	else
		MarketplaceService:PromptGamePassPurchase(LocalPlayer, 693317729)
	end
end)

ScrollUI_Aura.Cloudy.Toggle.Activated:Connect(function()
	if MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 692058400) then
		if ScrollUI_Aura.Cloudy.ToggleBool.Value == true then
			MainEvent:FireServer("Cloudy", false)
			ScrollUI_Aura.Cloudy.Toggle.Text = "OFF"
			ScrollUI_Aura.Cloudy.Toggle.BackgroundColor3 = Color3.new(0.596078, 0, 0.0117647)
			ScrollUI_Aura.Cloudy.ToggleBool.Value = false
		else
			MainEvent:FireServer("Cloudy", true)
			ScrollUI_Aura.Cloudy.Toggle.Text = "ON"
			ScrollUI_Aura.Cloudy.Toggle.BackgroundColor3 = Color3.new(0.0862745, 0.52549, 0)
			ScrollUI_Aura.Cloudy.ToggleBool.Value = true
		end
	else
		MarketplaceService:PromptGamePassPurchase(LocalPlayer, 692058400)
	end
end)

ScrollUI_Aura.Lightning.Toggle.Activated:Connect(function()
	if MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 692381084) then
		if ScrollUI_Aura.Lightning.ToggleBool.Value == true then
			MainEvent:FireServer("Lightning", false)
			ScrollUI_Aura.Lightning.Toggle.Text = "OFF"
			ScrollUI_Aura.Lightning.Toggle.BackgroundColor3 = Color3.new(0.596078, 0, 0.0117647)
			ScrollUI_Aura.Lightning.ToggleBool.Value = false
		else
			MainEvent:FireServer("Lightning", true)
			ScrollUI_Aura.Lightning.Toggle.Text = "ON"
			ScrollUI_Aura.Lightning.Toggle.BackgroundColor3 = Color3.new(0.0862745, 0.52549, 0)
			ScrollUI_Aura.Lightning.ToggleBool.Value = true
		end
	else
		MarketplaceService:PromptGamePassPurchase(LocalPlayer, 692381084)
	end
end)

ScrollUI_Aura.Cats.Toggle.Activated:Connect(function()
	if MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 692218229) then
		if ScrollUI_Aura.Cats.ToggleBool.Value == true then
			MainEvent:FireServer("Cats", false)
			ScrollUI_Aura.Cats.Toggle.Text = "OFF"
			ScrollUI_Aura.Cats.Toggle.BackgroundColor3 = Color3.new(0.596078, 0, 0.0117647)
			ScrollUI_Aura.Cats.ToggleBool.Value = false
		else
			MainEvent:FireServer("Cats", true)
			ScrollUI_Aura.Cats.Toggle.Text = "ON"
			ScrollUI_Aura.Cats.Toggle.BackgroundColor3 = Color3.new(0.0862745, 0.52549, 0)
			ScrollUI_Aura.Cats.ToggleBool.Value = true
		end
	else
		MarketplaceService:PromptGamePassPurchase(LocalPlayer, 692218229)
	end
end)
]]
local AnimationConnection = nil

MainScreenGui.AnimationPack.Visible = true
MainScreenGui.AnimationPlusPack.Visible = true

MainScreenGui.AnimationPack.Activated:Connect(function()
	MainScreenGui.AnimationPack.CloseButton.Visible = true
	MainScreenGui.AnimationPack.ScrollingFrame.Visible = true
	MainScreenGui.AnimationPlusPack.Visible = false
	MainScreenGui.AnimationPack.BackgroundTransparency = 1

	AnimationConnection = MainScreenGui.AnimationPack.CloseButton.Activated:Connect(function()
		MainScreenGui.AnimationPack.CloseButton.Visible = false
		MainScreenGui.AnimationPack.ScrollingFrame.Visible = false
		MainScreenGui.AnimationPlusPack.Visible = true
		MainScreenGui.AnimationPack.BackgroundTransparency = 0

		AnimationConnection:Disconnect()
	end)
end)

for i,v in MainScreenGui.AnimationPack.ScrollingFrame:GetChildren() do 
	if v:IsA("TextButton") then
		v.Activated:Connect(function()
			MainEvent:FireServer("AnimationPack", v.Text)
		end)
	end
end

MainScreenGui.AnimationPlusPack.Activated:Connect(function()
	MainScreenGui.AnimationPlusPack.CloseButton.Visible = true
	MainScreenGui.AnimationPlusPack.ScrollingFrame.Visible = true
	MainScreenGui.AnimationPack.Visible = false
	MainScreenGui.AnimationPlusPack.BackgroundTransparency = 1

	AnimationConnection = MainScreenGui.AnimationPlusPack.CloseButton.Activated:Connect(function()
		MainScreenGui.AnimationPlusPack.CloseButton.Visible = false
		MainScreenGui.AnimationPlusPack.ScrollingFrame.Visible = false
		MainScreenGui.AnimationPack.Visible = true
		MainScreenGui.AnimationPlusPack.BackgroundTransparency = 0

		AnimationConnection:Disconnect()
	end)
end)

for i,v in MainScreenGui.AnimationPlusPack.ScrollingFrame:GetChildren() do 
	if v:IsA("TextButton") then
		v.Activated:Connect(function()
			MainEvent:FireServer("AnimationPack2", v.Text)
		end)
	end
end

local Muted = false 
pcall(function()
	for i, v in pairs(workspace.Players:GetChildren()) do
		if v.LowerTorso:FindFirstChild("BOOMBOXSOUND") then
			v.LowerTorso.BOOMBOXSOUND.Volume = 0.5 
		end 
	end 
end) 
workspace.Players.DescendantAdded:Connect(function(Descendant)
	if Muted == true and Descendant and Descendant:IsA("Sound") and Descendant.Name == "BOOMBOXSOUND" and not Descendant:IsDescendantOf(Character) then
		Descendant.Volume = 0
	end
end)
LocalPlayer.Chatted:connect(function(Message)
	if Message:lower() == "/e stats" then
		MainScreenGui.StatsInfo.Visible = not MainScreenGui.StatsInfo.Visible 
		local MaxMuscle = game:GetService("ReplicatedStorage").Values.MaxMuscle.Value 
		local MuscleInformation = LocalPlayer.DataFolder:WaitForChild("Information"):FindFirstChild("MuscleInformation") 
		local Muscle
		if MuscleInformation then
			Muscle = MuscleInformation.Value 
		else
			Muscle = 0 
		end 
		local MSize = (MaxMuscle + Muscle) / (MaxMuscle * 2) 
		MainScreenGui.StatsInfo.Muscle.Bar.Frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0):lerp(Color3.fromRGB(174, 255, 149), MSize) 
		MainScreenGui.StatsInfo.Muscle.Bar.Frame.Size = UDim2.new(MSize, 0, 1, 0) 
		local BoxingValue = LocalPlayer.DataFolder.Information:FindFirstChild("BoxingValue") 
		local Boxing
		if BoxingValue then
			Boxing = BoxingValue.Value 
		else
			Boxing = 0 
		end 
		local BSize = Boxing / game:GetService("ReplicatedStorage").Values.MaxBoxing.Value 
		MainScreenGui.StatsInfo.Boxing.Bar.Frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0):lerp(Color3.fromRGB(174, 255, 149), BSize) 
		MainScreenGui.StatsInfo.Boxing.Bar.Frame.Size = UDim2.new(BSize, 0, 1, 0) 
	end 
end) 
LocalPlayer.Chatted:connect(function(p88)

	if string.sub(p88, 0, 6) == "/e fov" then
		local v386 = string.match(p88, "%d+") 
		if v386 then
			CurrentCamera.FieldOfView = math.clamp(tonumber(v386), 70, 120) 
		end 
	end 
end) 

MainScreenGui.StatsInfo.close.Activated:Connect(function()
	MainScreenGui.StatsInfo.Visible = false
end)

local Framework = nil
wait()
local LocalPlayer = game.Players.LocalPlayer
local IsShazam = false
local MainEvent = game.ReplicatedStorage.MainEvent
local Framework = nil
wait()
local LocalPlayer = game.Players.LocalPlayer
local IsShazam = false
local MainEvent = game.ReplicatedStorage.MainEvent

spawn(function()
	CurrentCamera.FieldOfView = LocalPlayer:WaitForChild("DataFolder").Information.FOV.Value
end)

while true do
	wait() 
	if _G.Reduce_Lag ~= nil then
		break 
	end 
end 

MainScreenGui.Crew.CenterTop.Settings.MouseButton1Click:connect(function()
	MainScreenGui.Crew.Settings.Visible = not MainScreenGui.Crew.Settings.Visible

	local Label = MainScreenGui.Crew.Settings.ScrollingFrame.Server
	local String = ReplicatedStorage.Values.Server

	Label.TextLabel.Text = "Server: "..String.Value
end)



local shift = game.Players.LocalPlayer.PlayerGui.MainScreenGui.Crew.BottomLeft.MouseLock
local shiftt = false

shift.MouseButton1Click:Connect(function()
	if shiftt == false then
		shift.ImageColor3 = Color3.new(0, 0.815686, 1)
		shiftt = true
	elseif shiftt == true then
		shift.ImageColor3 =Color3.new(255, 255, 255)
		shiftt = false
	end
end)

local LowGFXCooldown = false
local hitmarkercd = false
local SettingsTweenInfo = TweenInfo.new(0.5)

MainScreenGui.Crew.Settings.ScrollingFrame.Hitmarker.Enable.UIStroke.Color = Color3.fromRGB(255, 255, 255)

MainScreenGui.Crew.Settings.ScrollingFrame.Hitmarker.Enable.MouseButton1Click:Connect(function()
	if hitmarkercd == false then
		hitmarkercd = true
		MainEvent:FireServer("SettingsChange", "Hitmarker", true)
		hitmarker_val = true


		TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.Hitmarker.Enable.UIStroke, SettingsTweenInfo, {
			Color = Color3.fromRGB(255, 255, 255)
		}):Play()

		TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.Hitmarker.Disable.UIStroke, SettingsTweenInfo, {
			Color = Color3.fromRGB(43, 44, 50)
		}):Play()

		wait(0.2)
		hitmarkercd = false

	end
end)

MainScreenGui.Crew.Settings.ScrollingFrame.Hitmarker.Disable.MouseButton1Click:Connect(function()
	if hitmarkercd == false then
		hitmarkercd = true
		MainEvent:FireServer("SettingsChange", "Hitmarker", false)
		hitmarker_val = false

		TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.Hitmarker.Enable.UIStroke, SettingsTweenInfo, {
			Color = Color3.fromRGB(43, 44, 50)
		}):Play()

		TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.Hitmarker.Disable.UIStroke, SettingsTweenInfo, {
			Color = Color3.fromRGB(255, 255, 255)
		}):Play()

		wait(0.2)
		hitmarkercd = false
	end
end)

MainScreenGui.Crew.Settings.ScrollingFrame.LowerGFX.Enable.MouseButton1Click:Connect(function()
	if LowGFXCooldown == false and _G.Reduce_LagParts ~= nil then
		LowGFXCooldown = true
		_G.Reduce_Lag = true

		local v389 = 0
		for i,v in pairs(_G.Reduce_LagParts) do
			task.spawn(function()
				v[1].Material = Enum.Material.SmoothPlastic
			end)
			v389 = v389 + 1
			if v389 % 500 == 0 then
				wait()
			end
		end

		MainEvent:FireServer("SettingsChange", "LowGFX", true)

		TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.LowerGFX.Enable.UIStroke, SettingsTweenInfo, {
			Color = Color3.fromRGB(255, 255, 255)
		}):Play()

		TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.LowerGFX.Disable.UIStroke, SettingsTweenInfo, {
			Color = Color3.fromRGB(43, 44, 50)
		}):Play()

		wait(0.2)
		LowGFXCooldown = false
	end
end)

MainScreenGui.Crew.Settings.ScrollingFrame.LowerGFX.Disable.MouseButton1Click:Connect(function()
	if LowGFXCooldown == false and _G.Reduce_LagParts ~= nil then
		LowGFXCooldown = true
		_G.Reduce_Lag = false

		local v389 = 0
		for i,v in pairs(_G.Reduce_LagParts) do
			task.spawn(function()
				v[1].Material = v[2]
			end)
			v389 = v389 + 1
			if v389 % 500 == 0 then
				wait()
			end
		end

		MainEvent:FireServer("SettingsChange", "LowGFX", false)

		TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.LowerGFX.Disable.UIStroke, SettingsTweenInfo, {
			Color = Color3.fromRGB(255, 255, 255)
		}):Play()

		TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.LowerGFX.Enable.UIStroke, SettingsTweenInfo, {
			Color = Color3.fromRGB(43, 44, 50)
		}):Play()

		wait(0.2)
		LowGFXCooldown = false
	end
end)

local StompEffectToggleDebounce = false
local StreakTagToggleDebounce = false

if _G.STOMPEFFECTS_ENABLED == nil then
	repeat
		task.wait()
	until _G.STOMPEFFECTS_ENABLED ~= nil
end

if _G.STREAKTAGS_ENABLED == nil then
	repeat
		task.wait()
	until _G.STREAKTAGS_ENABLED ~= nil
end

MainScreenGui.Crew.Settings.ScrollingFrame.StompEffects.Enable.MouseButton1Click:Connect(function()
	if _G.STOMPEFFECTS_ENABLED ~= nil and StompEffectToggleDebounce == false then
		StompEffectToggleDebounce = true
		_G.STOMPEFFECTS_ENABLED = true
		MainEvent:FireServer("SettingsChange", "StompFX", true)
		TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.StompEffects.Enable.UIStroke, SettingsTweenInfo, {
			Color = Color3.fromRGB(255, 255, 255)
		}):Play()
		TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.StompEffects.Disable.UIStroke, SettingsTweenInfo, {
			Color = Color3.fromRGB(43, 44, 50)
		}):Play()
		task.wait(0.5)
		StompEffectToggleDebounce = false
	end
end)

MainScreenGui.Crew.Settings.ScrollingFrame.StompEffects.Disable.MouseButton1Click:Connect(function()
	if _G.STOMPEFFECTS_ENABLED ~= nil and StompEffectToggleDebounce == false then
		StompEffectToggleDebounce = true
		_G.STOMPEFFECTS_ENABLED = false
		MainEvent:FireServer("SettingsChange", "StompFX", false)
		TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.StompEffects.Disable.UIStroke, SettingsTweenInfo, {
			Color = Color3.fromRGB(255, 255, 255)
		}):Play()
		TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.StompEffects.Enable.UIStroke, SettingsTweenInfo, {
			Color = Color3.fromRGB(43, 44, 50)
		}):Play()
		task.wait(0.5)
		StompEffectToggleDebounce = false
	end
end)

--[[

MainScreenGui.Crew.Settings.ScrollingFrame.StreakTags.Enable.MouseButton1Click:Connect(function()
	if _G.STREAKTAGS_ENABLED ~= nil and StreakTagToggleDebounce == false then
		StreakTagToggleDebounce = true
		_G.STREAKTAGS_ENABLED = false
		MainEvent:FireServer("SettingsChange", "StreakTags", true)
		TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.StreakTags.Enable.UIStroke, SettingsTweenInfo, {
			Color = Color3.fromRGB(255, 255, 255)
		}):Play()
		TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.StreakTags.Disable.UIStroke, SettingsTweenInfo, {
			Color = Color3.fromRGB(43, 44, 50)
		}):Play()
		task.wait(0.5)
		StreakTagToggleDebounce = false
	end
end)

MainScreenGui.Crew.Settings.ScrollingFrame.StreakTags.Disable.MouseButton1Click:Connect(function()
	if _G.STREAKTAGS_ENABLED ~= nil and StreakTagToggleDebounce == false then
		StreakTagToggleDebounce = true
		_G.STREAKTAGS_ENABLED = true
		MainEvent:FireServer("SettingsChange", "StreakTags", false)
		TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.StreakTags.Disable.UIStroke, SettingsTweenInfo, {
			Color = Color3.fromRGB(255, 255, 255)
		}):Play()
		TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.StreakTags.Enable.UIStroke, SettingsTweenInfo, {
			Color = Color3.fromRGB(43, 44, 50)
		}):Play()
		task.wait(0.5)
		StreakTagToggleDebounce = false
	end
end)
]]
local SettingsData = ReplicatedStorage.RemoteFunction.RemoteFunction:InvokeServer("REQUEST_SETTINGS_DATA")
local Lighting = game:GetService("Lighting")

MainScreenGui.Crew.Settings.ScrollingFrame.DayNight.Disable.MouseButton1Click:Connect(function()
	Lighting.ClockTime = 0
	TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.DayNight.Disable.UIStroke, SettingsTweenInfo, {
		Color = Color3.fromRGB(255, 255, 255)
	}):Play()
	TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.DayNight.Enable.UIStroke, SettingsTweenInfo, {
		Color = Color3.fromRGB(43, 44, 50)
	}):Play()
	MainEvent:FireServer("SettingsChange", "Day/Night", "Night")
end)

MainScreenGui.Crew.Settings.ScrollingFrame.DayNight.Enable.MouseButton1Click:Connect(function()
	Lighting.ClockTime = 14
	TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.DayNight.Enable.UIStroke, SettingsTweenInfo, {
		Color = Color3.fromRGB(255, 255, 255)
	}):Play()
	TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.DayNight.Disable.UIStroke, SettingsTweenInfo, {
		Color = Color3.fromRGB(43, 44, 50)
	}):Play()
	MainEvent:FireServer("SettingsChange", "Day/Night", "Day")
end)

MainScreenGui.Crew.Settings.ScrollingFrame.AntiMacroFling.Enable.MouseButton1Click:Connect(function()
	TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.AntiMacroFling.Enable.UIStroke, SettingsTweenInfo, {
		Color = Color3.fromRGB(255, 255, 255)
	}):Play()
	TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.AntiMacroFling.Disable.UIStroke, SettingsTweenInfo, {
		Color = Color3.fromRGB(43, 44, 50)
	}):Play()
	Character:FindFirstChildOfClass("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
	MainEvent:FireServer("SettingsChange", "AntiMacroFling", true)
end)

MainScreenGui.Crew.Settings.ScrollingFrame.AntiMacroFling.Disable.MouseButton1Click:Connect(function()
	TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.AntiMacroFling.Disable.UIStroke, SettingsTweenInfo, {
		Color = Color3.fromRGB(255, 255, 255)
	}):Play()
	TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.AntiMacroFling.Enable.UIStroke, SettingsTweenInfo, {
		Color = Color3.fromRGB(43, 44, 50)
	}):Play()
	Character:FindFirstChildOfClass("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
	MainEvent:FireServer("SettingsChange", "AntiMacroFling", false)
end)

if SettingsData ~= nil then
	if SettingsData["Settings"]["AntiMacroFling"] == true then
		TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.AntiMacroFling.Enable.UIStroke, SettingsTweenInfo, {
			Color = Color3.fromRGB(255, 255, 255)
		}):Play()
		TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.AntiMacroFling.Disable.UIStroke, SettingsTweenInfo, {
			Color = Color3.fromRGB(43, 44, 50)
		}):Play()
		Character:FindFirstChildOfClass("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
	else
		TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.AntiMacroFling.Disable.UIStroke, SettingsTweenInfo, {
			Color = Color3.fromRGB(255, 255, 255)
		}):Play()
		TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.AntiMacroFling.Enable.UIStroke, SettingsTweenInfo, {
			Color = Color3.fromRGB(43, 44, 50)
		}):Play()
		Character:FindFirstChildOfClass("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
	end

	if SettingsData["Settings"]["LowGFX"] == true then
		TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.LowerGFX.Enable.UIStroke, SettingsTweenInfo, {
			Color = Color3.fromRGB(255, 255, 255)
		}):Play()

		task.spawn(function()
			local v389 = 0
			for i,v in pairs(_G.Reduce_LagParts) do
				task.spawn(function()
					v[1].Material = Enum.Material.SmoothPlastic
				end)
				v389 = v389 + 1
				if v389 % 500 == 0 then
					wait()
				end
			end
		end)
	else
		TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.LowerGFX.Disable.UIStroke, SettingsTweenInfo, {
			Color = Color3.fromRGB(255, 255, 255)
		}):Play()
	end
--[[
	if SettingsData["Settings"]["StreakTags"] == false then
		_G.STREAKTAGS_ENABLED = true
		TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.StreakTags.Disable.UIStroke, SettingsTweenInfo, {
			Color = Color3.fromRGB(255, 255, 255)
		}):Play()
	else
		TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.StreakTags.Enable.UIStroke, SettingsTweenInfo, {
			Color = Color3.fromRGB(255, 255, 255)
		}):Play()
	end]]

	if SettingsData["Settings"]["StompFX"] == false then
		_G.STOMPEFFECTS_ENABLED = false
		TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.StompEffects.Disable.UIStroke, SettingsTweenInfo, {
			Color = Color3.fromRGB(255, 255, 255)
		}):Play()
	else
		TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.StompEffects.Enable.UIStroke, SettingsTweenInfo, {
			Color = Color3.fromRGB(255, 255, 255)
		}):Play()
	end

	if SettingsData["Settings"]["Day/Night"] == "Night" then
		Lighting.ClockTime = 0
		TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.DayNight.Disable.UIStroke, SettingsTweenInfo, {
			Color = Color3.fromRGB(255, 255, 255)
		}):Play()
	else
		Lighting.ClockTime = 14
		TweenService:Create(MainScreenGui.Crew.Settings.ScrollingFrame.DayNight.Enable.UIStroke, SettingsTweenInfo, {
			Color = Color3.fromRGB(255, 255, 255)
		}):Play()
	end
end

for v308, Pad in pairs(game.Workspace.Ignored.Shop:GetChildren()) do
	if Pad:FindFirstChild("Highlight") then
		Pad.Highlight:Destroy()
	end
	if Pad:FindFirstChild("ClickDetector") then
		local ClickDetector = Pad.ClickDetector
		ClickDetector.MouseHoverEnter:Connect(function()
			local v311 = Instance.new("Highlight", Pad)
			v311.DepthMode = Enum.HighlightDepthMode.Occluded
			v311.FillTransparency = 1
			v311.OutlineTransparency = 0
			v311.OutlineColor = Color3.fromRGB(255, 255, 255)
		end)
		ClickDetector.MouseHoverLeave:Connect(function()
			if Pad:FindFirstChild("Highlight") then
				Pad.Highlight:Destroy()
			end
		end)
	end
end

while true do
	wait() 
	Tool = LocalPlayer.Backpack:FindFirstChild("Phone") 
	if Tool then
		break 
	end 
end 
local u79 = true 
Tool.Equipped:connect(function()
	for v366, v367 in pairs(MainScreenGui.PhoneCalls.ScrollingFrame:GetChildren()) do
		if v367.ClassName ~= "UIListLayout" then
			v367:Destroy() 
		end 
	end 
	local v368 = UDim2.new(0, 0, 0, 0) 
	for v369, v370 in pairs(game.Players:GetChildren()) do
		pcall(function()
			local l__Name__371 = v370.Name 
			local v372 = Instance.new("TextButton") 
			v372.Size = UDim2.new(1, 0, 0, 50) 
			v372.Font = Enum.Font.Highway 
			v372.TextSize = 14 
			v372.BackgroundColor3 = Color3.new(1, 1, 1) 
			v372.BorderSizePixel = 0 
			v372.Text = l__Name__371 
			v372.Parent = MainScreenGui.PhoneCalls.ScrollingFrame 
			v372.MouseButton1Click:connect(function()
				if u79 then
					u79 = false 
					MainEvent:FireServer("PhoneCall", l__Name__371) 
					wait(1) 
					u79 = true 
				end 
			end) 
			v368 = v368 + UDim2.new(0, 0, 0, 60) 
		end) 
	end 
	MainScreenGui.PhoneCalls.ScrollingFrame.CanvasSize = v368 
	local v373 = MainModule.GetTime() 
	local v374 = math.floor(v373) 
	local v375 = math.floor((v373 - v374) * 60) 
	if string.len(tostring(v375)) == 1 then
		v375 = "0" .. tostring(v375) 
	end 
	local v376
	if v374 >= 12 then
		v376 = "PM" 
	else
		v376 = "AM" 
	end 
	if v374 > 12 then
		v374 = v374 - 12 
	end 
	if v374 == 0 then
		v374 = 12 
	end 
	MainScreenGui.PhoneCalls.Clock.TextLabel.Text = v374 .. ":" .. v375 .. " " .. v376 
	MainScreenGui.PhoneCalls.Visible = true 
end) 
MainScreenGui.PhoneCalls.TextButton.MouseButton1Click:connect(function()
	MainEvent:FireServer("AirPlaneMode") 
	wait(1) 
	MainScreenGui.PhoneCalls.TextButton.BackgroundColor3 = LocalPlayer.DataFolder.Information:WaitForChild("AirPlaneMode").Value == "0" and Color3.fromRGB(255, 123, 123) or Color3.fromRGB(156, 255, 151) 
end) 
MainScreenGui.PhoneCalls.Anonymous.MouseButton1Click:connect(function()
	MainEvent:FireServer("AnonymousMode") 
	wait(1) 
	MainScreenGui.PhoneCalls.Anonymous.BackgroundColor3 = BodyEffects.Anonymous.Value == false and Color3.fromRGB(255, 123, 123) or Color3.fromRGB(156, 255, 151) 
end) 
MainScreenGui.PhoneCalls.RingButton.MouseButton1Click:connect(function()
	MainEvent:FireServer("RingTone", MainScreenGui.PhoneCalls.RingBox.Text) 
end) 

Tool.Unequipped:connect(function()
	MainScreenGui.PhoneCalls.Visible = false 
end) 
BodyEffects.CallFrom.Changed:connect(function(p87)
	if p87 ~= nil then
		for v377 = 1, math.huge do
			if BodyEffects.CallFrom.Value == nil then
				break 
			end 
			if BodyEffects.CallFrom.Value.Character.BodyEffects.CallFrom.Value == LocalPlayer then
				break 
			end 
			Tool.TextureId = "rbxassetid://8538434908" 
			wait(0.2) 
			Tool.TextureId = "rbxassetid://8538435272" 
			wait(0.2) 
		end 
	end 
end) 
wait() 
local l__AirPlaneMode__378 = LocalPlayer.DataFolder.Information:FindFirstChild("AirPlaneMode") 
if l__AirPlaneMode__378 then
	MainScreenGui.PhoneCalls.TextButton.BackgroundColor3 = l__AirPlaneMode__378.Value == "0" and Color3.fromRGB(255, 123, 123) or Color3.fromRGB(156, 255, 151) 
end


