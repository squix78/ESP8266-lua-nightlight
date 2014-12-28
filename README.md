ESP8266-lua-nightlight
======================

Nightlight for kids, written in Lua, to run on the nodemcu firmware for ESP8266. Connects to the defined access point and then synchronizes the time with google.com. Every 30 minutes the time gets synchronized to keep the precision. If a certain time is reached one of two LEDs connected to GPIO0 and GPIO2 gets turned on to either display a sun or a moon.

See the blog-post here: http://blog.squix.ch/2014/12/esp8266-internet-connected-baby.html

Thanks to GeoNomad for the Google Time Client code: http://www.esp8266.com/viewtopic.php?f=19&t=809
