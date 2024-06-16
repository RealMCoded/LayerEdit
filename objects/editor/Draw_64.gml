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
var _originX = 936
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
		var _sidebar_title = "Tile Config Tool"
		var _sidebar_description = "Change tile specific variables"
		
		if instance_exists(tool_config_selected_tile)
		{
			var _inst = tool_config_selected_tile
			var _name = string_replace_all(object_get_name(_inst.object_index), "EDITOR_", "")
			_name = string_replace_all(_name, "_", " ")
			
			draw_text_ext(_originX+8, 128, $"{_name}\nid {_inst.id}", 16, 7 * 50)
			
			#region Drawing variables
			var _instVars = variable_instance_get_names(_inst);

			if array_length(_instVars) > 0
			{
				for (var j = 0; j < array_length(_instVars); j++)
				{
					var _myvar = variable_instance_get(_inst, _instVars[j])
					
					switch (typeof(_myvar))
					{
						case "bool":
						{
							draw_text(_originX+8, 192+(j*48), _instVars[j])
							draw_sprite_ext(spr_hud_btn, 0, _originX + string_width($"{_instVars[j]}") + 16, 186+(j*48), 0.5, 0.5, 0, c_white, 1)
							if _myvar draw_sprite(spr_check, 0, _originX + string_width($"{_instVars[j]}") + 16, 186+(j*48))
							
							//mouse click
							if point_in_rectangle(window_mouse_x, window_mouse_y, _originX + string_width($"{_instVars[j]}") + 16, 186+(j*48), _originX + string_width($"{_instVars[j]}") + 48, 186+(j*48)+32) && mouse_check_button_pressed(mb_left)
							{
								variable_instance_set(_inst, _instVars[j], !_myvar)
							}
						} break;
						
						case "string":
						{
							var _text_width = max(string_width(_instVars[j]), string_width(_myvar))
							
							draw_sprite_ext(spr_hud_btn_9slice, 0, _originX+6, 186+(j*48), _text_width/64, 0.75, 0, c_white, 1)
							draw_text(_originX+8, 192+(j*48), $"{_instVars[j]}\n{_myvar}")
							
							//mouse click
							if point_in_rectangle(window_mouse_x, window_mouse_y, _originX, 186+(j*48), _originX + _text_width, 186+(j*48)+32) && mouse_check_button_pressed(mb_left)
							{
								variable_instance_set(_inst, _instVars[j], get_string($"Edit variable {_instVars[j]}", _myvar))
							}
						} break;
						
						case "number":
						{
							var _text_width = string_width($"{_instVars[j]} = {_myvar}")
							
							draw_sprite_ext(spr_hud_btn_9slice, 0, _originX+6, 186+(j*48), _text_width/64, 0.5, 0, c_white, 1)
							draw_text(_originX+8, 192+(j*48), $"{_instVars[j]} = {_myvar}")
							
							//mouse click
							if point_in_rectangle(window_mouse_x, window_mouse_y, _originX, 186+(j*48), _originX + _text_width, 186+(j*48)+32) && mouse_check_button_pressed(mb_left)
							{
								variable_instance_set(_inst, _instVars[j], get_integer($"Edit variable {_instVars[j]}", _myvar))
							}
						} break;
						
						default:
						{
							draw_text(_originX+8, 192+(j*48), $"{_instVars[j]} : {variable_instance_get(_inst, _instVars[j])} [??? / {typeof(variable_instance_get(_inst, _instVars[j]))}]")
						} break;
					}
				}
			} else {
				draw_text(_originX+8, 158, $"{_name} doesn't have any variables.")
			}
			#endregion
		} else {
			draw_text_ext(_originX+8, 128, "No instance selected.\nClick on one to select it.", 16, 7 * 50)
		}
		
	} break;
	
	case TOOL.CONFIGURE_LEVEL:
	{
		var _sidebar_title = "Configure Level"
		var _sidebar_description = "Configure your level."
			
		#region Level Size
			
		draw_text(_originX+8, 100, "Room Size")
		
		draw_sprite_ext(spr_hud_btn_9slice, 0, _originX+6, 132, 1.05, 0.5, 0, c_white, 1)
		draw_sprite_ext(spr_hud_btn_9slice, 0, _originX+96, 132, 1.05, 0.5, 0, c_white, 1)
		
		draw_text( _originX+12, 132+7, current_level.width)
		draw_text(_originX+80, 132+7, "X")
		draw_text( _originX+102, 132+7, current_level.height)
		
		//Width Button
		if point_in_rectangle(window_mouse_x, window_mouse_y, _originX+6, 132, (_originX+6)*1.05, 152 ) && mouse_check_button_pressed(mb_left)
		{
			var _input = get_integer("Set Level Width", current_level.width)
			
			if _input > SIZE_CAP or _input <= 31
				return show_message($"The size \"{_input}\" is invalid.")
			
			current_level.width = _input
			room_width = _input
		}
		
		//Height Button
		if point_in_rectangle(window_mouse_x, window_mouse_y, _originX+96, 132, (_originX+96)*1.05, 152) && mouse_check_button_pressed(mb_left)
		{
			var _input = get_integer("Set Level Height", current_level.height)
			
			if _input > SIZE_CAP or _input <= 31
				return show_message($"The size \"{_input}\" is invalid.")
			
			current_level.height = _input
			room_height = _input
		}
		#endregion
		
		#region Level Info
			
			#region Level Name
			draw_text(_originX+8, 176, "Level Name")
			
			var _text_width = string_width(current_level.name)
							
			draw_sprite_ext(spr_hud_btn_9slice, 0, _originX+6, 200, _text_width/64, 0.5, 0, c_white, 1)
			draw_text(_originX+8, 208, current_level.name)
							
			//mouse click
			if point_in_rectangle(window_mouse_x, window_mouse_y, _originX, 200, _originX + _text_width, 232) && mouse_check_button_pressed(mb_left)
			{
				var _input = get_string($"Edit Level Name (must be between 3 - 32 characters)", current_level.name)
				
				if string_length(_input) < 3
					show_message($"The name \"{_input}\" is too short!\nLevel names must be between 3 - 32 characters.")
				else if string_length(_input) > 32
					show_message($"The name \"{_input}\" is too long!\nLevel names must be between 3 - 32 characters. (You are over by {string_length(_input) - 32})")
				else
					current_level.name = _input
			}
			#endregion
			
			#region Level Creator
			draw_text(_originX+8, 248, "Creator")
			
			var _text_width = string_width(current_level.creator)
							
			draw_sprite_ext(spr_hud_btn_9slice, 0, _originX+6, 272, _text_width/64, 0.5, 0, c_white, 1)
			draw_text(_originX+8, 280, current_level.creator)
							
			//mouse click
			if point_in_rectangle(window_mouse_x, window_mouse_y, _originX, 272, _originX + _text_width, 304) && mouse_check_button_pressed(mb_left)
			{
				var _input = get_string($"Edit Level Creator (must be between 3 - 32 characters)", current_level.creator)
				
				if string_length(_input) < 3
					show_message($"The name \"{_input}\" is too short!\nLevel names must be between 3 - 32 characters.")
				else if string_length(_input) > 32
					show_message($"The name \"{_input}\" is too long!\nLevel names must be between 3 - 32 characters. (You are over by {string_length(_input) - 32})")
				else
					current_level.creator = _input
			}
			#endregion
			
			#region Level Bio
			#endregion
			
		#endregion
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