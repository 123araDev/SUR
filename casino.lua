local diskDrive = peripheral.find("drive")
local goldChest = peripheral.wrap("left")       -- Le coffre avec les blocs d'or
local jackpotChest = peripheral.wrap("right")   -- Le coffre avec les items rares

local rollCost = 10

local chance = {
    lose = 80,     -- 80%
    win = 18,      -- 18%
    jackpot = 2    -- 2%
}

function readCredits()
    if not diskDrive.hasData() then return nil end
    local path = diskDrive.getMountPath().."/cr.txt"
    if not fs.exists(path) then return nil end
    local f = fs.open(path, "r")
    local credit = tonumber(f.readLine())
    f.close()
    return credit
end

function writeCredits(amount)
    local path = diskDrive.getMountPath().."/cr.txt"
    local f = fs.open(path, "w")
    f.writeLine(tostring(amount))
    f.close()
end

function spinWheel()
    local roll = math.random(1, 100)
    if roll <= chance.jackpot then
        return "jackpot"
    elseif roll <= chance.jackpot + chance.win then
        return "win"
    else
        return "lose"
    end
end

function reward(result)
    if result == "win" then
        goldChest.pushItems("down", 1, 1)
    elseif result == "jackpot" then
        jackpotChest.pushItems("down", 1, 1)
    end
end

-- Boucle principale
while true do
    print("Insérez un disque avec cr.txt...")
    while not diskDrive.isDiskPresent() do os.sleep(1) end

    local credits = readCredits()
    if not credits then
        print("Fichier cr.txt invalide.")
        disk.eject("left")
        os.sleep(1)
    elseif credits < rollCost then
        print("Pas assez de crédits. Il faut au moins " .. rollCost)
        disk.eject("left")
        os.sleep(1)
    else
        print("Crédits : " .. credits .. " - Roue en cours...")
        local result = spinWheel()
        print("Résultat :", result)

        if result ~= "lose" then
            reward(result)
        else
            print("Dommage, vous avez perdu.")
        end

        credits = credits - rollCost
        writeCredits(credits)
        print("Nouveaux crédits :", credits)

        os.sleep(3)
        disk.eject("left")
    end
end
