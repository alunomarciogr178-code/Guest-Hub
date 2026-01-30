local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local TS = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local Data = player:WaitForChild("Data")
local Level = Data:WaitForChild("Level")
local Beli = Data:WaitForChild("Beli")
local Fragments = Data:WaitForChild("Fragments")

local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local Remotes = RS:WaitForChild("Remotes")
local CommF = Remotes:WaitForChild("CommF_")

local function fireRemote(action, ...)
    pcall(CommF.InvokeServer, CommF, action, ...)
end

player.CharacterAdded:Connect(function(ch)
    character = ch
    humanoid = ch:WaitForChild("Humanoid")
    rootPart = ch:WaitForChild("HumanoidRootPart")
end)

Lighting.GlobalShadows = false
Lighting.FogEnd = 9e9
Lighting.Brightness = 2
settings().Rendering.QualityLevel = "Level01"
for _,v in pairs(Lighting:GetChildren()) do
    if v:IsA("PostEffect") then v.Enabled = false end
end

fireRemote("SetTeam", "Marines")

local scriptConfig = { inSea2 = false }

local function detectAdmin(p)
    local n = p.Name:lower()
    if n:find("admin") or n:find("mod") or n:find("dev") or n:find("owner") or p:GetAttribute("Admin") or p:FindFirstChild("AdminTag") then
        return true
    end
    return false
end

local function hopServer()
    local ok, data = pcall(function()
        return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
    end)
    if ok and data and data.data then
        for _,s in ipairs(data.data) do
            if s.playing and s.playing < 6 and s.id ~= game.JobId then
                TS:TeleportToPlaceInstance(game.PlaceId, s.id)
                break
            end
        end
    end
end

Players.PlayerAdded:Connect(function(p)
    task.spawn(function()
        task.wait(1.2)
        if detectAdmin(p) then hopServer() end
    end)
end)

task.spawn(function()
    while task.wait(6) do
        for _,p in ipairs(Players:GetPlayers()) do
            if p ~= player and detectAdmin(p) then hopServer() break end
        end
    end
end)

task.spawn(function()
    while task.wait(1800) do hopServer() end
end)

task.spawn(function()
    while task.wait(1.4) do
        if humanoid.Health <= 0 then
            pcall(function()
                humanoid:Destroy()
                Instance.new("Humanoid", character)
            end)
        end
    end
end)

