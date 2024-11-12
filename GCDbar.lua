local GCD_DURATION = 1.5
local startTime = 0
local isOnGCD = false
local isCasting = false

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

local function StartGCD()
    startTime = GetTime()
    isOnGCD = true
    gcdBarFrame:Show()
end

local function CompleteGCD()
    isOnGCD = false
    gcdBarFrame:Hide()
end

gcdBarFrame:RegisterEvent("SPELLCAST_START")
gcdBarFrame:RegisterEvent("SPELLCAST_STOP")
gcdBarFrame:RegisterEvent("SPELLCAST_FAILED")
gcdBarFrame:RegisterEvent("SPELLCAST_INTERRUPTED")
gcdBarFrame:SetScript("OnEvent", function()
    if event == "SPELLCAST_START" then
        isCasting = true
        StartGCD()
    elseif event == "SPELLCAST_STOP" then
        if isCasting == false then
            StartGCD()
        else
            CompleteGCD()
            isCasting = false
        end
    else
        CompleteGCD()
    end
end)

gcdBarFrame:SetScript("OnUpdate", function()
    if isOnGCD then
        local elapsed = GetTime() - startTime
        if elapsed >= GCD_DURATION then
            CompleteGCD()
        else
            local progress = (GCD_DURATION - elapsed) / GCD_DURATION
            bar:SetWidth(100 * progress)
        end
    end
end)

gcdBarFrame:Hide()
