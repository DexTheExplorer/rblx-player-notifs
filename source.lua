function randomString() local length = math.random(10,20) local array = {} for i = 1, length do array[i] = string.char(math.random(32, 126)) end return table.concat(array) end
local function tween(o,i,g) game:GetService('TweenService'):Create(o,i,g):Play() end
local Players = game:GetService('Players')

local i = 32767

local Holder = Instance.new('ScreenGui')
Holder.Name = randomString()
if (syn) then syn.protect_gui(Holder) end
Holder.IgnoreGuiInset = true
Holder.Parent = game:GetService('CoreGui')

local NotificationHost = Instance.new("ScrollingFrame")
NotificationHost.Name = "NotificationHost"
NotificationHost.AnchorPoint = Vector2.new(0.5, 0)
NotificationHost.ClipsDescendants = false
NotificationHost.Position = UDim2.new(0.5, 0, 0, 0)
NotificationHost.BorderSizePixel = 0
NotificationHost.CanvasSize = UDim2.new(0, 0, 0, 0)
NotificationHost.ScrollingEnabled = false
NotificationHost.Parent = Holder

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = NotificationHost

local function createNotification(player, state)

	local BoundingBox = Instance.new("Frame")
	BoundingBox.Name = "BoundingBox"
	BoundingBox.AnchorPoint = Vector2.new(0.5,0)
	BoundingBox.Size = UDim2.new(0, 360, 0, 0)
	BoundingBox.ClipsDescendants = true
	BoundingBox.BackgroundTransparency = 1
	BoundingBox.Active = false

	local Notification = Instance.new("Frame")
	Notification.Name = "Notification"
	Notification.AnchorPoint = Vector2.new(0.5, 0)
	Notification.Size = UDim2.new(0, 350, 0, 75)
	Notification.Position = UDim2.new(0.5,0,-1,0)
	Notification.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Notification.Visible = false
	Notification.Parent = BoundingBox
	Notification.Active = false

	local PlayerIcon = Instance.new("ImageLabel")
	PlayerIcon.Name = "PlayerIcon"
	PlayerIcon.Size = UDim2.new(0, 65, 0, 65)
	PlayerIcon.BackgroundTransparency = 1
	PlayerIcon.Position = UDim2.new(0, 5, 0, 5)
	PlayerIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	PlayerIcon.Parent = Notification
	PlayerIcon.Active = false

	local UICorner = Instance.new("UICorner")
	UICorner.Parent = PlayerIcon

	local UICorner1 = Instance.new("UICorner")
	UICorner1.Parent = Notification

	local UIGradient = Instance.new("UIGradient")
	UIGradient.Rotation = 35
	UIGradient.Color = ColorSequence.new(Color3.fromRGB(50, 3, 58), Color3.fromRGB(26, 1, 22))
	UIGradient.Parent = Notification

	local DisplayName = Instance.new("TextLabel")
	DisplayName.Name = "DisplayName"
	DisplayName.Size = UDim2.new(0, 270, 0, 35)
	DisplayName.BackgroundTransparency = 1
	DisplayName.Position = UDim2.new(0, 75, 0, 5)
	DisplayName.ClipsDescendants = true
	DisplayName.FontSize = Enum.FontSize.Size28
	DisplayName.TextSize = 26
	DisplayName.RichText = true
	DisplayName.TextColor3 = Color3.fromRGB(255, 255, 255)
	DisplayName.Font = Enum.Font.Ubuntu
	DisplayName.TextXAlignment = Enum.TextXAlignment.Left
	DisplayName.Parent = Notification
	DisplayName.Active = false

	local UserName = Instance.new("TextLabel")
	UserName.Name = "UserName"
	UserName.Size = UDim2.new(0, 270, 0, 35)
	UserName.BackgroundTransparency = 1
	UserName.Position = UDim2.new(0, 75, 0, 35)
	UserName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	UserName.ClipsDescendants = true
	UserName.FontSize = Enum.FontSize.Size28
	UserName.TextSize = 26
	UserName.RichText = true
	UserName.TextColor3 = Color3.fromRGB(214, 214, 214)
	UserName.Text = "@Foxplorer"
	UserName.Font = Enum.Font.Ubuntu
	UserName.TextWrap = true
	UserName.TextXAlignment = Enum.TextXAlignment.Left
	UserName.Parent = Notification
	UserName.Active = false

	local UIStroke = Instance.new("UIStroke")
	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke.Thickness = 5
	UIStroke.Parent = Notification

	local Cover = Instance.new("Frame")
	Cover.Name = "Cover"
	Cover.Size = UDim2.new(0, 350, 0, 75)
	Cover.BorderSizePixel = 0
	Cover.Parent = Notification
	Cover.Active = false

	local CoverText = Instance.new("TextLabel")
	CoverText.Name = "CoverText"
	CoverText.AnchorPoint = Vector2.new(0.5, 0.5)
	CoverText.Size = UDim2.new(0, 200, 0, 50)
	CoverText.BackgroundTransparency = 1
	CoverText.Position = UDim2.new(0.5, 0, 0.5, 0)
	CoverText.FontSize = Enum.FontSize.Size36
	CoverText.TextSize = 35
	CoverText.RichText = true
	CoverText.TextColor3 = Color3.fromRGB(255, 255, 255)
	CoverText.Font = Enum.Font.Ubuntu
	CoverText.Parent = Cover
	CoverText.Active = false

	DisplayName.Text = player.DisplayName
	UserName.Text = '@'..player.Name
	PlayerIcon.Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)

	if state == 1 then
		CoverText.Text = "<b>Player Disconnected</b>"
		Cover.BackgroundColor3 = Color3.fromRGB(214, 47, 49)
		UIStroke.Color = Color3.fromRGB(214, 47, 49)
	elseif state == 0 then
		CoverText.Text = "<b>Player Connected</b>"
		Cover.BackgroundColor3 = Color3.fromRGB(30, 215, 96)
		UIStroke.Color = Color3.fromRGB(30, 215, 96)
	end

	return BoundingBox

end

local function fadeAll(objects)
	for i,v in pairs(objects:GetDescendants()) do
		if v.ClassName == 'Frame' then
			tween(v, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {BackgroundTransparency = 1})
		elseif v.ClassName == 'TextLabel' then
			tween(v, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {TextTransparency = 1})
		elseif v.ClassName == 'ImageLabel' then
			tween(v, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {ImageTransparency = 1})
		elseif v.ClassName == 'UIStroke' then
			tween(v, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {Transparency = 1})
		end
	end
end

local function animateNotification(player, state)

	local notif = createNotification(player, state)

	notif.LayoutOrder = i
	i = i - 1
	notif.Parent = NotificationHost

	tween(notif, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 360, 0, 100)})
	wait(0.2)
	notif.Notification.Visible = true
	tween(notif.Notification,  TweenInfo.new(0.2, Enum.EasingStyle.Linear), {Position = UDim2.new(0.5, 0, 0, 10)})
	wait(0.5)
	tween(notif.Notification.Cover, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {BackgroundTransparency = 1})
	tween(notif.Notification.Cover.CoverText, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {TextTransparency = 1})
	wait(3)
	fadeAll(notif)
	wait(0.6)
	notif:Destroy()

end

Players.PlayerAdded:Connect(function(player)
	spawn(animateNotification(player, 0))
end)

Players.PlayerRemoving:Connect(function(player)
	spawn(animateNotification(player, 1))
end)
