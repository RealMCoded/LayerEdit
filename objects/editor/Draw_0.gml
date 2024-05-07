/// @description Grid lines
for(var i=0; i<= room_height; i+=gridsnap) {
	draw_set_color(c_gray)
	draw_line(0, i-1, room_width, i-1);
}
	
for(var i=0; i<= room_width; i+=gridsnap) {
	draw_set_color(c_gray)
	draw_line(i-1, 0, i-1, room_height);
}

draw_rectangle_color(0, 0, room_width, room_height, c_red, c_red, c_red, c_red, true)

draw_sprite(spr_exampleTile, 0, floor(mouse_x/gridsnap) * gridsnap, floor(mouse_y/gridsnap) * gridsnap)
draw_text_color(8, 8, $"{room_width}x{room_height}", c_white, c_white, c_white, c_white, 0.25)