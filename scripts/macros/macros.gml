//EDITOR MACROS
#macro INSTANCE_CAP 2000
#macro SIZE_CAP 16000
#macro TARGET_GAME_VERSION "X.X.X"

//Shortcut macros
#macro LEVEL_LAYER layer_get_id("LEVEL_LAYER")
#macro window_mouse_x window_mouse_get_x()
#macro window_mouse_y window_mouse_get_y()

enum TOOL {
	MOVE_CAMERA,
	EDIT,
	FILL,
	MANIPULATE_OBJECT,
	CONFIGURE
}