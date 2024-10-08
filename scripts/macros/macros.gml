//EDITOR MACROS
#macro INSTANCE_CAP 2002 //Cap + 2 because of the editor and camera objects
#macro SIZE_CAP 16000
#macro version "0.1.0"
#macro file_version 1 //increment when major things happen. 
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
	CONFIGURE_LEVEL,
	HELP_MENU //due to how the sidebar works it has to be a tool
}

enum MANIPULATE_TOOL {
	MOVE,
	ROTATE,
	SCALE
}