local function getQuestInfo()
    local MyLevel = player.Data.Level.Value
    local World1 = MyLevel < 700
    local World2 = MyLevel >= 700 and MyLevel < 1500
    local World3 = MyLevel >= 1500
    local Mon, LevelQuest, NameQuest, NameMon, CFrameQuest, CFrameMon
    if World1 then
        if ((MyLevel == 1) or (MyLevel <= 9)) then
            Mon = "Bandit";
            LevelQuest = 1;
            NameQuest = "BanditQuest1";
            NameMon = "Bandit";
            CFrameQuest = CFrame.new(1059, 17, 1546);
            CFrameMon = CFrame.new(943, 45, 1562);
        elseif ((MyLevel == 10) or (MyLevel <= 14)) then
            Mon = "Monkey";
            LevelQuest = 1;
            NameQuest = "JungleQuest";
            NameMon = "Monkey";
            CFrameQuest = CFrame.new( -1598, 37, 153);
            CFrameMon = CFrame.new( -1524, 50, 37);
        elseif ((MyLevel == 15) or (MyLevel <= 29)) then
            Mon = "Gorilla";
            LevelQuest = 2;
            NameQuest = "JungleQuest";
            NameMon = "Gorilla";
            CFrameQuest = CFrame.new( -1598, 37, 153);
            CFrameMon = CFrame.new( -1128, 40, -451);
        elseif ((MyLevel == 30) or (MyLevel <= 39)) then
            Mon = "Pirate";
            LevelQuest = 1;
            NameQuest = "BuggyQuest1";
            NameMon = "Pirate";
            CFrameQuest = CFrame.new( -1140, 4, 3829);
            CFrameMon = CFrame.new( -1262, 40, 3905);
        elseif ((MyLevel == 40) or (MyLevel <= 59)) then
            Mon = "Brute";
            LevelQuest = 2;
            NameQuest = "BuggyQuest1";
            NameMon = "Brute";
            CFrameQuest = CFrame.new( -1140, 4, 3829);
            CFrameMon = CFrame.new( -976, 55, 4304);
        elseif ((MyLevel == 60) or (MyLevel <= 74)) then
            Mon = "Desert Bandit";
            LevelQuest = 1;
            NameQuest = "DesertQuest";
            NameMon = "Desert Bandit";
            CFrameQuest = CFrame.new(897, 6, 4389);
            CFrameMon = CFrame.new(924, 7, 4482);
        elseif ((MyLevel == 75) or (MyLevel <= 89)) then
            Mon = "Desert Officer";
            LevelQuest = 2;
            NameQuest = "DesertQuest";
            NameMon = "Desert Officer";
            CFrameQuest = CFrame.new(897, 6, 4389);
            CFrameMon = CFrame.new(1608, 9, 4371);
        elseif ((MyLevel == 90) or (MyLevel <= 99)) then
            Mon = "Snow Bandit";
            LevelQuest = 1;
            NameQuest = "SnowQuest";
            NameMon = "Snow Bandit";
            CFrameQuest = CFrame.new(1385, 87, -1298);
            CFrameMon = CFrame.new(1362, 120, -1531);
        elseif ((MyLevel == 100) or (MyLevel <= 119)) then
            Mon = "Snowman";
            LevelQuest = 2;
            NameQuest = "SnowQuest";
            NameMon = "Snowman";
            CFrameQuest = CFrame.new(1385, 87, -1298);
            CFrameMon = CFrame.new(1243, 140, -1437);
        elseif ((MyLevel == 120) or (MyLevel <= 149)) then
            Mon = "Chief Petty Officer";
            LevelQuest = 1;
            NameQuest = "MarineQuest2";
            NameMon = "Chief Petty Officer";
            CFrameQuest = CFrame.new( -5035, 29, 4326);
            CFrameMon = CFrame.new( -4881, 23, 4274);
        elseif ((MyLevel == 150) or (MyLevel <= 174)) then
            Mon = "Sky Bandit";
            LevelQuest = 1;
            NameQuest = "SkyQuest";
            NameMon = "Sky Bandit";
            CFrameQuest = CFrame.new( -4844, 718, -2621);
            CFrameMon = CFrame.new( -4953, 296, -2899);
        elseif ((MyLevel == 175) or (MyLevel <= 189)) then
            Mon = "Dark Master";
            LevelQuest = 2;
            NameQuest = "SkyQuest";
            NameMon = "Dark Master";
            CFrameQuest = CFrame.new( -4844, 718, -2621);
            CFrameMon = CFrame.new( -5260, 391, -2229);
        elseif ((MyLevel == 190) or (MyLevel <= 209)) then
            Mon = "Prisoner";
            LevelQuest = 1;
            NameQuest = "PrisonerQuest";
            NameMon = "Prisoner";
            CFrameQuest = CFrame.new(5306, 2, 477);
            CFrameMon = CFrame.new(5099, "-0", 474);
        elseif ((MyLevel == 210) or (MyLevel <= 249)) then
            Mon = "Dangerous Prisoner";
            LevelQuest = 2;
            NameQuest = "PrisonerQuest";
            NameMon = "Dangerous Prisoner";
            CFrameQuest = CFrame.new(5306, 2, 477);
            CFrameMon = CFrame.new(5655, 16, 866);
        elseif ((MyLevel == 250) or (MyLevel <= 274)) then
            Mon = "Toga Warrior";
            LevelQuest = 1;
            NameQuest = "ColosseumQuest";
            NameMon = "Toga Warrior";
            CFrameQuest = CFrame.new( -1581, 7, -2982);
            CFrameMon = CFrame.new( -1820, 51, -2741);
        elseif ((MyLevel == 275) or (MyLevel <= 299)) then
            Mon = "Gladiator";
            LevelQuest = 2;
            NameQuest = "ColosseumQuest";
            NameMon = "Gladiator";
            CFrameQuest = CFrame.new( -1581, 7, -2982);
            CFrameMon = CFrame.new( -1268, 30, -2996);
        elseif ((MyLevel == 300) or (MyLevel <= 324)) then
            Mon = "Military Soldier";
            LevelQuest = 1;
            NameQuest = "MagmaQuest";
            NameMon = "Military Soldier";
            CFrameQuest = CFrame.new( -5319, 12, 8515);
            CFrameMon = CFrame.new( -5335, 46, 8638);
        elseif ((MyLevel == 325) or (MyLevel <= 374)) then
            Mon = "Military Spy";
            LevelQuest = 2;
            NameQuest = "MagmaQuest";
            NameMon = "Military Spy";
            CFrameQuest = CFrame.new( -5319, 12, 8515);
            CFrameMon = CFrame.new( -5803, 86, 8829);
        elseif ((MyLevel == 375) or (MyLevel <= 399)) then
            Mon = "Fishman Warrior";
            LevelQuest = 1;
            NameQuest = "FishmanQuest";
            NameMon = "Fishman Warrior";
            CFrameQuest = CFrame.new(61122, 18, 1567);
            CFrameMon = CFrame.new(60998, 50, 1534);
        elseif ((MyLevel == 400) or (MyLevel <= 449)) then
            Mon = "Fishman Commando";
            LevelQuest = 2;
            NameQuest = "FishmanQuest";
            NameMon = "Fishman Commando";
            CFrameQuest = CFrame.new(61122, 18, 1567);
            CFrameMon = CFrame.new(61866, 55, 1655);
        elseif ((MyLevel == 450) or (MyLevel <= 474)) then
            Mon = "God's Guard";
            LevelQuest = 1;
            NameQuest = "SkyExp1Quest";
            NameMon = "God's Guard";
            CFrameQuest = CFrame.new( -4720, 846, -1951);
            CFrameMon = CFrame.new( -4720, 846, -1951);
        elseif ((MyLevel == 475) or (MyLevel <= 524)) then
            Mon = "Shanda";
            LevelQuest = 2;
            NameQuest = "SkyExp1Quest";
            NameMon = "Shanda";
            CFrameQuest = CFrame.new( -7861, 5545, -381);
            CFrameMon = CFrame.new( -7741, 5580, -395);
        elseif ((MyLevel == 525) or (MyLevel <= 549)) then
            Mon = "Royal Squad";
            LevelQuest = 1;
            NameQuest = "SkyExp2Quest";
            NameMon = "Royal Squad";
            CFrameQuest = CFrame.new( -7903, 5636, -1412);
            CFrameMon = CFrame.new( -7727, 5650, -1410);
        elseif ((MyLevel == 550) or (MyLevel <= 624)) then
            Mon = "Royal Soldier";
            LevelQuest = 2;
            NameQuest = "SkyExp2Quest";
            NameMon = "Royal Soldier";
            CFrameQuest = CFrame.new( -7903, 5636, -1412);
            CFrameMon = CFrame.new( -7894, 5640, -1629);
        elseif ((MyLevel == 625) or (MyLevel <= 649)) then
            Mon = "Galley Pirate";
            LevelQuest = 1;
            NameQuest = "FountainQuest";
            NameMon = "Galley Pirate";
            CFrameQuest = CFrame.new(5258, 39, 4052);
            CFrameMon = CFrame.new(5391, 70, 4023);
        elseif (MyLevel >= 650) then
            Mon = "Galley Captain";
            LevelQuest = 2;
            NameQuest = "FountainQuest";
            NameMon = "Galley Captain";
            CFrameQuest = CFrame.new(5258, 39, 4052);
            CFrameMon = CFrame.new(5985, 70, 4790);
        end
    elseif World2 then
        if ((MyLevel == 700) or (MyLevel <= 724)) then
            Mon = "Raider";
            LevelQuest = 1;
            NameQuest = "Area1Quest";
            NameMon = "Raider";
            CFrameQuest = CFrame.new( -427, 73, 1835);
            CFrameMon = CFrame.new( -614, 90, 2240);
        elseif ((MyLevel == 725) or (MyLevel <= 774)) then
            Mon = "Mercenary";
            LevelQuest = 2;
            NameQuest = "Area1Quest";
            NameMon = "Mercenary";
            CFrameQuest = CFrame.new( -427, 73, 1835);
            CFrameMon = CFrame.new( -867, 110, 1621);
        elseif ((MyLevel == 775) or (MyLevel <= 874)) then
            Mon = "Swan Pirate";
            LevelQuest = 1;
            NameQuest = "Area2Quest";
            NameMon = "Swan Pirate";
            CFrameQuest = CFrame.new(635, 73, 919);
            CFrameMon = CFrame.new(635, 73, 919);
        elseif ((MyLevel == 875) or (MyLevel <= 899)) then
            Mon = "Marine Lieutenant";
            LevelQuest = 1;
            NameQuest = "MarineQuest3";
            NameMon = "Marine Lieutenant";
            CFrameQuest = CFrame.new( -2441, 73, -3219);
            CFrameMon = CFrame.new( -2552, 110, -3050);
        elseif ((MyLevel == 900) or (MyLevel <= 949)) then
            Mon = "Marine Captain";
            LevelQuest = 2;
            NameQuest = "MarineQuest3";
            NameMon = "Marine Captain";
            CFrameQuest = CFrame.new( -2441, 73, -3219);
            CFrameMon = CFrame.new( -1695, 110, -3299);
        elseif ((MyLevel == 950) or (MyLevel <= 974)) then
            Mon = "Zombie";
            LevelQuest = 1;
            NameQuest = "ZombieQuest";
            NameMon = "Zombie";
            CFrameQuest = CFrame.new( -5495, 48, -794);
            CFrameMon = CFrame.new( -5715, 90, -917);
        elseif ((MyLevel == 975) or (MyLevel <= 999)) then
            Mon = "Vampire";
            LevelQuest = 2;
            NameQuest = "ZombieQuest";
            NameMon = "Vampire";
            CFrameQuest = CFrame.new( -5495, 48, -794);
            CFrameMon = CFrame.new( -6027, 50, -1130);
        elseif ((MyLevel == 1000) or (MyLevel <= 1049)) then
            Mon = "Snow Trooper";
            LevelQuest = 1;
            NameQuest = "SnowMountainQuest";
            NameMon = "Snow Trooper";
            CFrameQuest = CFrame.new(607, 401, -5371);
            CFrameMon = CFrame.new(445, 440, -5175);
        elseif ((MyLevel == 1050) or (MyLevel <= 1099)) then
            Mon = "Winter Warrior";
            LevelQuest = 2;
            NameQuest = "SnowMountainQuest";
            NameMon = "Winter Warrior";
            CFrameQuest = CFrame.new(607, 401, -5371);
            CFrameMon = CFrame.new(1224, 460, -5332);
        elseif ((MyLevel == 1100) or (MyLevel <= 1124)) then
            Mon = "Lab Subordinate";
            LevelQuest = 1;
            NameQuest = "IceSideQuest";
            NameMon = "Lab Subordinate";
            CFrameQuest = CFrame.new( -6061, 16, -4904);
            CFrameMon = CFrame.new( -5941, 50, -4322);
        elseif ((MyLevel == 1125) or (MyLevel <= 1174)) then
            Mon = "Horned Warrior";
            LevelQuest = 2;
            NameQuest = "IceSideQuest";
            NameMon = "Horned Warrior";
            CFrameQuest = CFrame.new( -6061, 16, -4904);
            CFrameMon = CFrame.new( -6306, 50, -5752);
        elseif ((MyLevel == 1175) or (MyLevel <= 1199)) then
            Mon = "Magma Ninja";
            LevelQuest = 1;
            NameQuest = "FireSideQuest";
            NameMon = "Magma Ninja";
            CFrameQuest = CFrame.new( -5430, 16, -5298);
            CFrameMon = CFrame.new( -5233, 60, -6227);
        elseif ((MyLevel == 1200) or (MyLevel <= 1249)) then
            Mon = "Lava Pirate";
            LevelQuest = 2;
            NameQuest = "FireSideQuest";
            NameMon = "Lava Pirate";
            CFrameQuest = CFrame.new( -5430, 16, -5298);
            CFrameMon = CFrame.new( -4955, 60, -4836);
        elseif ((MyLevel == 1250) or (MyLevel <= 1274)) then
            Mon = "Ship Deckhand";
            LevelQuest = 1;
            NameQuest = "ShipQuest1";
            NameMon = "Ship Deckhand";
            CFrameQuest = CFrame.new(1033, 125, 32909);
            CFrameMon = CFrame.new(1033, 125, 32909);
        elseif ((MyLevel == 1275) or (MyLevel <= 1299)) then
            Mon = "Ship Engineer";
            LevelQuest = 2;
            NameQuest = "ShipQuest1";
            NameMon = "Ship Engineer";
            CFrameQuest = CFrame.new(1033, 125, 32909);
            CFrameMon = CFrame.new(809, 80, 33090);
        elseif ((MyLevel == 1300) or (MyLevel <= 1324)) then
            Mon = "Ship Steward";
            LevelQuest = 1;
            NameQuest = "ShipQuest2";
            NameMon = "Ship Steward";
            CFrameQuest = CFrame.new(973, 125, 33245);
            CFrameMon = CFrame.new(838, 160, 33408);
        elseif ((MyLevel == 1325) or (MyLevel <= 1349)) then
            Mon = "Ship Officer";
            LevelQuest = 2;
            NameQuest = "ShipQuest2";
            NameMon = "Ship Officer";
            CFrameQuest = CFrame.new(973, 125, 33245);
            CFrameMon = CFrame.new(1238, 220, 33148);
        elseif ((MyLevel == 1350) or (MyLevel <= 1374)) then
            Mon = "Arctic Warrior";
            LevelQuest = 1;
            NameQuest = "FrostQuest";
            NameMon = "Arctic Warrior";
            CFrameQuest = CFrame.new(5668, 28, -6484);
            CFrameMon = CFrame.new(5836, 80, -6257);
        elseif ((MyLevel == 1375) or (MyLevel <= 1424)) then
            Mon = "Snow Lurker";
            LevelQuest = 2;
            NameQuest = "FrostQuest";
            NameMon = "Snow Lurker";
            CFrameQuest = CFrame.new(5668, 28, -6484);
            CFrameMon = CFrame.new(5700, 80, -6724);
        elseif ((MyLevel == 1425) or (MyLevel <= 1449)) then
            Mon = "Sea Soldier";
            LevelQuest = 1;
            NameQuest = "ForgottenQuest";
            NameMon = "Sea Soldier";
            CFrameQuest = CFrame.new( -3056, 240, -10145);
            CFrameMon = CFrame.new( -2583, 80, -9821);
        elseif (MyLevel >= 1450) then
            Mon = "Water Fighter";
            LevelQuest = 2;
            NameQuest = "ForgottenQuest";
            NameMon = "Water Fighter";
            CFrameQuest = CFrame.new( -3056, 240, -10145);
            CFrameMon = CFrame.new( -3339, 290, -10412);
        end
    elseif World3 then
        if ((MyLevel == 1500) or (MyLevel <= 1524)) then
            Mon = "Pirate Millionaire";
            LevelQuest = 1;
            NameQuest = "PiratePortQuest";
            NameMon = "Pirate Millionaire";
            CFrameQuest = CFrame.new( -291, 44, 5580);
            CFrameMon = CFrame.new( -44, 70, 5623);
        elseif ((MyLevel == 1525) or (MyLevel <= 1574)) then
            Mon = "Pistol Billionaire";
            LevelQuest = 2;
            NameQuest = "PiratePortQuest";
            NameMon = "Pistol Billionaire";
            CFrameQuest = CFrame.new( -291, 44, 5580);
            CFrameMon = CFrame.new(219, 105, 6018);
        elseif ((MyLevel == 1575) or (MyLevel <= 1599)) then
            Mon = "Dragon Crew Warrior";
            LevelQuest = 1;
            NameQuest = "AmazonQuest";
            NameMon = "Dragon Crew Warrior";
            CFrameQuest = CFrame.new(5834, 51, -1103);
            CFrameMon = CFrame.new(5992, 90, -1581);
        elseif ((MyLevel == 1600) or (MyLevel <= 1624)) then
            Mon = "Dragon Crew Archer";
            NameQuest = "AmazonQuest";
            LevelQuest = 2;
            NameMon = "Dragon Crew Archer";
            CFrameQuest = CFrame.new(5834, 51, -1103);
            CFrameMon = CFrame.new(6472, 370, -151);
        elseif ((MyLevel == 1625) or (MyLevel <= 1649)) then
            Mon = "Female Islander";
            NameQuest = "AmazonQuest2";
            LevelQuest = 1;
            NameMon = "Female Islander";
            CFrameQuest = CFrame.new(5448, 602, 748);
            CFrameMon = CFrame.new(4836, 740, 928);
        elseif ((MyLevel == 1650) or (MyLevel <= 1699)) then
            Mon = "Giant Islander";
            NameQuest = "AmazonQuest2";
            LevelQuest = 2;
            NameMon = "Giant Islander";
            CFrameQuest = CFrame.new(5448, 602, 748);
            CFrameMon = CFrame.new(4784, 660, 155);
        elseif ((MyLevel == 1700) or (MyLevel <= 1724)) then
            Mon = "Marine Commodore";
            LevelQuest = 1;
            NameQuest = "MarineTreeIsland";
            NameMon = "Marine Commodore";
            CFrameQuest = CFrame.new(2180, 29, -6738);
            CFrameMon = CFrame.new(3156, 120, -7837);
        elseif ((MyLevel == 1725) or (MyLevel <= 1774)) then
            Mon = "Marine Rear Admiral";
            NameMon = "Marine Rear Admiral";
            NameQuest = "MarineTreeIsland";
            LevelQuest = 2;
            CFrameQuest = CFrame.new(2180, 29, -6738);
            CFrameMon = CFrame.new(3205, 120, -6742);
        elseif ((MyLevel == 1775) or (MyLevel <= 1799)) then
            Mon = "Fishman Raider";
            LevelQuest = 1;
            NameQuest = "DeepForestIsland3";
            NameMon = "Fishman Raider";
            CFrameQuest = CFrame.new( -10581, 332, -8758);
            CFrameMon = CFrame.new( -10550, 380, -8574);
        elseif ((MyLevel == 1800) or (MyLevel <= 1824)) then
            Mon = "Fishman Captain";
            LevelQuest = 2;
            NameQuest = "DeepForestIsland3";
            NameMon = "Fishman Captain";
            CFrameQuest = CFrame.new( -10581, 332, -8758);
            CFrameMon = CFrame.new( -10764, 380, -8799);
        elseif ((MyLevel == 1825) or (MyLevel <= 1849)) then
            Mon = "Forest Pirate";
            LevelQuest = 1;
            NameQuest = "DeepForestIsland";
            NameMon = "Forest Pirate";
            CFrameQuest = CFrame.new( -13233, 332, -7626);
            CFrameMon = CFrame.new( -13335, 380, -7660);
        elseif ((MyLevel == 1850) or (MyLevel <= 1899)) then
            Mon = "Mythological Pirate";
            LevelQuest = 2;
            NameQuest = "DeepForestIsland";
            NameMon = "Mythological Pirate";
            CFrameQuest = CFrame.new( -13233, 332, -7626);
            CFrameMon = CFrame.new( -13844, 520, -7016);
        elseif ((MyLevel == 1900) or (MyLevel <= 1924)) then
            Mon = "Jungle Pirate";
            LevelQuest = 1;
            NameQuest = "DeepForestIsland2";
            NameMon = "Jungle Pirate";
            CFrameQuest = CFrame.new( -12682, 391, -9901);
            CFrameMon = CFrame.new( -12166, 380, -10375);
        elseif ((MyLevel == 1925) or (MyLevel <= 1974)) then
            Mon = "Musketeer Pirate";
            LevelQuest = 2;
            NameQuest = "DeepForestIsland2";
            NameMon = "Musketeer Pirate";
            CFrameQuest = CFrame.new( -12682, 391, -9901);
            CFrameMon = CFrame.new( -13098, 450, -9831);
        elseif ((MyLevel == 1975) or (MyLevel <= 1999)) then
            Mon = "Reborn Skeleton";
            LevelQuest = 1;
            NameQuest = "HauntedQuest1";
            NameMon = "Reborn Skeleton";
            CFrameQuest = CFrame.new( -9481, 142, 5565);
            CFrameMon = CFrame.new( -8680, 190, 5852);
        elseif ((MyLevel == 2000) or (MyLevel <= 2024)) then
            Mon = "Living Zombie";
            LevelQuest = 2;
            NameQuest = "HauntedQuest1";
            NameMon = "Living Zombie";
            CFrameQuest = CFrame.new( -9481, 142, 5565);
            CFrameMon = CFrame.new( -10144, 140, 5932);
        elseif ((MyLevel == 2025) or (MyLevel <= 2049)) then
            Mon = "Demonic Soul";
            LevelQuest = 1;
            NameQuest = "HauntedQuest2";
            NameMon = "Demonic Soul";
            CFrameQuest = CFrame.new( -9515, 172, 607);
            CFrameMon = CFrame.new( -9275, 210, 6166);
        elseif ((MyLevel == 2050) or (MyLevel <= 2074)) then
            Mon = "Posessed Mummy";
            LevelQuest = 2;
            NameQuest = "HauntedQuest2";
            NameMon = "Posessed Mummy";
            CFrameQuest = CFrame.new( -9515, 172, 607);
            CFrameMon = CFrame.new( -9442, 60, 6304);
        elseif ((MyLevel == 2075) or (MyLevel <= 2099)) then
            Mon = "Peanut Scout";
            LevelQuest = 1;
            NameQuest = "NutsIslandQuest";
            NameMon = "Peanut Scout";
            CFrameQuest = CFrame.new( -2104, 38, -10194);
            CFrameMon = CFrame.new( -1870, 100, -10225);
        elseif ((MyLevel == 2100) or (MyLevel <= 2124)) then
            Mon = "Peanut President";
            LevelQuest = 2;
            NameQuest = "NutsIslandQuest";
            NameMon = "Peanut President";
            CFrameQuest = CFrame.new( -2104, 38, -10194);
            CFrameMon = CFrame.new( -2005, 100, -10585);
        elseif ((MyLevel == 2125) or (MyLevel <= 2149)) then
            Mon = "Ice Cream Chef";
            LevelQuest = 1;
            NameQuest = "IceCreamIslandQuest";
            NameMon = "Ice Cream Chef";
            CFrameQuest = CFrame.new( -818, 66, -10964);
            CFrameMon = CFrame.new( -501, 100, -10883);
        elseif ((MyLevel == 2150) or (MyLevel <= 2199)) then
            Mon = "Ice Cream Commander";
            LevelQuest = 2;
            NameQuest = "IceCreamIslandQuest";
            NameMon = "Ice Cream Commander";
            CFrameQuest = CFrame.new( -818, 66, -10964);
            CFrameMon = CFrame.new( -690, 100, -11350);
        elseif ((MyLevel == 2200) or (MyLevel <= 2224)) then
            Mon = "Cookie Crafter";
            LevelQuest = 1;
            NameQuest = "CakeQuest1";
            NameMon = "Cookie Crafter";
            CFrameQuest = CFrame.new( -2023, 38, -12028);
            CFrameMon = CFrame.new( -2332, 90, -12049);
        elseif ((MyLevel == 2225) or (MyLevel <= 2249)) then
            Mon = "Cake Guard";
            LevelQuest = 2;
            NameQuest = "CakeQuest1";
            NameMon = "Cake Guard";
            CFrameQuest = CFrame.new( -2023, 38, -12028);
            CFrameMon = CFrame.new( -1514, 90, -12422);
        elseif ((MyLevel == 2250) or (MyLevel <= 2274)) then
            Mon = "Baking Staff";
            LevelQuest = 1;
            NameQuest = "CakeQuest2";
            NameMon = "Baking Staff";
            CFrameQuest = CFrame.new( -1931, 38, -12840);
            CFrameMon = CFrame.new( -1930, 90, -12963);
        elseif ((MyLevel == 2275) or (MyLevel <= 2299)) then
            Mon = "Head Baker";
            LevelQuest = 2;
            NameQuest = "CakeQuest2";
            NameMon = "Head Baker";
            CFrameQuest = CFrame.new( -1931, 38, -12840);
            CFrameMon = CFrame.new( -2123, 110, -12777);
        elseif ((MyLevel == 2300) or (MyLevel <= 2324)) then
            Mon = "Cocoa Warrior";
            LevelQuest = 1;
            NameQuest = "ChocQuest1";
            NameMon = "Cocoa Warrior";
            CFrameQuest = CFrame.new(235, 25, -12199);
            CFrameMon = CFrame.new(110, 80, -12245);
        elseif ((MyLevel == 2325) or (MyLevel <= 2349)) then
            Mon = "Chocolate Bar Battler";
            LevelQuest = 2;
            NameQuest = "ChocQuest1";
            NameMon = "Chocolate Bar Battler";
            CFrameQuest = CFrame.new(235, 25, -12199);
            CFrameMon = CFrame.new(579, 80, -12413);
        elseif ((MyLevel == 2350) or (MyLevel <= 2374)) then
            Mon = "Sweet Thief";
            LevelQuest = 1;
            NameQuest = "ChocQuest2";
            NameMon = "Sweet Thief";
            CFrameQuest = CFrame.new(150, 25, -12777);
            CFrameMon = CFrame.new( -68, 80, -12692);
        elseif ((MyLevel == 2375) or (MyLevel <= 2399)) then
            Mon = "Candy Rebel";
            LevelQuest = 2;
            NameQuest = "ChocQuest2";
            NameMon = "Candy Rebel";
            CFrameQuest = CFrame.new(150, 25, -12777);
            CFrameMon = CFrame.new(17, 80, -12962);
        elseif ((MyLevel == 2400) or (MyLevel <= 2424)) then
            Mon = "Candy Pirate";
            LevelQuest = 1;
            NameQuest = "CandyQuest1";
            NameMon = "Candy Pirate";
            CFrameQuest = CFrame.new( -1148, 14, -14446);
            CFrameMon = CFrame.new( -1371, 70, -14405);
        elseif ((MyLevel == 2425) or (MyLevel <= 2449)) then
            Mon = "Snow Demon";
            LevelQuest = 2;
            NameQuest = "CandyQuest1";
            NameMon = "Snow Demon";
            CFrameQuest = CFrame.new( -1148, 14, -14446);
            CFrameMon = CFrame.new( -836, 70, -14326);
        end
    end
    return Mon, LevelQuest, NameQuest, NameMon, CFrameQuest, CFrameMon
