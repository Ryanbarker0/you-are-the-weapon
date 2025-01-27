extends VBoxContainer

@onready var master_slider: HSlider = $Master/MarginContainer/HSlider
@onready var music_slider: HSlider = $Music/MarginContainer/HSlider
@onready var sfx_slider: HSlider = $SFX/MarginContainer/HSlider

func _ready():
	master_slider.value = Options.master_volume
	music_slider.value = Options.music_volume
	sfx_slider.value = Options.sfx_volume

func on_master_volume_changed(new_value:float):
	Options.master_volume = new_value
	
func on_music_volume_changed(new_value:float):
	Options.music_volume = new_value

func on_sfx_volume_changed(new_value:float):
	Options.sfx_volume = new_value
