/// @description HUD
draw_set_color(c_black)

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
		
		draw_sprite_ext(_objSprite, 0, 928+32+renderX-sprite_get_xoffset(_objSprite), 136+16+renderY-sprite_get_yoffset(_objSprite), 2, 2, 0, c_white, 1)
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