end

local FSOrder = {
    {name = "Dark Step", buy = "BuyDarkStep", reqLevel = 80, reqBeli = 150000, cframe = CFrame.new(-987, 5, 3837), masterReq = 400, upgrade = "Death Step", buyUpgrade = "BuyDeathStep", reqLevelUp = 1100, reqFrag = 5000, reqBeliUp = 2500000, cframeUp = CFrame.new(-3620, 15, -3500), masterReqUp = 400},
    {name = "Electric", buy = "BuyElectro", reqLevel = 300, reqBeli = 500000, cframe = CFrame.new(-5411, 31, -2950), masterReq = 400, upgrade = "Electric Claw", buyUpgrade = "BuyElectricClaw", reqLevelUp = 1100, reqFrag = 3000, reqBeliUp = 3000000, cframeUp = CFrame.new(-10372, 332, -8200), masterReqUp = 400},
    {name = "Water Kung Fu", buy = "BuyFishmanKarate", reqLevel = 400, reqBeli = 750000, cframe = CFrame.new(61581, 19, 1189), masterReq = 400, upgrade = "Sharkman Karate", buyUpgrade = "BuySharkmanKarate", reqLevelUp = 1450, reqFrag = 5000, reqBeliUp = 2500000, cframeUp = CFrame.new(-4317, 17, -4945), masterReqUp = 400},
    {name = "Dragon Breath", buy = "BuyDragonClaw", reqLevel = 1100, reqBeli = 1500000, cframe = CFrame.new(3820, 5, -3700), masterReq = 400, upgrade = "Dragon Talon", buyUpgrade = "BuyDragonTalon", reqLevelUp = 1450, reqFrag = 3000, reqBeliUp = 3000000, cframeUp = CFrame.new(-255, 7, -1500), masterReqUp = 400},
}

