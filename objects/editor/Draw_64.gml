/// @description HUD
gpu_set_tex_mip_filter(tf_anisotropic)
draw_set_color(c_black)

#region HUD
draw_sprite_ext(spr_hud, 0, 0, 0, 18.28, 1.96, 0, c_white, 1)

for(var i=0; i < 10; i++)
{
	//draw_sprite_ext(spr_hud_btn, 0, 8+16 + (i * 64), 8+16, 0.78125, 0.78125, 0, c_white, 1)
	draw_sprite_ext(spr_hud, 0, 16 + (i * 64), 16, 1.3, 1.3, 0, c_white, 1)
	draw_sprite(spr_tools, i, 32 + (i * 64), 32)
	//draw_text(16 + (i * 64), 16, 16 + (i * 64))
}

#endregion

#region Sidebar
var _originX = 928+8
var _sidebar_title = "Sidebar"
var _sidebar_description = "Sidebar descriptions can be quite long, but please keep them short!"

draw_sprite_ext(spr_hud, 0, 928, 0, 7.08, 14.44, 0, c_white, 1)

function draw_item_select()
{
	var seperate = 1.25
	var rows = 4
	
	for(var i=0; i < array_length(tiles); i++)
	{
		var renderX = 64*((i%rows)*seperate)
		var renderY = 64*(floor(i/rows)*seperate)
		var _objSprite = object_get_sprite(tiles[i])
		
		draw_sprite(spr_hud_btn, tiles[i] == tool_edit_selected_tile, 928+16+renderX, 136+renderY)
		
		draw_sprite_ext(_objSprite, 0, 928+32+renderX+(sprite_get_xoffset(_objSprite)*2), 136+16+renderY+(sprite_get_yoffset(_objSprite)*2), 2, 2, 0, c_white, 1)
		
		if mouse_check_button_pressed(mb_left) and point_in_rectangle(window_mouse_x, window_mouse_y, 928+16+renderX, 136+renderY, 928+16+renderX+64, 136+renderY+64)
		{
			tool_edit_selected_tile = tiles[i]
		}
	}
}

switch current_tool
{
	case TOOL.MOVE_CAMERA:
	{
		var _sidebar_title = "Look Tool"
		var _sidebar_description = "Look around your level."
	} break;
	
	case TOOL.EDIT:
	{
		var _sidebar_title = "Draw Tool"
		var _sidebar_description = "Place with LMB, Delete with RMB."
		draw_item_select()
	} break;
	
	case TOOL.FILL:
	{
		var _sidebar_title = "Fill Tool"
		var _sidebar_description = "Fill an area with a selected tile."
		draw_item_select()
	} break;
	
	case TOOL.MANIPULATE_OBJECT:
	{
		var _sidebar_title = "Manipulation Tool"
		
		var _mode_instruct = "Select a tool to view instructions."
		
		if current_tool_manipulate == MANIPULATE_TOOL.MOVE
			_mode_instruct = "Move with the Arrow Keys"
		else if current_tool_manipulate == MANIPULATE_TOOL.ROTATE
			_mode_instruct = "Rotate with the left and right arrow keys"
		else if current_tool_manipulate == MANIPULATE_TOOL.SCALE
			_mode_instruct = "Scale with the Arrow Keys"
		
		var _sidebar_description = "Move, rotate, and scale tiles.\n\n" + _mode_instruct
		
		#region draw tools

		var seperate = 1.25
		var rows = 4
		var tools = [
			MANIPULATE_TOOL.MOVE,
			MANIPULATE_TOOL.ROTATE,
			MANIPULATE_TOOL.SCALE,
		]
	
		for(var i=0; i < array_length(tools); i++)
		{
			var renderX = 64*((i%rows)*seperate)
			var renderY = 64*(floor(i/rows)*seperate)
		
			draw_sprite(spr_hud_btn, tools[i] == current_tool_manipulate, 928+16+renderX, 136+renderY)
		
			draw_sprite_ext(spr_tools_manipulate, i, 928+32+renderX, 136+16+renderY, 1, 1, 0, c_white, 1)
		
			if mouse_check_button_pressed(mb_left) and point_in_rectangle(window_mouse_x, window_mouse_y, 928+16+renderX, 136+renderY, 928+16+renderX+64, 136+renderY+64)
			{
				current_tool_manipulate = tools[i]
			}
		}
		#endregion
		
		if instance_exists(tool_config_selected_tile)
		{
			var _inst = tool_config_selected_tile
			var _name = string_replace_all(object_get_name(_inst.object_index), "EDITOR_", "")
			_name = string_replace_all(_name, "_", " ")
			
			draw_text_ext(_originX+8, 210, $"{_name}\n\nid {_inst.id}\nx: {_inst.x}\ny: {_inst.y}\nxscale: {_inst.image_xscale}\nyscale: {_inst.image_yscale}\nrotation: {_inst.image_angle}", 16, 7 * 50)
		} else {
			draw_text_ext(_originX+8, 210, "No instance selected.\nClick on one to select it.", 16, 7 * 50)
		}
		
	} break;
	
	case TOOL.CONFIGURE:
	{
		var _sidebar_title = "Tile Edit Tool"
		var _sidebar_description = "Click on a tile to configure it."
	} break;
	
	case TOOL.CONFIGURE_LEVEL:
	{
		var _sidebar_title = "Configure Level"
		var _sidebar_description = "Configure your level."
	} break;
	
	case TOOL.HELP_MENU:
	{
		var _sidebar_title = "LayerEdit Help"
		var _sidebar_description = $"LayerEdit v{version}\nCompiled on {buildDate}\n\nThis is a placeholder help sidebar.\nIt will become a popup later :)"
	} break;
	
	default:
		var _sidebar_title = "INVALID ITEM"
		var _sidebar_description = "Somehow you are seeing this even though it should never happen.\n\nGet your sceenshots while you can."
	break;
}

draw_text_transformed(_originX+8, 8, _sidebar_title, 2, 2, 0)
draw_line_width_color(_originX+16, 64-8, 1280-20, 64-8, 1, c_black, c_black)
draw_text_ext(_originX+8, 64 + 6, _sidebar_description, 16, 7 * 50)

#endregion

//draw_text(8, 8, instance_count)
gpu_set_tex_mip_filter(tf_point)