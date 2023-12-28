dimensions.py can contain a list of frames for example lever0 or door0
maps.py can contain "animatables" that points to this animation for example the_door or the_lever

js/functions.js the_door() uses h_shake() as well as set_texture with timeouts to replace the texture

socket.on("fx") handles triggering the_door() so that could potentially be used to trigger animations from the server side.