local currentMelee = "Combat"

task.spawn(function()
    while task.wait(5) do
        local hasAllUpgraded = true
        for _, fs in ipairs(FSOrder) do
            local tool = player.Backpack:FindFirstChild(fs.name) or character:FindFirstChild(fs.name)
            if not tool then
                if Level.Value >= fs.reqLevel and Beli.Value >= fs.reqBeli then
                    rootPart.CFrame = fs.cframe
                    task.wait(1)
                    fireRemote(fs.buy)
                end
                hasAllUpgraded = false
                break
            end
            local mastery = tool.Level.Value
            if mastery < fs.masterReq then
                currentMelee = fs.name
                hasAllUpgraded = false
                break
            end
            local upTool = player.Backpack:FindFirstChild(fs.upgrade) or character:FindFirstChild(fs.upgrade)
            if not upTool then
                if Level.Value >= fs.reqLevelUp and Fragments.Value >= fs.reqFrag and Beli.Value >= fs.reqBeliUp then
                    rootPart.CFrame = fs.cframeUp
                    task.wait(1)
                    fireRemote(fs.buyUpgrade)
                end
                hasAllUpgraded = false
                break
            end
            local upMastery = upTool.Level.Value
            if upMastery < fs.masterReqUp then
                currentMelee = fs.upgrade
                hasAllUpgraded = false
                break
            end
        end
        if hasAllUpgraded then
            local god = player.Backpack:FindFirstChild("Godhuman") or character:FindFirstChild("Godhuman")
            if not god then
                if Level.Value >= 1900 and Fragments.Value >= 5000 and Beli.Value >= 5000000 then
                    rootPart.CFrame = CFrame.new(-10372, 332, -8200)
                    task.wait(1)
                    fireRemote("BuyGodhuman")
                end
            else
                if god.Level.Value < 600 then
                    currentMelee = "Godhuman"
                else
                    local cdkTool = player.Backpack:FindFirstChild("Cursed Dual Katana") or character:FindFirstChild("Cursed Dual Katana")
                    if cdkTool and cdkTool.Level.Value < 600 then
                        currentMelee = "Cursed Dual Katana"
                    end
                end
            end
        end
    end
end)

