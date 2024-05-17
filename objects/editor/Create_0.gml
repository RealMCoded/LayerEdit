/// @description 
show_debug_log(debug_mode)
gridsnap = 16

tiles = [
	EDITOR_player_spawn,
	EDITOR_ground_tile,
	EDITOR_box
]

tiles_locale = [
	"Player Spawn",
	"Ground Tile",
	"Box"
]

tool_edit_selected_tile = tiles[1]
tool_config_selected_tile = noone

mouse_in_editor = false

current_tool = TOOL.EDIT
current_tool_manipulate = MANIPULATE_TOOL.MOVE

var _date = string_replace_all(date_date_string(date_current_datetime()), "/", "-")

var _time = string_replace_all(date_time_string(date_current_datetime()), ":", ".")

current_level = {
	width: 320,
	height: 240,
	name: $"Unamed Level {_date} {_time}",
	creator: "Layerformer Player",
	background: 0,
	backgroundcolor: make_color_hsv(255, 255, 255)
}

camera_mouse_x = -1
camera_mouse_y = -1
camera_zoom = 1
camera_mouse_drag = false

camera_set_view_pos(view_camera[0], -room_width, -room_height)