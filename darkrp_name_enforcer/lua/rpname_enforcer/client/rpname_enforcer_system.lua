local ShowEnforcer = false

local blurMat = Material( "pp/blurscreen" )
surface.CreateFont("Enforcer100-Bold", {font = "Lato-Bold",    size = ScrW()*0.0520833,     weight = 500})
surface.CreateFont("Enforcer100", {font = "Lato-Regular",    size = ScrW()*0.0520833,     weight = 500})
surface.CreateFont("Enforcer36", {font = "Lato-Regular",    size = ScrW()*0.01875,     weight = 500})
surface.CreateFont("Enforcer30-Bold", {font = "Lato-Bold",    size = ScrW()*0.015625,     weight = 500})
surface.CreateFont("Enforcer30", {font = "Lato-Regular",    size = ScrW()*0.015625,     weight = 500})
surface.CreateFont("Enforcer20", {font = "Lato-Regular",    size = ScrW()*0.010416,     weight = 500})

hook.Add( "OnScreenSizeChanged", "OnScreenSizeChanged_ChnageFont", function()
surface.CreateFont("Enforcer100-Bold", {font = "Lato-Bold",    size = ScrW()*0.0520833,     weight = 500})
surface.CreateFont("Enforcer100", {font = "Lato-Regular",    size = ScrW()*0.0520833,     weight = 500})
surface.CreateFont("Enforcer36", {font = "Lato-Regular",    size = ScrW()*0.01875,     weight = 500})
surface.CreateFont("Enforcer30-Bold", {font = "Lato-Bold",    size = ScrW()*0.015625,     weight = 500})
surface.CreateFont("Enforcer30", {font = "Lato-Regular",    size = ScrW()*0.015625,     weight = 500})
surface.CreateFont("Enforcer20", {font = "Lato-Regular",    size = ScrW()*0.010416,     weight = 500})
end)

local function DrawBlurRect(x, y, w, h, amount, density)
    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(blurMat)

    for i = 1, 6 do
		blurMat:SetFloat("$blur", (i / 3) * (3 or 6))
        blurMat:Recompute()
        render.UpdateScreenEffectTexture()
        render.SetScissorRect(0, 0, 0 + ScrW(), 0 + ScrH(), true)
        surface.DrawTexturedRect(0 * -1, 0 * -1, ScrW(), ScrH())
        render.SetScissorRect(0, 0, 0, 0, false)
    end
end

local Enforcer