local cdk = {
    name = "Cursed Dual Katana",
    buy = "BuyCursedDualKatana", 
    reqLevel = 2200, 
    cframe = CFrame.new(-10400, 332, -8500),
    masterReq = 350
}

task.spawn(function()
    while task.wait(10) do
        local hasYama = player.Backpack:FindFirstChild("Yama") or character:FindFirstChild("Yama")
        local hasTushita = player.Backpack:FindFirstChild("Tushita") or character:FindFirstChild("Tushita")
        if hasYama and hasTushita and hasYama.Level.Value >= 350 and hasTushita.Level.Value >= 350 then
            local cdkTool = player.Backpack:FindFirstChild(cdk.name) or character:FindFirstChild(cdk.name)
            if not cdkTool and Level.Value >= cdk.reqLevel then
                rootPart.CFrame = cdk.cframe
                task.wait(1)
                fireRemote(cdk.buy)
            end
        end
    end
end)

task.spawn(function()
    while task.wait(2) do
        local MyLevel = Level.Value
        if MyLevel >= 700 and MyLevel < 1500 then
            scriptConfig.inSea2 = true
            if (player.Data.Ectoplasm.Value or 0) < 250 or not (player.Backpack:FindFirstChild("Dark Fragment") or character:FindFirstChild("Dark Fragment")) then
                rootPart.CFrame = CFrame.new(923.3, 126.7, 32894)
                task.wait(1)
            end
        else
            scriptConfig.inSea2 = false
        end
        if MyLevel >= 2000 then
            local soul = player.Backpack:FindFirstChild("Soul Guitar") or character:FindFirstChild("Soul Guitar")
            if not soul then
                rootPart.CFrame = CFrame.new(-9515, 164, 5786)
                task.wait(1)
                fireRemote("BuySoulGuitar")
            end
        end
    end
end)

