local modemSide = "left"  -- modem filaire ici
local redstoneSide = "right"  -- redstone branchée ici
local channel = 12

-- Ouvre le modem
rednet.open(modemSide)

print("Attente du signal...")

while true do
  local id, msg = rednet.receive(channel)
  if msg == "unlock" then
    print("Déverrouillage reçu.")
    redstone.setOutput(redstoneSide, true)
    os.sleep(0.05)
    redstone.setOutput(redstoneSide, false)
  end
end

