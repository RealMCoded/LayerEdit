/// @description 

#region Camera Dragging

var _factor = 0.05;
var _mouseW = mouse_wheel_down() - mouse_wheel_up();
camera_zoom = clamp(camera_zoom + (_mouseW * _factor), _factor, 2);

var _viewH = camera_get_view_height(view_camera[0]);
var _lerpH = lerp(_viewH, camera_zoom * 720, _factor);
var _newH = clamp(_lerpH, 0, 720);
var _newW = _newH * (1280 / 720);
camera_set_view_size(view_camera[0], _newW, _newH);

var _mouseDown;
if current_tool == TOOL.MOVE_CAMERA
	_mouseDown = mouse_check_button(mb_left)
else
	_mouseDown = mouse_check_button(mb_middle)

if (!camera_mouse_drag) {
	   if (_mouseDown) {
	      camera_mouse_drag = true;
		  var _viewX = camera_get_view_x(view_camera[0]);
		  var _viewY = camera_get_view_y(view_camera[0]);
		  
	      camera_mouse_x = _viewX - -window_mouse_x*camera_zoom;
	      camera_mouse_y = _viewY - -window_mouse_y*camera_zoom;

	   }
	} else {
	   var _x = -window_mouse_x*camera_zoom + camera_mouse_x;
	   var _y = -window_mouse_y*camera_zoom + camera_mouse_y
	   
	   camera_set_view_pos(view_camera[0], _x, _y)
	   
	   if (!_mouseDown) {
	      camera_mouse_drag = false;
	   }
	}
#endregion

mouse_in_editor = point_in_rectangle(window_mouse_x, window_mouse_y, 0, 96, 912, 704)

