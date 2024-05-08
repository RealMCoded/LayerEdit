/// @description HUD

draw_set_color(c_black)
draw_text(32, 64, instance_count)

#region HUD
draw_sprite_ext(spr_hud, 0, 0, 0, 18.28, 1.96, 0, c_white, 1)

for(var i=0; i < 8; i++)
{
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
	} break;
	
	case TOOL.FILL:
	{
		var _sidebar_title = "Fill Tool"
		var _sidebar_description = "Fill an area with a selected tile."
	} break;
	
	case TOOL.MANIPULATE_OBJECT:
	{
		var _sidebar_title = "Manipulation Tool"
		var _sidebar_description = "Move, rotate, and scale tiles."
	} break;
	
	case TOOL.CONFIGURE:
	{
		var _sidebar_title = "Configure Tool"
		var _sidebar_description = "Configure tiles or the level."
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