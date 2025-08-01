local monitor = peripheral.find("monitor")
monitor.setTextScale(3) -- Grande taille
monitor.setBackgroundColor(colors.black)

while true do
    -- Heure Minecraft
    local time = math.floor((os.time() * 1000) % 24000)
    local hour = math.floor(time / 1000)
    local minute = math.floor((time % 1000) * 60 / 1000)
    local timeStr = string.format("%02d:%02d", hour, minute)

    monitor.clear()

    -- Affichage de l'heure
    monitor.setCursorPos(2, 2)
    monitor.setTextColor(colors.white)
    monitor.write(timeStr)

    -- Affichage du message
    local w, h = monitor.getSize()
    local message = "Welcome to Chatty Corp"
    monitor.setCursorPos(math.floor((w - #message) / 2) + 1, h)
    monitor.setTextColor(colors.green)
    monitor.setTextScale(1) -- Texte normal pour bas
    monitor.write(message)

    monitor.setTextScale(3) -- Revenir à grand pour l'heure
    sleep(1)
end
