extends Node2D

var sound_level = -30.0;
@export var level1: PackedScene
@export var level2: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$main_menu.show()
	var settings = $PlayerProgress._get_config_data();
	
	if settings == null:
		$PlayerProgress._create_config()
		settings = $PlayerProgress._get_config_data()
		
	sound_level = settings["music_volume"]
	$main_menu/Sound_Slider.value = sound_level
	
	var curGame = $PlayerProgress.load_game()

	$main_menu/Level1_Score.text = "Current Level 1 Score: " + str(curGame["level1-score"])
	$main_menu/Level2_Score.text = "Current Level 2 Score: " + str(curGame["level2-score"])
	$Home_Music.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if($main_menu != null):
		sound_level = $main_menu/Sound_Slider.value
	$Home_Music.volume_db = sound_level
	$Level_Music.volume_db = sound_level
	$Level2_Music.volume_db = sound_level

func _on_save_config_button_pressed() -> void:
	$PlayerProgress._save_volume_data(sound_level)

func _on_level_1_button_pressed() -> void:
	_go_to_level(level1, $Level_Music)

func _on_level_2_button_pressed() -> void:
	_go_to_level(level2, $Level2_Music)

func _go_to_level(level, music) -> void:
	$main_menu.hide()
	var new_level = level.instantiate()
	$Current_Level.add_child(new_level);
	new_level.go_home.connect(self._go_to_main_level.bind());
	$Home_Music.stop()
	music.play()

func _go_to_main_level() -> void:
	for n in $Current_Level.get_children():
		$Current_Level.remove_child(n)
		n.queue_free();
	$Level2_Music.stop()
	$Level_Music.stop()
	$Home_Music.play()
	$main_menu.show()
