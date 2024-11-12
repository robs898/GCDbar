local GCD_DURATION = 1.5
local startTime = 0
local isOnGCD = false

local gcdBarFrame = CreateFrame("Frame", "GCDBarFrame", UIParent)
gcdBarFrame:SetWidth(100)
gcdBarFrame:SetHeight(10)
gcdBarFrame:SetPoint("CENTER", UIParent, "CENTER", 0, -100)
gcdBarFrame:EnableMouse(true)
gcdBarFrame:SetMovable(true)
gcdBarFrame:RegisterForDrag("LeftButton")
gcdBarFrame:SetScript("OnDragStart", function() gcdBarFrame:StartMoving() end)
gcdBarFrame:SetScript("OnDragStop", function() gcdBarFrame:StopMovingOrSizing() end)
gcdBarFrame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeSize = 0,
})

local bar = gcdBarFrame:CreateTexture(nil, "ARTWORK")
bar:SetPoint("LEFT", gcdBarFrame, "LEFT")
bar:SetWidth(100)
bar:SetHeight(10)
bar:SetTexture("Interface\\TargetingFrame\\UI-StatusBar")

gcdBarFrame:RegisterEvent("SPELLCAST_START")
gcdBarFrame:SetScript("OnEvent", function()
    startTime = GetTime()
    isOnGCD = true
    gcdBarFrame:Show()
end)

gcdBarFrame:SetScript("OnUpdate", function()
    if isOnGCD then
        local elapsed = GetTime() - startTime
        if elapsed >= GCD_DURATION then
            isOnGCD = false
            gcdBarFrame:Hide()
        else
            local progress = (GCD_DURATION - elapsed) / GCD_DURATION
            bar:SetWidth(100 * progress)
        end
    end
end)

gcdBarFrame:Hide()