if mouse_in_editor
{
	if current_tool == TOOL.EDIT
	{
		if mouse_check_button(mb_left)
		{
			if !instance_position(floor(mouse_x/gridsnap) * gridsnap, floor(mouse_y/gridsnap) * gridsnap, all)
			{
				instance_create_layer(floor(mouse_x/gridsnap) * gridsnap, floor(mouse_y/gridsnap) * gridsnap, LEVEL_LAYER, tool_edit_selected_tile)
			}
		}

		if mouse_check_button(mb_right)
		{
			if instance_position(floor(mouse_x/gridsnap) * gridsnap, floor(mouse_y/gridsnap) * gridsnap, all)
				{
					position_destroy(floor(mouse_x/gridsnap) * gridsnap, floor(mouse_y/gridsnap) * gridsnap)
				}
		}
	}
	else if current_tool == TOOL.FILL
	{
		if mouse_check_button(mb_left)
		{
			if !instance_position(floor(mouse_x/gridsnap) * gridsnap, floor(mouse_y/gridsnap) * gridsnap, all)
			{
				instance_create_layer(floor(mouse_x/gridsnap) * gridsnap, floor(mouse_y/gridsnap) * gridsnap, LEVEL_LAYER, filler, {tile: tool_edit_selected_tile})
			}
		}
	}
	else if current_tool == TOOL.MANIPULATE_OBJECT
	{
		if mouse_check_button_pressed(mb_left)
		{
			if instance_position(floor(mouse_x/gridsnap) * gridsnap, floor(mouse_y/gridsnap) * gridsnap, all)
			{
				tool_config_selected_tile = instance_position(floor(mouse_x/gridsnap) * gridsnap, floor(mouse_y/gridsnap) * gridsnap, all)
			}
		}
	}
} 
else
{
	if mouse_check_button_pressed(mb_left)
	{
		if point_in_rectangle(window_mouse_x, window_mouse_y, 16, 16, 66, 82) //Button 1 - Tool Camera
		{
			tool_config_selected_tile = noone
			current_tool = TOOL.MOVE_CAMERA
		}
		
		if point_in_rectangle(window_mouse_x, window_mouse_y, 80, 16, 80+50, 82) //Button 2 - Tool Edit
		{
			tool_config_selected_tile = noone
			current_tool = TOOL.EDIT
		}
		
		if point_in_rectangle(window_mouse_x, window_mouse_y, 144, 16, 144+50, 82) //Button 3 - Tool Fill
		{
			tool_config_selected_tile = noone
			current_tool = TOOL.FILL
		}
		
		if point_in_rectangle(window_mouse_x, window_mouse_y, 208, 16, 208+50, 82) //Button 4 - Tool Manipulate
		{
			current_tool = TOOL.MANIPULATE_OBJECT
		}
		
		if point_in_rectangle(window_mouse_x, window_mouse_y, 272, 16, 272+50, 82) //Button 5 - Tool Configure
		{
			current_tool = TOOL.CONFIGURE
		}
		
		if point_in_rectangle(window_mouse_x, window_mouse_y, 336, 16, 336+50, 82) //Button 6 - Tool Configure Level
		{
			tool_config_selected_tile = noone
			current_tool = TOOL.CONFIGURE_LEVEL
		}
		
		if point_in_rectangle(window_mouse_x, window_mouse_y, 400, 16, 400+50, 82) //Button 7 - Option Save
		{
			if !instance_exists(EDITOR_player_spawn)
				show_message("You need to place a player spawn point!")
			else
			{
				save_level(current_level)
				show_message("Your level was saved.")
			}
		}
		
		if point_in_rectangle(window_mouse_x, window_mouse_y, 464, 16, 464+50, 82) //Button 8 - Option Load
		{
			var _file = get_open_filename_ext("Layerformer Level (.lf)|*.lf", "", LAYERFORMER_LEVEL_DIR, "Select a Layerformer Level File");
			if _file != ""
			{
				with all {
					var _me = object_index
					if _me == editor || _me == camera break;
					instance_destroy()
				}
				
				try {
					load_level(_file)
					room_width = current_level.width
					room_height = current_level.height
				} catch(e)
				{
					show_debug_message($"Something bad happened. {e.longMessage}")
					show_message($"Error loading level.\n\n{e.message}")
				}
			}
		}
		
		if point_in_rectangle(window_mouse_x, window_mouse_y, 528, 16, 528+50, 82) //Button 9 - Option Test
		{
			show_message("The ability to test levels will release later.")
		}
		
		if point_in_rectangle(window_mouse_x, window_mouse_y, 592, 16, 592+50, 82) //Button 10 - Option Help
		{
			current_tool = TOOL.HELP_MENU
		}
	}
}

if current_tool == TOOL.MANIPULATE_OBJECT
{
if instance_exists(tool_config_selected_tile)
		{
			var _move_up = -keyboard_check_pressed(vk_up)
			var _move_down = keyboard_check_pressed(vk_down)
			var _move_left = -keyboard_check_pressed(vk_left)
			var _move_right = keyboard_check_pressed(vk_right)
			
			var _m_y = _move_up + _move_down
			var _m_x = _move_left + _move_right
				
			switch current_tool_manipulate
			{
				case MANIPULATE_TOOL.MOVE:
				{
					tool_config_selected_tile.x += _m_x * gridsnap
					tool_config_selected_tile.y += _m_y * gridsnap
				} break;
				
				case MANIPULATE_TOOL.ROTATE:
				{
					var _rotate = 0
					
					_rotate = -15 * _m_x
					
					tool_config_selected_tile.image_angle += _rotate
				} break;
					
				case MANIPULATE_TOOL.SCALE:
				{
					tool_config_selected_tile.image_xscale += _m_x
					tool_config_selected_tile.image_yscale += _m_y
					
					if tool_config_selected_tile.image_xscale == 0
					{
						if _m_x == -1 tool_config_selected_tile.image_xscale = -1
						if _m_x == 1 tool_config_selected_tile.image_xscale = 1
					}
					
					if tool_config_selected_tile.image_yscale == 0
					{
						if _m_y == -1 tool_config_selected_tile.image_yscale = -1
						if _m_y == 1 tool_config_selected_tile.image_yscale = 1
					}
				} break;
			}
		}	
}