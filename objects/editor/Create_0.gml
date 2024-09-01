/// @description 
show_debug_log(debug_mode)
gridsnap = 16

tiles = [
	EDITOR_player_spawn,
	EDITOR_ground_tile,
	EDITOR_block_destructible,
	EDITOR_unstable_platform,
	EDITOR_box,
	EDITOR_explosive,
	EDITOR_jumpPad,
	EDITOR_spike,
	EDITOR_laser
]

tiles_locale = [
	"Player Spawn",
	"Ground Tile",
	"Destructible Ground",
	"Unstable Platform",
	"Box",
	"Explosive",
	"Jump Pad",
	"Spike",
	"Laser"
]

backgrounds = [
	spr_bg_tile_0,
	spr_bg_tile_1,
	spr_bg_tile_2,
	spr_bg_tile_3,
	spr_bg_tile_4,
	spr_bg_tile_5,
	spr_bg_tile_6,
	spr_bg_tile_7,
	spr_bg_tile_8,
	spr_bg_tile_9
]

tool_edit_selected_tile = tiles[1]
tool_config_selected_tile = noone

mouse_in_editor = false

//current_tool = TOOL.EDIT
current_tool = TOOL.EDIT
current_tool_manipulate = MANIPULATE_TOOL.MOVE

var _date = string_replace_all(date_date_string(date_current_datetime()), "/", "-")
var _time = string_replace_all(date_time_string(date_current_datetime()), ":", ".")

current_level = {
	width: 320,
	height: 240,
	name: $"Untitled {_date} {_time}",
	creator: "a Layerformer Player",
	description: "A very cool level",
	background: 0,
	backgroundcolor: #7FFFFF, //REPLACE WITH MAKE_COLOR_RGB
	tilesetcolor: #7FFFFF //REPLACE WITH MAKE_COLOR_RGB
}

camera_mouse_x = -1
camera_mouse_y = -1
camera_zoom = 1
camera_mouse_drag = false

camera_set_view_pos(view_camera[0], -room_width, -room_height)

///@param _tile Object Index (example: _tile.object_index)
function get_tile_name(_tile)
{
	var _name = $"!! {object_get_name(_tile.object_index)} !!" //default string if no translation is located
	
	for(var i=0; i < array_length(tiles); i++)
	{
		if tiles[i] == _tile.object_index
		{
			_name = tiles_locale[i]
			break;
		}
	}
	
	return _name
}

if debug_mode
{
	array_push(tiles, EDITOR_DebugInstance)
	array_push(tiles_locale, "Debug Tile for Debugging")
}