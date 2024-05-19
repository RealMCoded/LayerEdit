/// @description Grid lines
// X
for(var i=0; i<= room_height; i+=gridsnap) {
	draw_set_color(c_gray)
	draw_line(0, i-1, room_width, i-1);
}

// Y
for(var i=0; i<= room_width; i+=gridsnap) {
	draw_set_color(c_gray)
	draw_line(i-1, 0, i-1, room_height);
}

draw_rectangle_color(0, 0, room_width, room_height, c_red, c_red, c_red, c_red, true)

if mouse_in_editor && current_tool == TOOL.EDIT draw_sprite_ext(object_get_sprite(tool_edit_selected_tile), 0, floor(mouse_x/gridsnap) * gridsnap, floor(mouse_y/gridsnap) * gridsnap, 1, 1, 0, c_white, 0.5)

draw_text_color(0, -24, $"{room_width}x{room_height}", c_white, c_white, c_white, c_white, 0.25)

if instance_exists(tool_config_selected_tile)
{
	with tool_config_selected_tile
	{
		draw_rectangle_color(x, y, x+(image_xscale*16)-1, y+(image_yscale*16)-1, c_red, c_red, c_red, c_red, true)
	}
}