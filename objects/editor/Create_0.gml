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
]

tool_edit_selected_tile = tiles[1]
tool_config_selected_tile = noone

mouse_in_editor = false

current_tool = TOOL.EDIT

current_level = {
	width: 320,
	height: 240,
	name: "My Level ",
	creator: "Layerformer Player",
	background: 0,
	backgroundcolor: make_color_hsv(255, 255, 255)
}

camera_mouse_x = -1
camera_mouse_y = -1
camera_zoom = 1
camera_mouse_drag = false