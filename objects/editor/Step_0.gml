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

if (!camera_mouse_drag) {
	   if (mouse_check_button(mb_middle)) {
	      camera_mouse_drag = true;
		  var _viewX = camera_get_view_x(view_camera[0]);
		  var _viewY = camera_get_view_y(view_camera[0]);
		  
	      camera_mouse_x = _viewX - -window_mouse_get_x();
	      camera_mouse_y = _viewY - -window_mouse_get_y();

	   }
	} else {
	   var _x = -window_mouse_get_x() + camera_mouse_x;
	   var _y = -window_mouse_get_y() + camera_mouse_y
	   
	   camera_set_view_pos(view_camera[0], _x, _y)
	   
	   if (!mouse_check_button(mb_middle)) {
	      camera_mouse_drag = false;
	   }
	}
#endregion

if mouse_check_button(mb_left)
{
	if !instance_position(floor(mouse_x/gridsnap) * gridsnap, floor(mouse_y/gridsnap) * gridsnap, all)
	{
		instance_create_layer(floor(mouse_x/gridsnap) * gridsnap, floor(mouse_y/gridsnap) * gridsnap, LEVEL_LAYER, tile)
	}
}

if mouse_check_button(mb_right)
{
	if instance_position(floor(mouse_x/gridsnap) * gridsnap, floor(mouse_y/gridsnap) * gridsnap, all)
		{
			position_destroy(floor(mouse_x/gridsnap) * gridsnap, floor(mouse_y/gridsnap) * gridsnap)
		}
}

/*
	if mouse_check_button(mb_left)
	{
		if !instance_position(floor(mouse_x/gridsnap) * gridsnap, floor(mouse_y/gridsnap) * gridsnap, all)
		{
			instance_create_layer(floor(mouse_x/gridsnap) * gridsnap, floor(mouse_y/gridsnap) * gridsnap, LEVEL_LAYER, tile)
		}
	}
	
	if mouse_check_button(mb_right)
	{
		if instance_position(floor(mouse_x/gridsnap) * gridsnap, floor(mouse_y/gridsnap) * gridsnap, all)
		{
			position_destroy(floor(mouse_x/gridsnap) * gridsnap, floor(mouse_y/gridsnap) * gridsnap)
		}
}*/