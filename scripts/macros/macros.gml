#macro LEVEL_LAYER layer_get_id("LEVEL_LAYER")

#macro window_mouse_x window_mouse_get_x()
#macro window_mouse_y window_mouse_get_y()

enum COMPONENT_TYPE
{
	TEXT,
	SEPERATOR,
	TEXT_INPUT,
	CHECK_BOOL,
	
}

enum TOOL {
	MOVE_CAMERA,
	EDIT,
	FILL,
	MANIPULATE_OBJECT,
	CONFIGURE
}