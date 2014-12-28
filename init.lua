print('init.lua ver 1.2')
wifi.setmode(wifi.STATION)
print('set mode=STATION (mode='..wifi.getmode()..')')
print('MAC: ',wifi.sta.getmac())
print('chip: ',node.chipid())
print('heap: ',node.heap())
-- wifi config start
wifi.sta.config(“SSID”,”PASSWORD)
-- wifi config end
print(wifi.sta.getip())
tmr.alarm(0, 3000, 1, function()
   ip = wifi.sta.getip()
   if ip=="0.0.0.0" or ip==nil then
      print("connecting to AP...") 
   else
      tmr.stop(0)
      print(wifi.sta.getip())
      dofile("nightlight.lua")
   end
end)

