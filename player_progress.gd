extends Node
var SAVE_PATH = "user://save_file.json"

func _create_config() -> void:
	var config = ConfigFile.new()
	config.set_value("volume", "music", -10.0)
	config.save("user://settings.cfg")
	
func _get_config_data():
	var settings = {}
	var config = ConfigFile.new()

	var err = config.load("user://settings.cfg")

	if err != OK:
		return
	
	settings["music_volume"] = config.get_value("volume", "music")
	return settings;
	
func _save_volume_data(volume) -> void:
	var config = ConfigFile.new()
	config.set_value("volume", "music", volume)
	config.save("user://settings.cfg")

func new_game():
	var game_progress = {
		"level1-score": 0,
		"level2-score": 0
	}
	return game_progress

func _save_game(level1_score, level2_score) -> void:
	var save_file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var save_dict = {
		"level1-score": level1_score,
		"level2-score": level2_score
	}
	save_file.store_line(JSON.stringify(save_dict))
	
func load_game():
	if not FileAccess.file_exists(SAVE_PATH):
		print("yo")
		return new_game()
	var load_file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json = JSON.new()
	json.parse(load_file.get_line())
	var save_dict = json.get_data() as Dictionary
	load_file.store_line(JSON.stringify(save_dict))
	return save_dict
