function save_level(_data)
{
	//Level data object
	var _level = {
		level_info: _data,
		tiles: []
	}
	
	//Loop through all instances
	for(var i=0; i < instance_count; i++)
	{
		var _tile = instance_id[i]
		
		if array_contains(editor.tiles, _tile.object_index) //check if its a valid object and save it.
		{
			//Getting instance variables
			var _vars = array_create(0)
			var _instVars = variable_instance_get_names(_tile);

			if array_length(_instVars) > 0
			{
				for (var j = 0; j < array_length(_instVars); j++)
				{
					_vars[j] = {
						name: _instVars[j],
						value: variable_instance_get(_tile, _instVars[j])
					}
				}
			}
			
			var _myTile = {
				tile: object_get_name(_tile.object_index),
				x: _tile.x,
				y: _tile.y,
				rotation: _tile.image_angle,
				xscale: _tile.image_xscale,
				yscale: _tile.image_yscale,
				vars: _vars
			}
			
			array_push(_level.tiles, _myTile)
		}
	}
	
	var _file_name = generateLevelFileName(_level.level_info.name)
	directory_create($"{LAYERFORMER_LEVEL_DIR}\\{_file_name}")
	
	if !file_exists($"{LAYERFORMER_LEVEL_DIR}\\{_file_name}\\icon.png")
		file_copy("./DefaultLevelIcon.png", $"{LAYERFORMER_LEVEL_DIR}\\{_file_name}\\icon.png")
	
	var _string = json_stringify(_level)
	var _buffer = buffer_create(string_byte_length(_string)+1, buffer_fixed, 1)
	buffer_write(_buffer, buffer_string, _string)
	buffer_save(_buffer, $"{LAYERFORMER_LEVEL_DIR}\\{_file_name}\\level.lf")
	return 1
}

function load_level(_file)
{
	var _buffer = buffer_load(_file)
	var _string = buffer_read(_buffer, buffer_string)
	buffer_delete(_buffer)
	
	var _data = json_parse(_string)
	
	editor.current_level = _data.level_info
	
	//loading tiles
	var _instance_count = array_length(_data.tiles)
	
	for(var i=0; i < _instance_count; i++)
	{
		var _tile = _data.tiles[i]
		var obj = asset_get_index(_tile.tile)
		
		var _newTile = instance_create_layer(_tile.x, _tile.y, LEVEL_LAYER, obj, {
			image_angle: _tile.rotation,
			image_xscale: _tile.xscale,
			image_yscale: _tile.yscale
		})
		
		var custom_vars = _tile.vars
		
		for(var j=0; j < array_length(custom_vars); j++)
		{
			_newTile[$ custom_vars[j].name] = custom_vars[j].value 
		}
	}
}

function generateLevelFileName(str) {
	var replaceSpace = "SPACECHARACTERTHISNAMEISLONGSONOONETYPESITBYMISTAKE"
	str = string_replace_all(str, " ", replaceSpace)
	return string_lower(string_replace_all(string_lettersdigits(str), replaceSpace, "_"))
}