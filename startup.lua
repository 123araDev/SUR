local monitors = { peripheral.find("monitor") }

while true do
  local time = math.floor((os.time() * 1000) % 24000)
  local hour = math.floor(time / 1000)
  local minute = math.floor((time % 1000) * 60 / 1000)
  local timeString = string.format("Heure Minecraft : %02d:%02d", hour, minute)

  for _, monitor in ipairs(monitors) do
    monitor.clear()
    monitor.setCursorPos(1, 1)
    monitor.write(timeString)
  end

  sleep(1)
end
