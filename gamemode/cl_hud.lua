--completely stolen from arizard

local HideElements = {
	["CHudBattery"] = true,
	["CHudCrosshair"] = true,
	["CHudHealth"] = true,
	["CHudAmmo"] = true
}

function GM:HUDShouldDraw( el )
	if HideElements[ el ] then
		return false
	else
		return true
	end
end

--local CrosshairStyle = CreateClientConVar("sk_crosshair_style", 1, true, false)
local XHairThickness = CreateClientConVar("sk_crosshair_thickness", 2, true, false)
local XHairGap = CreateClientConVar("sk_crosshair_gap", 8, true, false)
local XHairSize = CreateClientConVar("sk_crosshair_size", 8, true, false)
local XHairRed = CreateClientConVar("sk_crosshair_red", 255, true, false)
local XHairGreen = CreateClientConVar("sk_crosshair_green", 255, true, false)
local XHairBlue = CreateClientConVar("sk_crosshair_blue", 255, true, false)
local XHairAlpha = CreateClientConVar("sk_crosshair_alpha", 255, true, false)

function SaukeDrawCrosshair( x, y )
	local thick = XHairThickness:GetInt()
	local gap = XHairGap:GetInt()
	local size = XHairSize:GetInt()

	surface.SetDrawColor(XHairRed:GetInt(), XHairGreen:GetInt(), XHairBlue:GetInt(), XHairAlpha:GetInt())
	surface.DrawRect(x - (thick/2), y - (size + gap/2), thick, size )
	surface.DrawRect(x - (thick/2), y + (gap/2), thick, size )
	surface.DrawRect(x + (gap/2), y - (thick/2), size, thick )
	surface.DrawRect(x - (size + gap/2), y - (thick/2), size, thick )
end

hook.Add("HUDPaint", "SaukeDrawCrosshair", function()
	SaukeDrawCrosshair( ScrW()/2, ScrH()/2 )	
end)