function ShowEnforcerDerma()

    local ply = LocalPlayer()
    local FirstName = false
    local LastName = false

    Enforcer = vgui.Create("DFrame")
    Enforcer:SetSize(ScrW(), ScrH())
    Enforcer:SetAlpha(0)
    Enforcer:AlphaTo(255, 0.1)
    Enforcer:Center()
    Enforcer:SetTitle("")
    Enforcer:ShowCloseButton(false)
    Enforcer:SetDraggable(false)
    Enforcer:MakePopup()
    Enforcer.Paint = function(self, w, h)
        DrawBlurRect(0, 0, ScrW(), ScrH(), 3, 6)
        surface.SetDrawColor(15,15,15,50)
        surface.DrawRect(0, 0, w, h)
    end

    local CommunityName = vgui.Create( "DLabel", Enforcer )
	CommunityName:SetText( "Welcome to "..EnforcerConfig.CommunityName )
	CommunityName:SetFont("Enforcer100-Bold")
	CommunityName:SetColor(Color(255,255,255))
	CommunityName:SizeToContents()
	local w,h = CommunityName:GetSize()
	CommunityName:SetPos( ScrW()/2-(w/2), ScrH()*0.1 )

	local WhiteLine = vgui.Create( "DPanel",Enforcer )
	WhiteLine:SetPos( ScrW()/2-(ScrW()*((w/ScrW())+0.1)/2), ScrH()*0.2 ) -- Set the position of the panel
	WhiteLine:SetSize( ScrW()*((w/ScrW())+0.1), ScrH()*0.006 ) -- Set the size of the panel
	WhiteLine:SetPaintBackground( false )
	WhiteLine.Paint = function(self,w,h) -- The paint function
		draw.RoundedBox(10, 0, 0, w, h, Color(255,255,255,255))
	end

	local DoneButton = vgui.Create( "DButton", Enforcer ) // Create the button and parent it to the frame
	DoneButton:SetText( "Done" )					// Set the text on the button
	DoneButton:SetFont("Enforcer30")
	DoneButton:SetTextColor( Color(255,255,255) )
	DoneButton:SetPos( ScrW()/2-((ScrW()*0.2)/2), ScrH()*0.7 )					// Set the position on the frame
	DoneButton:SetSize( ScrW()*0.2, ScrH()*0.05 )					// Set the size
	DoneButton.DoClick = function()				// A custom function run when clicked ( note the . instead of : )
		NewName()
	end
	DoneButton.Paint = function(self,w,h)
		draw.RoundedBox(5, 0, 0, w, h, Color(9,148,65,255))
	end
		DoneButton:SetTextColor( Color(255,255,255,200) )
		DoneButton.Paint = function(self,w,h)
			draw.RoundedBox(5, 0, 0, w, h, Color(9,148,65,200))
		end
		local DoneBlock = vgui.Create( "DPanel",DoneButton )
		DoneBlock:SetPos(0,0 ) -- Set the position of the panel
		DoneBlock:SetSize(ScrW()*0.2, ScrH()*0.05 ) -- Set the size of the panel
		DoneBlock:SetPaintBackground( false )

	local EnterNameLabel = vgui.Create( "DLabel", Enforcer )
	EnterNameLabel:SetText( "Below you must enter a roleplay name for your character." )
	EnterNameLabel:SetFont("Enforcer36")
	EnterNameLabel:SetColor(Color(255,255,255))
	EnterNameLabel:SizeToContents()
	w,h = EnterNameLabel:GetSize()
	EnterNameLabel:SetPos( ScrW()/2-(w/2), ScrH()*0.225 )

	local EnterFirstNameLabel = vgui.Create( "DLabel", Enforcer )
	EnterFirstNameLabel:SetText( "First Name:" )
	EnterFirstNameLabel:SetFont("Enforcer30")
	EnterFirstNameLabel:SetColor(Color(255,255,255))
	EnterFirstNameLabel:SizeToContents()
	w,h = EnterFirstNameLabel:GetSize()
	EnterFirstNameLabel:SetPos( ScrW()/2-(w), ScrH()*0.275 )

		local BGTextEntry = vgui.Create( "DPanel",Enforcer )
		BGTextEntry:SetPos( ScrW()*0.51, ScrH()*0.281 ) -- Set the position of the panel
		BGTextEntry:SetSize( ScrW()*0.05,ScrH()*0.02 ) -- Set the size of the panel
		BGTextEntry:SetPaintBackground( false )
		BGTextEntry.Paint = function(self,w,h) -- The paint function
			draw.RoundedBox(3, 0, 0, w, h, Color(255,255,255,200))
		end

		local FirstNameTextEntry = vgui.Create( "DTextEntry", BGTextEntry ) -- create the form as a child of frame
		FirstNameTextEntry:SetPos(0, 0)
		FirstNameTextEntry:SetSize(ScrW()*0.05,ScrH()*0.02)
		FirstNameTextEntry:SetPlaceholderText( "First Name" )
		FirstNameTextEntry:SetDrawBackground(false)
		FirstNameTextEntry:SetTextColor(Color(33,33,33))
		FirstNameTextEntry:SetFont("Enforcer20")
		FirstNameTextEntry.OnChange = function(self)
			local txt = self:GetValue()
			local amt = string.len(txt)

			if EnforcerConfig.AllowNumbers == false then
				self:SetText(string.gsub(txt, "%d",""))
				self:SetValue(string.gsub(txt, "%d",""))
				self:SetCaretPos( #txt )
			end


			if amt > EnforcerConfig.FirstNameMaxChars then
				self:SetText(self.OldText)
				self:SetValue(self.OldText)
				self:SetCaretPos( EnforcerConfig.FirstNameMaxChars )
			else
				self.OldText = txt
			end

			if #txt > 0 then 
				FirstName = true
			else
				FirstName = false
				DoneBlock:SetVisible(true)
				DoneButton:SetTextColor( Color(255,255,255,200) )
				DoneButton.Paint = function(self,w,h)
					draw.RoundedBox(5, 0, 0, w, h, Color(9,148,65,200))
				end
			end
		 end

			if LastName == true and FirstName == true then
				if EnforcerConfig.AllowBlacklist then 
					CheckBlacklist()
				else
					DoneBlock:SetVisible(false)
					DoneButton:SetTextColor( Color(255,255,255) )
					DoneButton.Paint = function(self,w,h)
						draw.RoundedBox(5, 0, 0, w, h, Color(9,148,65))
					end
				end
			end

	local EnterLastNameLabel = vgui.Create( "DLabel", Enforcer )
	EnterLastNameLabel:SetText( "Last Name:" )
	EnterLastNameLabel:SetFont("Enforcer30")
	EnterLastNameLabel:SetColor(Color(255,255,255))
	EnterLastNameLabel:SizeToContents()
	w,h = EnterLastNameLabel:GetSize()
	EnterLastNameLabel:SetPos( ScrW()/2-(w), ScrH()*0.325 )

		local BGTextEntry = vgui.Create( "DPanel",Enforcer )
		BGTextEntry:SetPos( ScrW()*0.51, ScrH()*0.33 ) -- Set the position of the panel
		BGTextEntry:SetSize( ScrW()*0.05,ScrH()*0.02 ) -- Set the size of the panel
		BGTextEntry:SetPaintBackground( false )
		BGTextEntry.Paint = function(self,w,h) -- The paint function
			draw.RoundedBox(3, 0, 0, w, h, Color(255,255,255,200))
		end

		local LastNameTextEntry = vgui.Create( "DTextEntry", BGTextEntry ) -- create the form as a child of frame
		LastNameTextEntry:SetPos(0, 0)
		LastNameTextEntry:SetSize(ScrW()*0.05,ScrH()*0.02)
		LastNameTextEntry:SetPlaceholderText( "Last Name" )
		LastNameTextEntry:SetDrawBackground(false)
		LastNameTextEntry:SetTextColor(Color(33,33,33))
		LastNameTextEntry:SetFont("Enforcer20")
		LastNameTextEntry.OnChange = function(self)
			local txt = self:GetValue()
			local amt = string.len(txt)

			if EnforcerConfig.AllowNumbers == false then
				self:SetText(string.gsub(txt, "%d",""))
				self:SetValue(string.gsub(txt, "%d",""))
				self:SetCaretPos( #txt )
			end


			if amt > EnforcerConfig.LastNameMaxChars then
				self:SetText(self.OldText)
				self:SetValue(self.OldText)
				self:SetCaretPos( EnforcerConfig.LastNameMaxChars )
			else
				self.OldText = txt
			end

			if #FirstNameTextEntry:GetValue() > 0 and #txt > 0 then
				if EnforcerConfig.AllowBlacklist then 
					CheckBlacklist()
				else
					DoneBlock:SetVisible(false)
					DoneButton:SetTextColor( Color(255,255,255) )
					DoneButton.Paint = function(self,w,h)
						draw.RoundedBox(5, 0, 0, w, h, Color(9,148,65))
					end
				end
			elseif #txt > 0 then 
				LastName = true
			else
				LastName = false
				DoneBlock:SetVisible(true)
				DoneButton:SetTextColor( Color(255,255,255,200) )
				DoneButton.Paint = function(self,w,h)
					draw.RoundedBox(5, 0, 0, w, h, Color(9,148,65,200))
				end
			end
		 end

	if EnforcerConfig.ShowCloseButton then
		local Close = vgui.Create( "DImageButton", Enforcer )
		Close:SetPos( ScrW()*0.975, ScrH()*0.01 )				-- Set position
		Close:SetSize( ScrW()*0.016, ScrW()*0.016 )			-- OPTIONAL: Use instead of SizeToContents() if you know/want to fix the size
		Close:SetImage( "x.png" )	-- Set the material - relative to /materials/ directory
		Close:SizeToContents()				-- OPTIONAL: Use instead of SetSize if you want to resize automatically ( without stretching )
		Close.DoClick = function()
			Enforcer:Close()
			ShowEnforcer = false
		end
	end

	function CheckBlacklist()
		local allow = true
		for k,v in pairs(EnforcerConfig.Blacklist) do 
			if string.find(string.lower(FirstNameTextEntry:GetValue()), string.lower(v)) then allow = false break end
			if string.find(string.lower(LastNameTextEntry:GetValue()), string.lower(v)) then allow = false break end
		end	

		if allow then 
			DoneBlock:SetVisible(false)
			DoneButton:SetTextColor( Color(255,255,255) )
			DoneButton.Paint = function(self,w,h)
				draw.RoundedBox(5, 0, 0, w, h, Color(9,148,65))
			end
		end	
	end

	function NewName()
		net.Start("NewName")
			net.WriteString(FirstNameTextEntry:GetValue().." "..LastNameTextEntry:GetValue())
		net.SendToServer()
	end


end

net.Receive("NewNameDone", function()
	Enforcer:Close()
end)

net.Receive("ShowEnforcer", function()
	ShowEnforcer = true
	ShowEnforcerDerma()
	DrawBlurRect()
end)