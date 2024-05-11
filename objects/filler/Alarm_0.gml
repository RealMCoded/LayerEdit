/// @description 
if !place_meeting(x, y+1, all) instance_create_layer(x, y+16, layer, filler, {tile})
if !place_meeting(x, y-1, all) instance_create_layer(x, y-16, layer, filler, {tile})
if !place_meeting(x+1, y, all) instance_create_layer(x+16, y, layer, filler, {tile})
if !place_meeting(x-1, y, all) instance_create_layer(x-16, y, layer, filler, {tile})

instance_create_layer(x,y,layer,tile)

instance_destroy()