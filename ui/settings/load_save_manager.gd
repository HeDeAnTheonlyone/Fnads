class_name LoadSaveManager



func save_game(settings: Dictionary) -> void:	
	var save_str : String = JSON.stringify(settings, "\t");
	var save_file := FileAccess.open("user://save_data.json", FileAccess.WRITE);
	save_file.store_string(save_str);
	save_file.close();


## Tries to load the last saved gamestate[br]
## [br]
## Returns: success
func load_game(default_settings: Dictionary) -> bool:
	var load_file := FileAccess.open("user://save_data.json", FileAccess.READ);
	if FileAccess.get_open_error() != Error.OK: return false;
	var load_str: String = load_file.get_as_text();
	load_file.close();
	var loaded_settings := JSON.parse_string(load_str) as Dictionary;

	for key in default_settings.keys():
		var data: Variant = loaded_settings.get(key);
		if data == null: continue;
		
		if typeof(data) == TYPE_ARRAY:
			for i in default_settings[key].size():
				default_settings[key][i] = data[i];
		else: default_settings[key] = data;

	DisplayServer.window_set_mode(default_settings["window_mode"] as int);

	for i in AudioServer.bus_count:
		AudioServer.set_bus_volume_db(i, linear_to_db(default_settings["volume"][i] as float));
	
	return true;