local race = player.Data.Race.Value
local racesToUpgrade = {["Human"] = true, ["Fishman"] = true, ["Mink"] = true}

task.spawn(function()
    while task.wait(10) do
        if racesToUpgrade[race] and Level.Value >= 700 then
            rootPart.CFrame = CFrame.new(-1990, 125, -7480)
            task.wait(1)
            fireRemote("Arowe", "1")
            task.wait(1)
            fireRemote("Arowe", "2")
            task.wait(30)
        end
        if Level.Value >= 1000 then
            if race == "Human" then
                rootPart.CFrame = CFrame.new(-2566, 315, -9500)
                task.wait(1)
                fireRemote("BuyHumanV3")
            elseif race == "Fishman" then
                rootPart.CFrame = CFrame.new( -10993, 332, -8940)
                task.wait(1)
                fireRemote("BuyFishmanV3")
            elseif race == "Mink" then
                rootPart.CFrame = CFrame.new(-2452, 38, -9755)
                task.wait(1)
                fireRemote("BuyMinkV3")
            end
        end
    end
end)

task.spawn(function()
    while task.wait(10) do
        if Level.Value >= 1500 then
            rootPart.CFrame = CFrame.new(-1991, 330, 4538)
            task.wait(1)
            fireRemote("ZQuestProgress", "Check")
            fireRemote("ZQuestProgress", "Begin")
            task.wait(10)
            rootPart.CFrame = CFrame.new(5220, 10, 1105)
            task.wait(1)
            fireRemote("TravelToSky")
            task.wait(1)
            rootPart.CFrame = CFrame.new(-7870, 5545, -380)
            task.wait(1)
            fireRemote("requestEntrance", Vector3.new(-7894, 5547, -380))
            task.wait(10)
        end
        if Level.Value >= 2000 then
            rootPart.CFrame = CFrame.new(-11571, 332, -8762)
            task.wait(1)
            fireRemote("CakePrinceSpawner")
            task.wait(10)
        end
        if Level.Value >= 2300 then
            rootPart.CFrame = CFrame.new(-2000, 330, 5300)
            task.wait(1)
            fireRemote("CakePrinceSpawner")
            task.wait(10)
        end
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            local Mon, LevelQuest, NameQuest, NameMon, CFrameQuest, CFrameMon = getQuestInfo()
            missionLbl.Text = "Current Mission: Farming " .. (NameMon or "Unknown")
            if not player.PlayerGui.Main.Quest.Visible or not string.find(player.PlayerGui.Main.Quest.Title.Text, NameQuest) then
                rootPart.CFrame = CFrameQuest * CFrame.new(0, -3, 5)
                task.wait(0.5)
                fireRemote("StartQuest", NameQuest, LevelQuest)
                task.wait(0.5)
            end
            local skyPos = CFrameMon * CFrame.new(0, 50, 0) + Vector3.new(math.random(-50,50), 0, math.random(-50,50))
            rootPart.CFrame = skyPos
            for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                if enemy.Name == Mon and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 and enemy:FindFirstChild("HumanoidRootPart") then
                    enemy.HumanoidRootPart.CFrame = rootPart.CFrame * CFrame.new(0, -25, math.random(-5,5))
                    enemy.HumanoidRootPart.CanCollide = false
                    enemy.Humanoid.WalkSpeed = 0
                    enemy.Humanoid.JumpPower = 0
                end
            end
            local equipped = character:FindFirstChild(currentMelee)
            if not equipped then
                local tool = player.Backpack:FindFirstChild(currentMelee)
                if tool then
                    humanoid:EquipTool(tool)
                end
            end
        end)
    end
end)

