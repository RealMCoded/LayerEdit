//EDITOR MACROS
#macro INSTANCE_CAP 2000
#macro SIZE_CAP 16000
#macro TARGET_GAME_VERSION "X.X.X"
#macro version "0.1.0"
#macro buildDate date_date_string(GM_build_date) + " " + date_time_string(GM_build_date) //Do not change

//Shortcut macros
#macro LAYERFORMER_LEVEL_DIR $"{environment_get_variable("APPDATA")}\\Layerformer\\Levels"
#macro LEVEL_LAYER layer_get_id("LEVEL_LAYER")
#macro window_mouse_x window_mouse_get_x()
#macro window_mouse_y window_mouse_get_y()

enum TOOL {
	MOVE_CAMERA,
	EDIT,
	FILL,
	MANIPULATE_OBJECT,
	CONFIGURE,
	HELP_MENU //due to how the sidebar works it has to be a tool
}