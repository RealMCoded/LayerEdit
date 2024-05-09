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
			var _myTile = {
				tile: object_get_name(_tile.object_index),
				x: _tile.x,
				y: _tile.y,
				rotation: _tile.image_angle,
				xscale: _tile.image_xscale,
				yscale: _tile.image_yscale
			}
			
			array_push(_level.tiles, _myTile)
		}
	}
	
	var _string = json_stringify(_level)
	var _buffer = buffer_create(string_byte_length(_string)+1, buffer_fixed, 1)
	buffer_write(_buffer, buffer_string, _string)
	buffer_save(_buffer, "testing.lf")
	
	return 1
}

function load_level(_file)
{
	return 0
}
