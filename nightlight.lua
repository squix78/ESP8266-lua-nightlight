hour = 0
minute = 0
second = 0
lastUpdate = 1800
nightPin = 4
dayPin = 3
gpio.mode(nightPin,gpio.OUTPUT)
gpio.mode(dayPin,gpio.OUTPUT)

function getTime()
     if lastUpdate > 1800 then
          print("Getting time...")
          conn=net.createConnection(net.TCP, 0) 
          conn:on("receive", function(conn, payload)
               time = string.sub(payload,string.find(payload,"Date: ")+23,string.find(payload,"Date: ")+31)
               hour = string.sub(time, 0, 2) + 1
               minute = string.sub(time, 4,5) + 0
               second = string.sub(time, 7,9) + 0
               print(hour.."-"..minute.."-"..second)
               conn:close()
               lastUpdate = 0
               end) 
          conn:dns('google.com',function(conn,ip) ipaddr=ip end)
          conn:connect(80,ipaddr) 
          heap = node.heap()
          conn:send("HEAD / HTTP/1.1\r\n") 
          conn:send("Accept: */*\r\n") 
          conn:send("User-Agent: Mozilla/4.0 (compatible; ESP8266 NodeMcu Lua;)\r\n") 
          conn:send("\r\n")
     end 
end
function increaseTime()
     second = second + 1
     lastUpdate = lastUpdate + 1
     if second == 60 then
          second = 0
          minute = minute + 1
     end
     if minute == 60 then 
          minute = 0
          hour = hour + 1
     end
     if hour == 24 then
          hour = 0
     end
end
tmr.alarm(1, 1000, 1, function() 
     increaseTime()
     print(hour.."-"..minute.."-"..second..", "..lastUpdate)
     if hour>=7 and hour < 20 then
          gpio.write(nightPin,gpio.HIGH)
          gpio.write(dayPin,gpio.LOW)
     else 
          gpio.write(nightPin,gpio.LOW)
          gpio.write(dayPin,gpio.HIGH)
     end
end)
tmr.alarm(0, 3000, 1, function()
   ip = wifi.sta.getip()
   if ip=="0.0.0.0" or ip==nil then
      print("connecting to AP...") 
   else
      getTime()
   end
end)