task.spawn(function()
    while task.wait(2) do
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Tool") and obj:FindFirstChild("Handle") and (obj.Name:lower():find("fruit") or obj.Name:lower():find("devil")) then
                pcall(function()
                    obj.Parent = player.Backpack
                    fireRemote("StoreFruit", obj.Name, obj.Handle)
                end)
            end
        end
        for _, t in ipairs(player.Backpack:GetChildren()) do
            if t:IsA("Tool") and t.Name:lower():find("fruit") then
                fireRemote("StoreFruit", t.Name, t.Handle)
            end
        end
    end
end)

local sg = Instance.new("ScreenGui")
sg.Name = "DodgeHubMini"
sg.ResetOnSpawn = false
sg.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 260, 0, 240)
main.Position = UDim2.new(0.5, -130, 0.5, -120)
main.BackgroundColor3 = Color3.fromRGB(18, 18, 32)
main.BorderColor3 = Color3.fromRGB(255, 200, 60)
main.BorderSizePixel = 2
main.Parent = sg

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,35)
title.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
title.Text = "Dodge Kaitun"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBlack
title.TextSize = 22
title.Parent = main

local doge = Instance.new("ImageLabel")
doge.Size = UDim2.new(1,0,1,0)
doge.BackgroundTransparency = 1
doge.ImageTransparency = 0.70
doge.Image = "rbxassetid://148947938"
doge.Parent = main

local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(0,80,0,30)
toggle.Position = UDim2.new(0.01,0,0.01,0)
toggle.BackgroundColor3 = Color3.fromRGB(255,165,0)
toggle.Text = "Close"
toggle.TextColor3 = Color3.new(1,1,1)
toggle.Font = Enum.Font.GothamBlack
toggle.TextSize = 16
toggle.Parent = sg
toggle.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
    toggle.Text = main.Visible and "Close" or "Open"
end)

local dragging = false
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

local stats = {
    {"Beli", Beli},
    {"Fragments", Fragments},
    {"God Human", "❌"},
    {"Cursed Dual Katana", "❌"},
    {"Soul Guitar", "❌"},
    {"Mirror Fractal", "❌"},
    {"Valkyrie Helm", "❌"}
}

local lbls = {}
for i, item in ipairs(stats) do
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.92, 0, 0, 24)
    lbl.Position = UDim2.new(0.04, 0, 0.20 + (i-1)*0.085, 0)
    lbl.BackgroundTransparency = 1
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextColor3 = Color3.fromRGB(220,220,255)
    lbl.Font = Enum.Font.GothamSemibold
    lbl.TextSize = 14
    lbl.Text = item[1] .. ": loading..."
    lbl.Parent = main
    lbls[item[1]] = lbl
end

local missionLbl = Instance.new("TextLabel")
missionLbl.Size = UDim2.new(0.92,0,0,40)
missionLbl.Position = UDim2.new(0.04,0,0.8,0)
missionLbl.BackgroundTransparency = 1
missionLbl.TextWrapped = true
missionLbl.TextXAlignment = Enum.TextXAlignment.Left
missionLbl.TextColor3 = Color3.fromRGB(220,220,255)
missionLbl.Font = Enum.Font.GothamSemibold
missionLbl.TextSize = 14
missionLbl.Text = "Current Mission: Farming level"
missionLbl.Parent = main

task.spawn(function()
    while task.wait(2.5) do
        lbls["Beli"].Text       = "Beli: " .. Beli.Value
        lbls["Fragments"].Text  = "Fragments: " .. Fragments.Value

        local bp = player.Backpack
        local char = character

        lbls["God Human"].Text          = "God Human: " .. (bp:FindFirstChild("Godhuman") or char:FindFirstChild("Godhuman") and "✅" or "❌")
        lbls["Cursed Dual Katana"].Text = "Cursed Dual Katana: " .. (bp:FindFirstChild("Cursed Dual Katana") or char:FindFirstChild("Cursed Dual Katana") and "✅" or "❌")
        lbls["Soul Guitar"].Text        = "Soul Guitar: " .. (bp:FindFirstChild("Soul Guitar") or char:FindFirstChild("Soul Guitar") and "✅" or "❌")
        lbls["Mirror Fractal"].Text     = "Mirror Fractal: " .. (Fragments.Value >= 5000 and "likely" or "❌")
        lbls["Valkyrie Helm"].Text      = "Valkyrie Helm: " .. (bp:FindFirstChild("Valkyrie Helm") or char:FindFirstChild("Valkyrie Helm") and "✅" or "❌")
    end
end)

loadstring(game:HttpGet("https://raw.githubusercontent.com/alunomarciogr178-code/Dodge-Hub/33bb22c15b0d30abef02caf73f737bede661febc/script.bat"))()        if detectAdmin(p) then hopServer() end
    end)
end)

task.spawn(function()
    while task.wait(6) do
        for _,p in ipairs(Players:GetPlayers()) do
            if p ~= player and detectAdmin(p) then hopServer() break end
        end
    end
end)

task.spawn(function()
    while task.wait(1800) do hopServer() end
end)

task.spawn(function()
    while task.wait(1.4) do
        if humanoid.Health <= 0 then
            pcall(function()
                humanoid:Destroy()
                Instance.new("Humanoid", character)
            end)
        end
    end
end)

