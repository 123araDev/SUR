-- Configuration
local password = "azerty123"
local diskSide = "back"
local modemSide = "left"  -- modem filaire connecté ici
local channel = 12

-- Ouvre le modem
rednet.open(modemSide)

while true do
  if disk.isPresent(diskSide) and fs.exists("/disk/ccc.txt") then
    local f = fs.open("/disk/ccc.txt", "r")
    local input = f.readAll()
    f.close()

    input = string.gsub(input, "\n", "") -- nettoyage

    if input == password then
      print("Mot de passe correct !")

      -- Envoie un message via rednet à tous les ordinateurs sur le canal
      rednet.broadcast("unlock", channel)

      -- Éjecte le disque
      disk.eject(diskSide)
    else
      print("Mot de passe incorrect.")
    end

    sleep(1)
  else
    sleep(0.5)
  end
end