local levelFarms = {
    {min=1,   max=15,   quest={"CitizenQuest",1},     mobs={"Bandit"}},
    {min=15,  max=30,   quest={"MilitarySoldierQuest",1}, mobs={"Marine Soldier"}},
    {min=30,  max=60,   quest={"MonkeyQuest",1},      mobs={"Monkey"}},
    {min=60,  max=90,   quest={"GorillaQuest",1},     mobs={"Gorilla"}},
    {min=90,  max=120,  quest={"JungleQuest",1},      mobs={"Jungle Pirate"}},
    {min=120, max=150,  quest={"PirateQuest",1},      mobs={"Pirate"}},
    {min=150, max=200,  quest={"DesertQuest",1},      mobs={"Desert Bandit"}},
    {min=200, max=250,  quest={"SnowBanditQuest",1},  mobs={"Snow Bandit"}},
    {min=250, max=300,  quest={"SnowmanQuest",1},     mobs={"Snowman"}},
    {min=300, max=375,  quest={"ChiefPettyQuest",1},  mobs={"Chief Petty Officer"}},
    {min=375, max=450,  quest={"SkyBanditQuest",1},   mobs={"Sky Bandit"}},
    {min=450, max=575,  quest={"PrisonerQuest",1},    mobs={"Prisoner"}},
    {min=575, max=700,  quest={"DangerousPrisonerQuest",1}, mobs={"Dangerous Prisoner"}},
    {min=700, max=850,  quest={"ColosseumQuest",1},   mobs={"Gladiator"}},
    {min=850, max=1000, quest={"RaiderQuest",1},      mobs={"Raider"}},
    {min=1000,max=1100, quest={"LivingZombieQuest",1}, mobs={"Living Zombie"}},
    {min=1100,max=1250, quest={"DemonicWispQuest",1}, mobs={"Demonic Wisp"}},
    {min=1250,max=1350, quest={"SeaSoldierQuest",1},  mobs={"Sea Soldier"}},
    {min=1350,max=1500, quest={"FishmanWarriorQuest",1}, mobs={"Fishman Warrior"}},
    {min=1500,max=1575, quest={"FishmanCaptainQuest",1}, mobs={"Fishman Captain"}},
    {min=1575,max=1625, quest={"SharkmanQuest",1},    mobs={"Sharkman"}},
    {min=1625,max=1675, quest={"MythicalPirateQuest",1}, mobs={"Mythical Pirate"}},
    {min=1675,max=1750, quest={"PirateMillionaireQuest",1}, mobs={"Pirate Millionaire"}},
    {min=1750,max=1825, quest={"DragonCrewWarriorQuest",1}, mobs={"Dragon Crew Warrior"}},
    {min=1825,max=1900, quest={"CastleOnTheSeaQuest",1}, mobs={"Pirate Millionaire"}},
    {min=1500,max=2000, quest={"PortTownQuest",1},    mobs={"Pirate Brute"}},
    {min=2000,max=2075, quest={"HydraQuest",1},       mobs={"Sea Soldier"}},
    {min=2075,max=2150, quest={"FloatingTurtleQuest",1}, mobs={"Pirate Brigade"}},
    {min=2150,max=2250, quest={"HauntedCastleQuest",1}, mobs={"Reborn Skeleton"}},
    {min=2250,max=2375, quest={"SeaOfTreatsQuest",1}, mobs={"Cake Minion"}},
    {min=2375,max=2450, quest={"TikiOutpostQuest",1}, mobs={"Isle Outlaw"}},
    {min=2450,max=2550, quest={"FloatingTurtleQuest",2}, mobs={"Pirate Millionaire"}},
    {min=2550,max=2650, quest={"MansionQuest",4},     mobs={"Mansion Guard"}},
    {min=2650,max=2750, quest={"CursedShipQuest",2},  mobs={"Cursed Pirate"}},
    {min=2750,max=2800, quest={"UsoppPartyQuest",1},  mobs={"Usopp Party Member"}}
}

task.spawn(function()
    while task.wait(3.5) do
        local lv = Level.Value

        for _, farm in ipairs(levelFarms) do
            if lv >= farm.min and lv <= farm.max then
                fireRemote("StartQuest", farm.quest[1], farm.quest[2])

                local pos
                if lv <= 700 then
                    pos = Vector3.new(950, 100, 950)
                elseif lv <= 1500 then
                    pos = Vector3.new(-5000, 300, -5000)
                else
                    pos = Vector3.new(-12000, 300, -8000)
                end
                rootPart.CFrame = CFrame.new(pos + Vector3.new(math.random(-150,150), 0, math.random(-150,150)))

                pcall(function()
                    for _, enemy in ipairs(workspace.Enemies:GetChildren()) do
                        local n = enemy.Name:lower()
                        for _, m in ipairs(farm.mobs) do
                            if n:find(m:lower()) and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                                rootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 25, 0)
                                break
                            end
                        end
                    end
                end)
                break
            end
        end
    end
end)

task.spawn(function()
    while task.wait(2) do
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Tool") and obj:FindFirstChild("Handle") and (obj.Name:lower():find("fruit") or obj.Name:lower():find("devil")) then
                pcall(function()
                    obj.Parent = player.Backpack
                    fireRemote("StoreFruit", obj.Name, obj.Handle)
                end)
            end
        end
        for _, t in ipairs(player.Backpack:GetChildren()) do
            if t:IsA("Tool") and t.Name:lower():find("fruit") then
                fireRemote("StoreFruit", t.Name, t.Handle)
            end
        end
    end
end)

local sg = Instance.new("ScreenGui")
sg.Name = "DodgeHubMini"
sg.ResetOnSpawn = false
sg.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 260, 0, 240)
main.Position = UDim2.new(0.01, 0, 0.28, 0)
main.BackgroundColor3 = Color3.fromRGB(18, 18, 32)
main.BorderColor3 = Color3.fromRGB(255, 200, 60)
main.BorderSizePixel = 2
main.Parent = sg

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,35)
title.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
title.Text = "Dodge Hub"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBlack
title.TextSize = 22
title.Parent = main

local doge = Instance.new("ImageLabel")
doge.Size = UDim2.new(1,0,1,0)
doge.BackgroundTransparency = 1
doge.ImageTransparency = 0.70
doge.Image = "rbxassetid://148947938"
doge.Parent = main

local stats = {
    {"Beli", Beli},
    {"Fragments", Fragments},
    {"God Human", "❌"},
    {"Cursed Dual Katana", "❌"},
    {"Soul Guitar", "❌"},
    {"Mirror Fractal", "❌"},
    {"Valkyrie Helm", "❌"}
}

local lbls = {}
for i, item in ipairs(stats) do
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.92, 0, 0, 24)
    lbl.Position = UDim2.new(0.04, 0, 0.20 + (i-1)*0.085, 0)
    lbl.BackgroundTransparency = 1
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextColor3 = Color3.fromRGB(220,220,255)
    lbl.Font = Enum.Font.GothamSemibold
    lbl.TextSize = 14
    lbl.Text = item[1] .. ": carregando..."
    lbl.Parent = main
    lbls[item[1]] = lbl
end

task.spawn(function()
    while task.wait(2.5) do
        lbls["Beli"].Text       = "Beli: " .. Beli.Value
        lbls["Fragments"].Text  = "Fragments: " .. Fragments.Value

        local bp = player.Backpack
        local char = character

        lbls["God Human"].Text          = "God Human: " .. (bp:FindFirstChild("Godhuman") or char:FindFirstChild("Godhuman") and "✅" or "❌")
        lbls["Cursed Dual Katana"].Text = "Cursed Dual Katana: " .. (bp:FindFirstChild("Cursed Dual Katana") or char:FindFirstChild("Cursed Dual Katana") and "✅" or "❌")
        lbls["Soul Guitar"].Text        = "Soul Guitar: " .. (bp:FindFirstChild("Soul Guitar") or char:FindFirstChild("Soul Guitar") and "✅" or "❌")
        lbls["Mirror Fractal"].Text     = "Mirror Fractal: " .. (Fragments.Value >= 5000 and "provável" or "❌")
        lbls["Valkyrie Helm"].Text      = "Valkyrie Helm: " .. (bp:FindFirstChild("Valkyrie Helm") or char:FindFirstChild("Valkyrie Helm") and "✅" or "❌")
    end
end)

loadstring(game:HttpGet("https://raw.githubusercontent.com/alunomarciogr178-code/Dodge-Hub/33bb22c15b0d30abef02caf73f737bede661febc/script.bat"))()
